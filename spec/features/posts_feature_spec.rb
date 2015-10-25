require 'rails_helper'

describe 'posts' do

  before do
    visit ('/posts')
  end

  context 'no posts have been added yet' do

    scenario 'it should display a message that there are no posts' do
      expect(page).to have_content "There are no posts in the system."
    end

    scenario 'it should display add new post link' do
      expect(page).to have_content "Add new post"
    end
  end

  context 'User click on Add new post link' do

    scenario 'shows an add posts form' do
      click_link "Add new post"
      expect(page.current_path).to eq ('/posts/new')
      expect(page).to have_field 'post_title'
      expect(page).to have_field 'post_content'
    end

    scenario 'can add a new post' do
      click_link "Add new post"
      fill_in 'post_title', with: 'My first post'
      fill_in 'post_content', with: 'Hello world'
      #byebug
      click_on 'Create Post'
      expect(page.current_path).to eq ('/posts')
      expect(page).to have_content 'My first post'
    end

  end

  context 'posts have been added' do

    before do
      Post.create(title: "First post", content: "Hello world!")
    end

    scenario 'should list added posts' do
      visit ('/posts')
      expect(page).to have_content "First post"
      expect(page).not_to have_content "There are no posts in the system."
    end

  end

end
