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
  #          states
  #
  # type 2   熊猫入住兽舍
  #          place_id
  #          old: [[place_id, states, gender], [place_id, states, gender]]
  #
  # type 3   熊猫迁移
  #          place_id
  #          old_place_id
  #          gender
  #          states
  #
  # type 10  熊猫特殊状态 修改
  # content  place_id
  #          gender
  #          states
  #          old_states
  #
  # type 40  删除熊猫
  # content  place_id
  #          gender
  #          states
  def perform(type, content)
    puts "PandaWorker::perform type:#{type} content:#{content}"

    case type
    when 0
      panda_count_zero?
      panda_count(content['place_id'].to_i) if content['place_id'].to_i.positive?
    when 1
      panda_count_zero?
      panda_count(content['place_id'].to_i) if content['place_id'].to_i.positive?
      if content['place_id'] != content['old_place_id']
        panda_count(content['old_place_id'].to_i) if content['old_place_id'].to_i.positive?
      end

    when 2
      panda_count_zero?
      panda_count(content['place_id'].to_i) if content['place_id'].to_i.positive?
      content['old'].each do |item|
        next if item[0].to_i == content['place_id'].to_i

        panda_count(item['0'].to_i) if item['0'].to_i.positive?
      end
    when 3
      panda_count_zero?
      panda_count(content['place_id'].to_i) if content['place_id'].to_i.positive?
      panda_count(content['old_place_id'].to_i) if content['old_place_id'].to_i.positive?
    when 10
      panda_count_zero?
      panda_count(content['place_id'].to_i) if content['place_id'].to_i.positive?
    when 40
      panda_count_zero?
      panda_count(content['place_id'].to_i) if content['place_id'].to_i.positive?
    end
    puts 'PandaWorker::perform ok'
  rescue StandardError => e
    puts "PandaWorker::perform error: #{e.message}"
  end

  def place_item(place_id)
    record = PandaRecord.with_place(place_id).last
    record = PandaRecord.create(place_id: place_id) if record.blank?
    record
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

  def panda_count_zero?
    record = PandaRecord.with_place(0).last
    record = PandaRecord.create(place_id: 0) if record.blank?
    all = Panda.with_live.pluck('gender', 'states')
    data = { count: 0, lease_count: 0, f_count: 0, m_count: 0, pei_zhong_count: 0, fa_qin_count: 0,
             dai_zai_count: 0, ill_count: 0 }
    all.each do |item|
      states = item[1].to_s
      if states.include? '租赁'
        data[:lease_count] += 1
      else
        data[:count] += 1
        if item[0].to_i == 1
          data[:f_count] += 1
        else
          data[:m_count] += 1
        end
        data[:pei_zhong_count] += 1 if states.include? '配种'
        data[:fa_qin_count] += 1 if states.include? '发情'
        data[:dai_zai_count] += 1 if states.include? '带仔'
        data[:ill_count] += 1 if states.include? '生病'
      end
    end
    record.with_lock do
      record.update(data)
    end
  end

  def panda_count(place_id)
    record = PandaRecord.with_place(place_id).last
    record = PandaRecord.create(place_id: place_id) if record.blank?
    all = if place_id.zero?
            Panda.with_live.pluck('gender', 'states')
          else
            Panda.with_place(place_id).with_live.pluck('gender', 'states')
          end
    data = { count: 0, lease_count: 0, f_count: 0, m_count: 0, pei_zhong_count: 0, fa_qin_count: 0,
             dai_zai_count: 0, ill_count: 0 }
    all.each do |item|
      states = item[1].to_s
      if states.include? '租赁'
        data[:lease_count] += 1
      else
        data[:count] += 1
        if item[0].to_i == 1
          data[:f_count] += 1
        else
          data[:m_count] += 1
        end
        data[:pei_zhong_count] += 1 if states.include? '配种'
        data[:fa_qin_count] += 1 if states.include? '发情'
        data[:dai_zai_count] += 1 if states.include? '带仔'
        data[:ill_count] += 1 if states.include? '生病'
      end
    end
    record.with_lock do
      record.update(data)
    end
  end

  # 租赁 配种 发情 带仔 生病
  # #  dai_zai_count(带仔数量)   :integer          default(0)
  # #  f_count(雄性数量)         :integer          default(0)
  # #  fa_qin_count(发情数量)    :integer          default(0)
  # #  ill_count(生病数量)       :integer          default(0)
  # #  lease_count(租借数量)     :integer          default(0)
  # #  m_count(雌性数量)         :integer          default(0)
  # #  pei_zhong_count(配种数量) :integer          default(0)
  # #  pregnant_count(怀孕数量)  :
  def sub_all(record, states, gender)
    record.with_lock do
      if states.include? '租赁'
        record.lease_count -= 1
      else
        record.count -= 1
        if gender.to_i == 1
          record.f_count -= 1
        else
          record.m_count -= 1
        end
        record.pei_zhong_count -= 1 if states.include? '配种'
        record.fa_qin_count -= 1 if states.include? '发情'
        record.dai_zai_count -= 1 if states.include? '带仔'
        record.ill_count -= 1 if states.include? '生病'
      end
      record.save!
    end
  end

  def change_states(record, states, old_states, gender)
    record.with_lock do
      if (states.include? '死亡') && (!old_states.include? '死亡')
        record.count -= 1
        if gender.to_i == 1
          record.f_count -= 1
        else
          record.m_count -= 1
        end
        record.lease_count -= 1 if old_states.include? '租赁'
        record.pei_zhong_count -= 1 if old_states.include? '配种'
        record.fa_qin_count -= 1 if old_states.include? '发情'
        record.dai_zai_count -= 1 if old_states.include? '带仔'
        record.ill_count -= 1 if old_states.include? '生病'
      else
        if (!states.include? '死亡') && (!old_states.include? '死亡')
          record.lease_count -= 1 if old_states.include? '租赁'
          record.pei_zhong_count -= 1 if old_states.include? '配种'
          record.fa_qin_count -= 1 if old_states.include? '发情'
          record.dai_zai_count -= 1 if old_states.include? '带仔'
          record.ill_count -= 1 if old_states.include? '生病'
          record.lease_count += 1 if states.include? '租赁'
          record.pei_zhong_count += 1 if states.include? '配种'
          record.fa_qin_count += 1 if states.include? '发情'
          record.dai_zai_count += 1 if states.include? '带仔'
          record.ill_count += 1 if states.include? '生病'
        end
      end
      record.save!
    end
  end

  def add_all(record, states, gender)
    record.with_lock do
      if states.include? '租赁'
        record.lease_count += 1
      else
        record.count += 1
        if gender.to_i == 1
          record.f_count += 1
        else
          record.m_count += 1
        end

        record.pei_zhong_count += 1 if states.include? '配种'
        record.fa_qin_count += 1 if states.include? '发情'
        record.dai_zai_count += 1 if states.include? '带仔'
        record.ill_count += 1 if states.include? '生病'
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
