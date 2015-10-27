require 'rails_helper'

RSpec.describe Comment, type: :model do
  it { is_expected.to validate_presence_of(:thoughts)}
  it { is_expected.to belong_to(:user)}
  it { is_expected.to belong_to(:post)}

  xit "has a valid factory" do
    comment = create(:comment)
  end

end
