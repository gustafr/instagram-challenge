require 'rails_helper'

RSpec.describe Post, type: :model do

  subject { FactoryGirl.create(:post) }

  describe 'attributes' do
    it { is_expected.to have_db_column(:content).of_type(:text) }
    it { is_expected.to have_db_column(:image_file_name).of_type(:string) }
    it { is_expected.to have_db_column(:image_content_type).of_type(:string) }
    it { is_expected.to have_db_column(:image_file_size).of_type(:integer) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:content) }
    it { is_expected.to validate_presence_of(:image) }
  end

  describe 'associations' do
    it { is_expected.to have_many(:comments) }
    it { is_expected.to belong_to(:user) }
  end

  describe 'fixtures' do
    it "has a valid factory" do
      expect(subject).to be_valid
    end
  end

  describe 'helper methods' do

    it 'can calculate the time, in, hours, since post was created' do
      allow(Time).to receive(:now).and_return(Time.mktime(2015, 10, 27))
      expect(subject.hours_since_posted).to eq 23
    end
    
  end

end
