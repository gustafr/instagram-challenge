require 'rails_helper'

RSpec.describe Comment, type: :model do
  it { is_expected.to validate_presence_of(:thoughts)}
  it { should belong_to(:post)}

  it "has a valid factory" do
    comment = create(:comment)
  end

end
