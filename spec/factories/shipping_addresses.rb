FactoryBot.define do

  factory :shipping_address do
    name_last             {"田中"}
    name_first            {"太郎"}
    name_last_kana        {"タナカ"}
    name_first_kana       {"タロウ"}
    zipcode               {"1231234"}
    prefecture_id         {"13"}
    city                  {"千代田区"}
    street_address        {"丸の内１丁目"}
  end

end