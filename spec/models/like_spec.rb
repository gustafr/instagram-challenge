require 'rails_helper'

RSpec.describe Like, type: :model do

  subject { FactoryGirl.create(:like) }

  describe 'attributes' do
    it { is_expected.to have_db_column(:status).of_type(:boolean) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:status) }
  end

  describe 'fixtures' do
    it "has a valid factory" do
      expect(subject).to be_valid
    end
  end

end
