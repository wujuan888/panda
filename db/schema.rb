# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2023_02_27_130709) do

  create_table "attachments", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3", force: :cascade do |t|
    t.integer "panda_id"
    t.string "url"
    t.string "sm_url"
    t.integer "item_id"
    t.string "item_type", limit: 30
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["item_id", "item_type"], name: "index_attachments_on_item_id_and_item_type"
    t.index ["panda_id"], name: "index_attachments_on_panda_id"
  end

  create_table "bamboos", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3", force: :cascade do |t|
    t.string "name", limit: 30
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "behavior_records", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3", force: :cascade do |t|
    t.integer "panda_id"
    t.integer "feeding_record_id"
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "is_input", default: false, comment: "是否录入"
    t.index ["feeding_record_id"], name: "index_behavior_records_on_feeding_record_id"
    t.index ["panda_id"], name: "index_behavior_records_on_panda_id"
  end

  create_table "com_evaluation_records", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3", force: :cascade do |t|
    t.integer "panda_id"
    t.integer "feeding_record_id"
    t.string "collection", limit: 100, comment: "采集情况"
    t.string "spiritual", limit: 100, comment: "精神情况"
    t.string "other", limit: 100, comment: "其它情况"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "is_input", default: false, comment: "是否录入"
    t.index ["feeding_record_id"], name: "index_com_evaluation_records_on_feeding_record_id"
    t.index ["panda_id"], name: "index_com_evaluation_records_on_panda_id"
  end

  create_table "districts", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3", force: :cascade do |t|
    t.integer "place_id"
    t.integer "user_id"
    t.string "name", limit: 100
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "is_delete", default: false, comment: "删除"
    t.index ["name"], name: "index_districts_on_name"
    t.index ["place_id"], name: "index_districts_on_place_id"
  end

  create_table "dormitories", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3", force: :cascade do |t|
    t.string "name", limit: 30
    t.string "address", limit: 20, comment: "地址"
    t.integer "user_id", comment: "负责人"
    t.string "remark", limit: 200, comment: "备注"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "panda_count", default: 0, comment: "熊猫数量"
    t.integer "place_id"
    t.integer "district_id"
    t.boolean "is_delete", default: false, comment: "删除"
    t.index ["name"], name: "index_dormitories_on_name"
    t.index ["place_id", "district_id"], name: "place"
  end

  create_table "dormitories_users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3", force: :cascade do |t|
    t.bigint "dormitory_id"
    t.bigint "user_id"
    t.index ["dormitory_id"], name: "index_dormitories_users_on_dormitory_id"
    t.index ["user_id"], name: "index_dormitories_users_on_user_id"
  end

  create_table "dormitory_records", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3", force: :cascade do |t|
    t.integer "dormitory_id"
    t.integer "panda_id", comment: "地址"
    t.integer "user_id", comment: "负责人"
    t.string "name", limit: 30
    t.string "address", limit: 20, comment: "地址"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "room_id", default: 0
    t.index ["dormitory_id"], name: "index_dormitory_records_on_dormitory_id"
    t.index ["panda_id"], name: "index_dormitory_records_on_panda_id"
  end

  create_table "drug_records", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3", force: :cascade do |t|
    t.integer "user_id", comment: "开药人"
    t.integer "panda_id", comment: "熊猫"
    t.datetime "time", comment: "时间"
    t.string "remark", limit: 300, comment: "备注"
    t.string "other", limit: 200, comment: "其它"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "drugs", limit: 500, comment: "药物"
    t.integer "drug_id", default: 0
    t.string "dose", limit: 50, comment: "剂量"
    t.string "time_record", comment: "喂药时间（12:00）"
    t.integer "feeding_record_id"
    t.index ["feeding_record_id"], name: "index_drug_records_on_feeding_record_id"
    t.index ["panda_id"], name: "index_drug_records_on_panda_id"
    t.index ["user_id"], name: "index_drug_records_on_user_id"
  end

  create_table "drugs", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3", force: :cascade do |t|
    t.string "name", limit: 30
    t.integer "drug_type", default: 0, comment: "0 药品  1 保健药品"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "eat_other_records", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3", force: :cascade do |t|
    t.integer "panda_id"
    t.integer "feeding_record_id"
    t.string "name", limit: 100
    t.string "amount", limit: 20
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["feeding_record_id"], name: "index_eat_other_records_on_feeding_record_id"
    t.index ["panda_id"], name: "index_eat_other_records_on_panda_id"
  end

  create_table "eat_records", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3", force: :cascade do |t|
    t.integer "panda_id"
    t.integer "feeding_record_id"
    t.string "name", limit: 100
    t.string "amount", limit: 20
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "is_input", default: false, comment: "是否录入"
    t.index ["feeding_record_id"], name: "index_eat_records_on_feeding_record_id"
    t.index ["panda_id"], name: "index_eat_records_on_panda_id"
  end

  create_table "enrichment_records", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3", force: :cascade do |t|
    t.integer "panda_id"
    t.integer "feeding_record_id"
    t.string "name", limit: 50
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "is_input", default: false, comment: "是否录入"
    t.index ["feeding_record_id"], name: "index_enrichment_records_on_feeding_record_id"
    t.index ["panda_id"], name: "index_enrichment_records_on_panda_id"
  end

  create_table "feeding_records", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3", force: :cascade do |t|
    t.integer "user_id", comment: "记录人"
    t.integer "panda_id", comment: "熊猫"
    t.datetime "time", comment: "时间"
    t.text "Health_medicine", comment: "保健药品"
    t.string "wo_tou_input", limit: 10, comment: "窝头投给"
    t.string "wo_tou_ingest", limit: 10, comment: "窝头食入"
    t.string "apple_input", limit: 10, comment: "苹果投给"
    t.string "apple_ingest", limit: 10, comment: "苹果食入"
    t.string "collection", limit: 100, comment: "采集情况"
    t.string "spiritual", limit: 100, comment: "精神活动"
    t.string "bamboo_variety", limit: 50, comment: "竹子品种"
    t.string "bamboo_part", limit: 20, comment: "竹子部位"
    t.string "bamboo_input", limit: 10, comment: "竹子投给"
    t.string "bamboo_ingest", limit: 10, comment: "竹子食入"
    t.string "poop_texture", limit: 30, comment: "大便质地"
    t.string "poop_element", limit: 30, comment: "大便成分"
    t.string "poop_color", limit: 20, comment: "大便颜色"
    t.string "poop_quality", limit: 10, comment: "大便质量"
    t.string "mucus_texture", limit: 30, comment: "粘液质地"
    t.string "mucus_pain", limit: 30, comment: "粘液痛感"
    t.string "mucus_quality", limit: 10, comment: "粘液质量"
    t.string "evaluation", limit: 200, comment: "综合评估"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "forage_time", limit: 10, comment: "采食时间"
    t.string "mucus_time", limit: 10, comment: "粘液时间"
    t.string "weight", limit: 100, comment: "体重"
    t.string "remark", limit: 200, comment: "备注"
    t.integer "date_record", comment: "日期"
    t.integer "feeding_type", default: 0, comment: "类型 1 育幼 0 饲养"
    t.string "daily_add", default: "", comment: "日增重"
    t.index ["panda_id"], name: "index_feeding_records_on_panda_id"
    t.index ["user_id"], name: "index_feeding_records_on_user_id"
  end

  create_table "milk_records", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3", force: :cascade do |t|
    t.integer "panda_id"
    t.integer "feeding_record_id"
    t.string "breast_milk", limit: 20, comment: "母乳处奶量"
    t.string "su_breast_milk", limit: 20, comment: "补母乳"
    t.string "artificial_milk", limit: 20, comment: "人工奶"
    t.string "milks", limit: 20, comment: "总奶量"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "is_input", default: false, comment: "是否录入"
    t.index ["feeding_record_id"], name: "index_milk_records_on_feeding_record_id"
    t.index ["panda_id"], name: "index_milk_records_on_panda_id"
  end

  create_table "mucus_records", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3", force: :cascade do |t|
    t.integer "panda_id"
    t.integer "feeding_record_id"
    t.string "texture", limit: 30, comment: "粘液质地"
    t.string "pain", limit: 30, comment: "粘液痛感"
    t.string "color", limit: 20, comment: "粘液颜色"
    t.string "quality", limit: 10, comment: "粘液质量"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "is_input", default: false, comment: "是否录入"
    t.string "time_record", comment: "喂药时间（12:00）"
    t.index ["feeding_record_id"], name: "index_mucus_records_on_feeding_record_id"
    t.index ["panda_id"], name: "index_mucus_records_on_panda_id"
  end

  create_table "panda_records", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3", force: :cascade do |t|
    t.integer "count", default: 0, comment: "熊猫总数量"
    t.integer "f_count", default: 0, comment: "雄性数量"
    t.integer "m_count", default: 0, comment: "雌性数量"
    t.integer "pregnant_count", default: 0, comment: "怀孕数量"
    t.integer "ill_count", default: 0, comment: "生病数量"
    t.integer "lease_count", default: 0, comment: "租借数量"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "place_id"
    t.integer "pei_zhong_count", default: 0, comment: "配种数量"
    t.integer "fa_qin_count", default: 0, comment: "发情数量"
    t.integer "dai_zai_count", default: 0, comment: "带仔数量"
  end

  create_table "pandas", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3", force: :cascade do |t|
    t.integer "dormitory_id"
    t.integer "user_id", comment: "新建人员"
    t.string "head_url"
    t.string "name", limit: 30
    t.date "birth_date"
    t.string "initial_weight", limit: 10, comment: "初始体重"
    t.integer "gender", default: 0, comment: "0：未知 1：雄性 2：雌性"
    t.integer "father_id", comment: "父亲"
    t.integer "father_father_id", comment: "父亲的父亲"
    t.integer "father_mother_id", comment: "父亲的母亲"
    t.integer "mother_id", comment: "母亲"
    t.integer "mother_father_id", comment: "母亲的父亲"
    t.integer "mother_mother_id", comment: "母亲的母亲"
    t.string "pedigree_number", limit: 12, comment: "谱系号"
    t.string "remark", limit: 200, comment: "备注"
    t.boolean "is_pregnant", default: false, comment: "是否怀孕"
    t.boolean "is_ill", default: false, comment: "是否生病"
    t.boolean "is_lease", default: false, comment: "是否租借"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "age", default: 0, comment: "年龄"
    t.string "month_day", limit: 4
    t.integer "year", default: 0
    t.boolean "is_delete", default: false
    t.boolean "is_death", default: false, comment: "是否死亡"
    t.string "states", limit: 50, default: "", comment: "特殊状态"
    t.integer "place_id"
    t.integer "district_id"
    t.integer "room_id"
    t.integer "feeding_type", default: 0, comment: "类型 1 育幼 0 饲养"
    t.index ["name"], name: "index_pandas_on_name"
  end

  create_table "parenting_records", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3", force: :cascade do |t|
    t.datetime "time", comment: "时间"
    t.integer "user_id", comment: "记录人"
    t.integer "panda_id", comment: "熊猫"
    t.string "breast_milk", limit: 10, comment: "母乳"
    t.string "artificial_milk", limit: 10, comment: "人工乳"
    t.string "skin_temperature", limit: 10, comment: "肤温"
    t.string "Box_temperature", limit: 10, comment: "箱温"
    t.string "humidity", limit: 10, comment: "湿度"
    t.string "breathe", limit: 10, comment: "呼吸"
    t.string "poop", limit: 20, comment: "大便"
    t.string "pee", limit: 20, comment: "小便"
    t.string "mental_state", limit: 100, comment: "精神状态"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["panda_id"], name: "index_parenting_records_on_panda_id"
    t.index ["user_id"], name: "index_parenting_records_on_user_id"
  end

  create_table "places", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3", force: :cascade do |t|
    t.integer "user_id"
    t.string "name", limit: 100
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_places_on_name"
  end

  create_table "poop_records", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3", force: :cascade do |t|
    t.integer "panda_id"
    t.integer "feeding_record_id"
    t.string "texture", limit: 50, comment: "大便质地"
    t.string "element", limit: 50, comment: "大便成分"
    t.string "color", limit: 30, comment: "大便颜色"
    t.string "quality", limit: 20, comment: "大便质量"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "is_input", default: false, comment: "是否录入"
    t.index ["feeding_record_id"], name: "index_poop_records_on_feeding_record_id"
    t.index ["panda_id"], name: "index_poop_records_on_panda_id"
  end

  create_table "prenatal_behaviors", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3", force: :cascade do |t|
    t.integer "user_id", comment: "记录人"
    t.integer "panda_id", comment: "熊猫"
    t.datetime "time", comment: "时间"
    t.string "wo_tou", limit: 30, comment: "窝头"
    t.string "bamboo", limit: 30, comment: "竹子"
    t.string "poop", limit: 30, comment: "大便"
    t.string "remark", limit: 100, comment: "备注"
    t.datetime "behavior_time", comment: "行为时间"
    t.string "behavior_event", limit: 50, comment: "事件"
    t.string "behavior_remark", limit: 100, comment: "行为备注"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["panda_id"], name: "index_prenatal_behaviors_on_panda_id"
    t.index ["user_id"], name: "index_prenatal_behaviors_on_user_id"
  end

  create_table "rooms", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3", force: :cascade do |t|
    t.integer "place_id"
    t.integer "user_id"
    t.integer "district_id"
    t.integer "dormitory_id"
    t.string "name", limit: 500
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "is_delete", default: false, comment: "删除"
    t.index ["name"], name: "index_rooms_on_name"
    t.index ["place_id", "district_id", "dormitory_id"], name: "place"
  end

  create_table "states_records", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3", force: :cascade do |t|
    t.integer "panda_id"
    t.integer "feeding_record_id"
    t.string "name"
    t.string "district", limit: 100, comment: "地区"
    t.string "institution", limit: 100, comment: "机构"
    t.boolean "is_stop", default: false, comment: "是否结束"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "item_id", comment: "特殊状态开始或结束id"
    t.integer "states_type", comment: "0: 开始  1： 结束"
    t.datetime "date", comment: "开始或结束日期"
    t.integer "date_record"
    t.index ["feeding_record_id"], name: "index_states_records_on_feeding_record_id"
    t.index ["panda_id"], name: "index_states_records_on_panda_id"
  end

  create_table "table_drugs_drug_records", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3", force: :cascade do |t|
    t.bigint "drug_id"
    t.bigint "drug_record_id"
    t.index ["drug_id"], name: "index_table_drugs_drug_records_on_drug_id"
    t.index ["drug_record_id"], name: "index_table_drugs_drug_records_on_drug_record_id"
  end

  create_table "temperature_records", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3", force: :cascade do |t|
    t.integer "panda_id"
    t.integer "feeding_record_id"
    t.string "body", limit: 20, comment: "体温"
    t.string "box", limit: 20, comment: "箱温"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "is_input", default: false, comment: "是否录入"
    t.index ["feeding_record_id"], name: "index_temperature_records_on_feeding_record_id"
    t.index ["panda_id"], name: "index_temperature_records_on_panda_id"
  end

  create_table "train_records", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3", force: :cascade do |t|
    t.integer "panda_id"
    t.integer "feeding_record_id"
    t.string "name", limit: 20
    t.integer "result", default: 0, comment: "训练结果"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["feeding_record_id"], name: "index_train_records_on_feeding_record_id"
    t.index ["panda_id"], name: "index_train_records_on_panda_id"
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3", force: :cascade do |t|
    t.string "openid", limit: 32
    t.string "head_url"
    t.string "phone", limit: 11
    t.string "nick_name", limit: 20, comment: "微信的昵称"
    t.string "real_name", limit: 10, comment: "用户的真实姓名"
    t.string "uuid", limit: 32
    t.integer "role", default: 0, comment: "0：管理员 1：饲养员，2：兽医"
    t.integer "states", default: 0, comment: "0：申请中 1：申请通过 2：申请失败 3：离职"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "role_remark", limit: 50
    t.index ["openid"], name: "index_users_on_openid"
    t.index ["phone"], name: "index_users_on_phone"
    t.index ["real_name"], name: "index_users_on_real_name"
    t.index ["uuid"], name: "index_users_on_uuid"
  end

  create_table "weight_months", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3", force: :cascade do |t|
    t.integer "panda_id", comment: "熊猫"
    t.datetime "date", comment: "日期"
    t.string "weight", limit: 10, comment: "体重"
    t.string "add", limit: 10, comment: "增长体重"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "init_weight"
    t.integer "year", comment: "年"
    t.integer "month", comment: "月"
    t.index ["panda_id"], name: "index_weight_months_on_panda_id"
    t.index ["year", "month"], name: "index_weight_months_on_year_and_month"
  end

  create_table "weight_records", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3", force: :cascade do |t|
    t.integer "user_id", comment: "记录人"
    t.integer "panda_id", comment: "熊猫"
    t.string "weight", limit: 10, comment: "体重"
    t.string "daily_gain", limit: 10, comment: "日增重"
    t.string "feed_intake", limit: 10, comment: "采食量"
    t.string "feed_ratio", limit: 10, comment: "采食比"
    t.string "other", limit: 100, comment: "其它"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "time", comment: "时间"
    t.index ["panda_id"], name: "index_weight_records_on_panda_id"
    t.index ["user_id"], name: "index_weight_records_on_user_id"
  end

end
