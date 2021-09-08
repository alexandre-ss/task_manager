FactoryBot.define do
  factory :task do
    sequence :title do |n|
      "title#{n}"
    end

    sequence :description do |n|
      "description#{n}"
    end
    
    user
    share { true }
  end
end
