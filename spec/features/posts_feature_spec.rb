require 'rails_helper'

describe 'posts' do

  before do
    visit ('/posts')
  end

  context 'no posts have been uploaded yet' do

    scenario 'it should display a message that there are no posts' do
      expect(page).to have_content "There are no posts in the system."
    end

    scenario 'it should display add new post message' do
      expect(page).to have_content "Add new post"
    end
  end

  context 'User click on Add new post' do
    scenario 'It shows an add posts form' do
      click_link "Add new post"
      expect(page.current_path).to eq ('/posts/new')

    end

  end
end
