namespace :task do
  desc 'panda age'
  task panda_age: :environment do
    pandas = Panda.where(month_day: Time.now.strftime('%m%d'))
    pandas.each do |panda|
      next if panda.birth_date.blank?

      age = Date.today.year - panda.birth_date.year
      age -= 1 if Date.today < panda.birth_date + age.years
      panda.update_columns(age: age)
    end

  end
end
