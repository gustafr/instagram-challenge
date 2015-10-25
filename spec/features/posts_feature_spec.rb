require 'rails_helper'

describe 'posts' do
  context 'no posts have been uploaded yet' do
    scenario 'it should display a message that there are no posts' do
      visit ('/posts')
      expect(page).to have_content "There are no posts in the system."
    end
  end
end
