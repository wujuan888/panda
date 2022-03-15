# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

data = %w[巴山木竹 刺竹 白夹竹 苦竹 箬竹 三月笋 白夹笋 方竹笋 苦竹笋 ]

data.each do |item|
  Bamboo.create(name: item)
end

drugs = %w[
     复合VB--1片 复合VB--2片
     善存片--1/2片 善存片--1片 善存片--2片
     钙尔奇--1/2片       钙尔奇--2片
     葡萄糖酸钙--1支 葡萄糖酸钙--2支
     能全力--10g 能全力--20g
     氨基酸--10g 氨基酸--20g
     Ve--1粒 Ve--2粒

]
drugs.each do |item|
  Drug.create(name: item, drug_type: 1)
end