FactoryGirl.define do
  factory :ticket do
    user
    trait :processing do
      status 'processing'
    end
    trait :completed do
      status 'completed'
    end
  end
end
