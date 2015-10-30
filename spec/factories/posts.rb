include ActionDispatch::TestProcess
FactoryGirl.define do

  factory :post do
    title "First post"
    content "Hello world"
    image { fixture_file_upload(Rails.root.join('spec', 'photos', 'test.jpg'), 'image/jpg') }
    created_at "2015-10-26 00:00:00.00"

    factory :post_other do
      title "Second post"
      content "This is my second post"
    end

    factory :post_with_user do
      association :user, factory: :user
    end

    factory :post_with_like_and_user do
      association :like, factory: :like
      association :user, factory: :user
    end
  end
end
