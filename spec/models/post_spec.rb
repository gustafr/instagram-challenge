require 'rails_helper'

RSpec.describe Post, type: :model do
  xit { is_expected.to validate_presence_of(:title)}
  it { is_expected.to validate_presence_of(:content) }
  it { is_expected.to validate_presence_of(:image) }
  it { is_expected.to have_many(:comments)}
  it { is_expected.to belong_to(:user)}

  xit "has a valid factory" do
    post = create(:post)
  end

end
