include ActionDispatch::TestProcess
FactoryGirl.define do
  factory :post do
    title "First post"
    content "Hello world"
    image { fixture_file_upload(Rails.root.join('spec', 'photos', 'test.jpg'), 'image/jpg') }
  end
end
