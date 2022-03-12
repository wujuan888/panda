class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :openid, limit: 32
      t.string :head_url
      t.string :phone, limit: 11
      t.string :nick_name, limit: 20, comment: '微信的昵称'
      t.string :real_name, limit: 10, comment: '用户的真实姓名'
      t.string :uuid, limit: 32
      t.integer :role, default: 0, comment: '0：管理员 1：饲养员，2：兽医'
      t.integer :states, default: 0, comment: '0：申请中 1：申请通过 2：申请失败 3：离职'
      t.timestamps
    end

    add_index :users, :openid
    add_index :users, :uuid
    add_index :users, :phone
    add_index :users, :real_name
  end
end
