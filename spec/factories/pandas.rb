# == Schema Information
#
# Table name: pandas
#
#  id                                      :bigint           not null, primary key
#  age(年龄)                               :integer          default(0)
#  birth_date                              :date
#  feed_type(饲养类型： 0： 育幼  1：饲养) :integer          default(0)
#  gender(0：未知 1：雄性 2：雌性)         :integer          default(0)
#  head_url                                :string(255)
#  initial_weight(初始体重)                :string(10)
#  is_death(是否死亡)                      :boolean          default(FALSE)
#  is_delete                               :boolean          default(FALSE)
#  is_ill(是否生病)                        :boolean          default(FALSE)
#  is_lease(是否租借)                      :boolean          default(FALSE)
#  is_pregnant(是否怀孕)                   :boolean          default(FALSE)
#  month_day                               :string(4)
#  name                                    :string(30)
#  pedigree_number(谱系号)                 :string(12)
#  remark(备注)                            :string(200)
#  states(特殊状态)                        :string(100)
#  year                                    :integer          default(0)
#  created_at                              :datetime         not null
#  updated_at                              :datetime         not null
#  district_id                             :integer
#  dormitory_id                            :integer
#  father_father_id(父亲的父亲)            :integer
#  father_id(父亲)                         :integer
#  father_mother_id(父亲的母亲)            :integer
#  mother_father_id(母亲的父亲)            :integer
#  mother_id(母亲)                         :integer
#  mother_mother_id(母亲的母亲)            :integer
#  place_id                                :integer
#  room_id                                 :integer
#  user_id(新建人员)                       :integer
#
# Indexes
#
#  index_pandas_on_name  (name)
#
FactoryBot.define do
  factory :panda do
    
  end
end
