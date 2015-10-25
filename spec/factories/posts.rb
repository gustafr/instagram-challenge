include ActionDispatch::TestProcess
FactoryGirl.define do
  factory :post do
    title "First post"
    content "Hello world"
    image { fixture_file_upload(Rails.root.join('spec', 'photos', 'test.jpg'), 'image/jpg') }
  end

  # factory :attachment do
  #   supporting_documentation_file_name { 'test.jpg' }
  #   supporting_documentation_content_type { 'image/jpg' }
  #   supporting_documentation_file_size { 1024 }
  # end

end
