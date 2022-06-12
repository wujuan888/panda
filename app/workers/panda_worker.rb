class PandaWorker
  include Sidekiq::Worker
  sidekiq_options queue: :panda_high, retry: 1, backtrace: true

  # type 0   熊猫新增
  # content  gender
  # 
  # type 1   熊猫性别修改
  # content  old_gender
  #          gender
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
      record = PandaRecord.last
      record = PandaRecord.create if record.blank?
      record.with_lock do
        record.count += 1
        if content['gender'].to_i == 1
          record.f_count += 1
        else
          record.m_count += 1
        end
        record.save!
      end
    when 1
      record = PandaRecord.last
      record = PandaRecord.create if record.blank?
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
end
