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
class User < ApplicationRecord
  enum states: { init: 0, pass: 1, no_pass: 2, resign: 3 }
  has_many :dormitories
  before_validation do
    write_attribute(:uuid, SecureRandom.uuid.delete('-')) if new_record? || uuid.blank?
  end

  def self.roles
    [['管理员', 0], ['饲养员', 1], ['兽医', 2]]
  end

  def self.states_names
    { init: '申请中', pass: '申请通过', no_pass: '申请失败', resign: '离职' }
  end

  def self.states_login_names
    { init: '待审核中', no_pass: '申请失败', resign: '已离职' }
  end

  scope :with_states, ->(states) { where(states: states) }
  scope :with_openid, ->(openid) { where(openid: openid) }
  scope :with_name_phone, ->(name, phone) { where(name: name, phone: phone) }
  scope :with_openid_or_phone, ->(openid, phone) { where('openid = ? or phone = ?', openid, phone) }
end
