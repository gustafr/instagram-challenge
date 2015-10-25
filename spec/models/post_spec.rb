require 'rails_helper'

RSpec.describe Post, type: :model do
  it { is_expected.to validate_presence_of(:title)}
  it { is_expected.to validate_presence_of(:content) }
  it { is_expected.to validate_presence_of(:image) }

  it "has a valid factory" do
    post = create(:post)
  end

end
