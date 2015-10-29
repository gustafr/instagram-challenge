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

  context 'user is not logged in and clicks on Add post link' do

    scenario 'is promted the sign in page' do
      click_link "Add new post"
      expect(page.current_path).to eq '/users/sign_in'
    end

  end

  context 'user is logged in and click on Add new post link' do

    let! (:user) { create(:user) }
    before do
      visit '/'
      click_on 'Sign in'
      fill_in 'Email', with: 'test@test.com'
      fill_in 'Password', with: 'Password1'
      click_button 'Log in'
    end

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
      expect(page).to have_content 'test@test.com'
    end

    xscenario 'cant add a new post without entering title' do
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
      expect(page).to have_content 'test@test.com'
      expect(page).not_to have_content 'There are no posts in the system.'
    end

    scenario 'should be able to show a post if user is post owner' do
      click_on 'Sign in'
      fill_in 'Email', with: 'test@test.com'
      fill_in 'Password', with: 'Password1'
      click_button 'Log in'
      click_link 'test@test.com'
      expect(page).to have_content 'Hello world'
      expect(page.current_path).to eq "/posts/#{post.id}"
    end

  end

  context 'user is not logged in and visiting a posts unique page' do

    let! (:post) {create(:post)}
    before do
      visit "/posts/#{post.id}"
    end

    scenario 'should not see the edit and delete links' do
      expect(page).not_to have_content 'Edit post'
      expect(page).not_to have_content 'Delete post'
    end


  end

  context 'user is logged in and visiting a posts unique page' do

    let! (:user) { create(:user) }
    let! (:post) { user.posts.create(FactoryGirl.attributes_for(:post))}
    before do
      visit '/'
      click_on 'Sign in'
      fill_in 'Email', with: user.email
      fill_in 'Password', with: 'Password1'
      click_button 'Log in'
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
      expect(page).to have_content 'New content'
    end

    scenario 'should be able to delete a post' do
      click_link 'Delete post'
      expect(page).not_to have_content 'First post'
      expect(page).to have_content 'Post deleted successfully!'
    end

  end

end
