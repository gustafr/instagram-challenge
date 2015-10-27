require 'rails_helper'

RSpec.describe User, type: :model do
  it { is_expected.to have_many(:comments)}
  it { is_expected.to have_many(:posts)}

  it "has a valid factory" do
    post = create(:user)
    expect(post).to be_valid
  end

end
