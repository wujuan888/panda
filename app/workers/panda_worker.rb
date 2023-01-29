class PandaWorker
  include Sidekiq::Worker
  sidekiq_options queue: :panda_high, retry: 1, backtrace: true

  # type 0   熊猫新增
  # content  gender
  #          place_id
  #
  # type 1   熊猫性别修改
  # content  old_gender
  #          gender
  #          old_place_id
  #          place_id
  #
  # type 2   熊猫入住兽舍
  #          place_id
  #          old: [[place_id, states], [place_id, states]]
  #
  # type 10  熊猫出租
  # content  flag
  # 
  # type 20  熊猫怀孕
  # content  flag
  # 
  # type 30  熊猫生病
  # content  flag
  #
  # type 40  删除熊猫
  # content  gender
  #          is_ill
  #          is_lease
  #          is_pregnant
  def perform(type, content)
    puts "PandaWorker::perform type:#{type} content:#{content}"
    case type
    when 0
      add_panda(0, content)
      add_panda(content[:place_id], content)
    when 1
      record = PandaRecord.with_place(0).last
      record = PandaRecord.create(place_id: 0) if record.blank?
      change_gender(record, content)
      if content[:place_id].to_i.positive?
        record = PandaRecord.with_place(content[:place_id]).last
        record = PandaRecord.create(place_id: content[:place_id]) if record.blank?
        change_gender(record, content)
      end
      if content[:old_place_id].to_i.positive?
        record = PandaRecord.with_place(content[:old_place_id]).last
        record = PandaRecord.create(place_id: content[:old_place_id]) if record.blank?
        change_gender(record, content)
      end

    when 10
      record = PandaRecord.last
      record = PandaRecord.create if record.blank?
      record.with_lock do
        if content['flag']
          record.lease_count += 1
        else
          record.lease_count -= 1
        end
        record.save!
      end

    when 20
      record = PandaRecord.last
      record = PandaRecord.create if record.blank?
      record.with_lock do
        if content['flag']
          record.pregnant_count += 1
        else
          record.pregnant_count -= 1
        end
        record.save!
      end
    when 30
      record = PandaRecord.last
      record = PandaRecord.create if record.blank?
      record.with_lock do
        if content['flag']
          record.ill_count += 1
        else
          record.ill_count -= 1
        end
        record.save!
      end
    when 40
      record = PandaRecord.last
      record = PandaRecord.create if record.blank?
      record.with_lock do
        record.count -= 1
        record.ill_count -= 1 if content['is_ill']
        record.pregnant_count -= 1 if content['is_pregnant']
        record.lease_count -= 1 if content['is_lease']
        if content['gender'].to_i == 1
          record.f_count -= 1
        else
          record.m_count -= 1
        end
        record.save!
      end
    end
    puts 'PandaWorker::perform ok'
  rescue StandardError => e
    puts "PandaWorker::perform error: #{e.message}"
  end

  def add_panda(place_id, content)
    record = PandaRecord.with_place(place_id).last
    record = PandaRecord.create(place_id: place_id) if record.blank?
    record.with_lock do
      record.count += 1
      if content['gender'].to_i == 1
        record.f_count += 1
      else
        record.m_count += 1
      end
      record.save!
    end
  end

  def change_gender(record, content)
    record.with_lock do
      if content['old_gender'].to_i == 1
        record.f_count -= 1
      else
        record.m_count -= 1
      end
      if content['gender'].to_i == 1
        record.f_count += 1
      else
        record.m_count += 1
      end
      record.save!
    end
  end
end
