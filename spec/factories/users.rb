FactoryGirl.define do
  factory :user do
    email "test@test.com"
    password "Password1"
    password_confirmation "Password1"

    factory :user_with_post do
      association :post, factory: :post
    end

    factory :user_faker do
      email Faker::Internet.email
    end

    factory :user_faker_with_post do
      email Faker::Internet.email
      association :post, factory: :post
    end

    factory :user_faker_with_other_post do
      email Faker::Internet.email
      association :post, factory: :post_other
    end

  end

end
