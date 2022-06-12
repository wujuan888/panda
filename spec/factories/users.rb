# == Schema Information
#
# Table name: users
#
#  id                                                :bigint           not null, primary key
#  head_url                                          :string(255)
#  nick_name(微信的昵称)                             :string(20)
#  openid                                            :string(32)
#  phone                                             :string(11)
#  real_name(用户的真实姓名)                         :string(10)
#  role(0：管理员 1：饲养员，2：兽医)                :integer          default(0)
#  role_remark                                       :string(50)
#  states(0：申请中 1：申请通过 2：申请失败 3：离职) :integer          default("init")
#  uuid                                              :string(32)
#  created_at                                        :datetime         not null
#  updated_at                                        :datetime         not null
#
# Indexes
#
#  index_users_on_openid     (openid)
#  index_users_on_phone      (phone)
#  index_users_on_real_name  (real_name)
#  index_users_on_uuid       (uuid)
#
FactoryBot.define do
  factory :user do
    
  end
end
