FactoryBot.define do
  factory :category do
    name {"親"}
    ancestry {nil}

    factory :child_category, parent: :category do 
      name {"子"}
      ancestry {1}

      factory :grand_category do
        name {"孫"}
        ancestry {1/2}
      end

    end 

  end
end