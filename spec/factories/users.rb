FactoryBot.define do

  factory :user do
    nickname              {"furima"}
    email                 {"furima@gmail.com"}
    password              {"1234567"}
    password_confirmation {"1234567"}
    name_last             {"田中"}
    name_first            {"太郎"}
    name_last_kana        {"タナカ"}
    name_first_kana       {"タロウ"}
    birth                 {"2020-01-01"}
  end

end