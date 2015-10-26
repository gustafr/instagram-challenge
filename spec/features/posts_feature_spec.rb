require 'rails_helper'
require 'spec_helper'

describe 'posts' do

  before do
    visit '/posts'
  end

  context 'no posts have been added yet' do

    scenario 'it should display a message that there are no posts' do
      expect(page).to have_content 'There are no posts in the system.'
    end

    scenario 'it should display add new post link' do
      expect(page).to have_content 'Add new post'
    end
  end

  context 'User click on Add new post link' do

    scenario 'shows an add posts form' do
      click_link "Add new post"
      expect(page.current_path).to eq '/posts/new'
      expect(page).to have_field 'post_title'
      expect(page).to have_field 'post_content'
    end

    scenario 'can add a new post when typing in required information' do
      click_link "Add new post"
      fill_in 'post_title', with: 'My first post'
      fill_in 'post_content', with: 'Hello world'
      attach_file("post_image", Rails.root + "spec/photos/test.jpg")
      click_on 'Create Post'
      expect(page.current_path).to eq '/posts'
      expect(page).to have_content 'My first post'
    end

    scenario 'cant add a new post without entering title' do
      click_link "Add new post"
      fill_in 'post_content', with: 'Hello world'
      attach_file("post_image", Rails.root + "spec/photos/test.jpg")
      click_on 'Create Post'
      expect(page).to have_content 'Title can\'t be blank'
    end

    scenario 'cant add a new post without entering content' do
      click_link "Add new post"
      fill_in 'post_title', with: 'My first post'
      attach_file("post_image", Rails.root + "spec/photos/test.jpg")
      click_on 'Create Post'
      expect(page).to have_content 'Content can\'t be blank'
    end

    scenario 'cant add a new post without attaching an image' do
      click_link "Add new post"
      fill_in 'post_title', with: 'My first post'
      fill_in 'post_content', with: 'Hello world'
      click_on 'Create Post'
      expect(page).to have_content 'Image can\'t be blank'
    end

    scenario 'cant add a new post when attaching other file than image' do
      click_link "Add new post"
      fill_in 'post_title', with: 'My first post'
      fill_in 'post_content', with: 'Hello world'
      attach_file("post_image", Rails.root + "spec/photos/test.pdf")
      click_on 'Create Post'
      expect(page.current_path).to eq '/posts'
      expect(page).to have_content 'Image content type is invalid'
    end

  end

  context 'new post have been added' do

    let! (:post) {create(:post)}
    before do
      visit '/posts'
    end

    scenario 'should list added posts' do
      expect(page).to have_content 'First post'
      expect(page).not_to have_content 'There are no posts in the system.'
    end

    scenario 'should be able to show a post' do
      click_link 'First post'
      expect(page).to have_content 'First post'
      expect(page.current_path).to eq "/posts/#{post.id}"
    end

  end

  context 'visiting a posts unique page' do
    let! (:post) {create(:post)}
    before do
      visit "/posts/#{post.id}"
    end

    scenario 'should display edit and delete links' do
      expect(page).to have_content 'Edit post'
      expect(page).to have_content 'Delete post'
    end

    scenario 'should be able to update a post' do
      click_link 'Edit post'
      fill_in 'post_title', with: 'Updated post'
      fill_in 'post_content', with: 'New content'
      click_on 'Update Post'
      expect(page).to have_content 'Updated post'
    end

    scenario 'should be able to delete a post' do
      click_link 'Delete post'
      expect(page).not_to have_content 'First post'
      expect(page).to have_content 'Post deleted successfully!'
    end

  end

end
