include ActionDispatch::TestProcess
FactoryGirl.define do
  factory :post do
    title "First post"
    content "Hello world"
    image { fixture_file_upload(Rails.root.join('spec', 'photos', 'test.jpg'), 'image/jpg') }
    association :user, factory: :user
    created_at "2015-10-26 00:00:00.00"
  end
end
