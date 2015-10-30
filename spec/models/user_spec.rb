require 'rails_helper'

RSpec.describe User, type: :model do

  subject { FactoryGirl.create(:user) }

  describe 'attributes' do
    it { is_expected.to have_db_column(:email).of_type(:string) }
    it { is_expected.to have_db_column(:encrypted_password).of_type(:string) }
  end

  describe 'associations' do
    it { is_expected.to have_many(:comments) }
    it { is_expected.to have_many(:posts) }
  end

  describe 'fixtures' do
    it "has a valid factory" do
      expect(subject).to be_valid
    end
  end

end
