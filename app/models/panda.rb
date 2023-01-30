# == Schema Information
#
# Table name: pandas
#
#  id                               :bigint           not null, primary key
#  age(年龄)                        :integer          default(0)
#  birth_date                       :date
#  feeding_type(类型 1 育幼 0 饲养) :integer          default(0)
#  gender(0：未知 1：雄性 2：雌性)  :integer          default(0)
#  head_url                         :string(255)
#  initial_weight(初始体重)         :string(10)
#  is_death(是否死亡)               :boolean          default(FALSE)
#  is_delete                        :boolean          default(FALSE)
#  is_ill(是否生病)                 :boolean          default(FALSE)
#  is_lease(是否租借)               :boolean          default(FALSE)
#  is_pregnant(是否怀孕)            :boolean          default(FALSE)
#  month_day                        :string(4)
#  name                             :string(30)
#  pedigree_number(谱系号)          :string(12)
#  remark(备注)                     :string(200)
#  states(特殊状态)                 :string(100)
#  year                             :integer          default(0)
#  created_at                       :datetime         not null
#  updated_at                       :datetime         not null
#  district_id                      :integer
#  dormitory_id                     :integer
#  father_father_id(父亲的父亲)     :integer
#  father_id(父亲)                  :integer
#  father_mother_id(父亲的母亲)     :integer
#  mother_father_id(母亲的父亲)     :integer
#  mother_id(母亲)                  :integer
#  mother_mother_id(母亲的母亲)     :integer
#  place_id                         :integer
#  room_id                          :integer
#  user_id(新建人员)                :integer
#
# Indexes
#
#  index_pandas_on_name  (name)
#
class Panda < ApplicationRecord
  has_many :prenatal_behaviors
  has_many :parenting_records
  has_many :weight_records
  has_many :feeding_records
  has_many :dormitory_records
  has_many :attachments
  has_many :drug_records
  belongs_to :place, required: false
  belongs_to :district, required: false
  belongs_to :dormitory, required: false
  belongs_to :room, required: false
  belongs_to :father, class_name: 'Panda', foreign_key: 'father_id', required: false
  belongs_to :mother, class_name: 'Panda', foreign_key: 'mother_id', required: false

  belongs_to :father_father, class_name: 'Panda', foreign_key: 'father_father_id', required: false
  belongs_to :father_mother, class_name: 'Panda', foreign_key: 'father_mother_id', required: false

  belongs_to :mother_father, class_name: 'Panda', foreign_key: 'mother_father_id', required: false
  belongs_to :mother_mother, class_name: 'Panda', foreign_key: 'mother_mother_id', required: false

  after_commit :update_age

  def self.gender_str
    %w[未知 雄性 雌性]
  end

  def update_age
    return if birth_date.blank?

    age = Date.today.year - birth_date.year
    age -= 1 if Date.today < birth_date + age.years
    year = birth_date.year
    month = birth_date.strftime('%m%d')
    update_columns(age: age, year: year, month_day: month)
  end

  def states_update
    names = StatesRecord.with_panda_current(id).pluck('name')
    update_columns(states: names.join('、'))
    names.join('、')
  end

  def dormitory_name
    if dormitory.present?
      name = "#{place&.name}，#{district&.name}，#{dormitory&.name}"
      name += "，#{room&.name}" if room.present?
      name
    else
      ''
    end
  end

  def age_string
    if birth_date.blank?
      ''
    elsif feeding_type.zero?
      "#{age}岁"
    else
      days = (Date.today - birth_date).to_i
      "#{days}天"
    end
  end

  scope :with_dormitory, ->(dormitory) { where(dormitory_id: dormitory) }
  scope :with_gender, ->(gender) { where(gender: gender) }
  scope :with_not, ->(id) { where('id != ?', id) }
  scope :with_name, ->(name) { where(name: name) }
  scope :with_not_delete, -> { where(is_delete: false) }
  scope :with_live, -> { where(is_death: false) }

end
