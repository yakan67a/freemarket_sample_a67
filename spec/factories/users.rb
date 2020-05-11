FactoryBot.define do

  factory :user do
    nickname              {Faker::Name.last_name}
    email                 {Faker::Internet.free_email}
    password = Faker::Internet.password(min_length: 7)
    password              {password}
    password_confirmation {password}
    name_last             {"田中"}
    name_first            {"太郎"}
    name_last_kana        {"タナカ"}
    name_first_kana       {"タロウ"}
    birth                 {"2020-01-01"}
  end

end