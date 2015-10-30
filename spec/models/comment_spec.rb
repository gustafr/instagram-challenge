require 'rails_helper'

RSpec.describe Comment, type: :model do

  subject { FactoryGirl.create(:comment) }

  describe 'attributes' do
    it { is_expected.to have_db_column(:thoughts).of_type(:text) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:thoughts) }
  end

  describe 'associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:post) }
  end

  describe 'fixtures' do
    it "has a valid factory" do
      expect(subject).to be_valid
    end
  end

end
