require 'rails_helper'

RSpec.describe User, type: :model do

  it "has a valid factory" do
    post = create(:user)
  end

end
