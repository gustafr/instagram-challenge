FactoryGirl.define do

  factory :like do
    status true

    factory :like_with_user do
      association :user, factory: :user
    end
  end
end
