require 'rails_helper'

describe 'My Posts' do

  context 'visiting root path and havent logged in' do

    before do
      visit '/'
    end

    scenario 'user has a My posts link' do
      expect(page).to have_content 'My posts'
    end

    scenario 'user clicks on My posts link and is asked to sign in' do
      click_link 'My posts'
      expect(page.current_path).to eq '/users/sign_in'
      expect(page).to have_content 'You need to sign in'
    end
  end

  context 'user is signed in' do

    let! (:user) { create(:user) }
    before do
      visit '/'
      click_on 'Sign in'
      fill_in 'Email', with: 'test@test.com'
      fill_in 'Password', with: 'Password1'
      click_button 'Log in'
    end

    scenario 'user clicks on My posts link and is redirected to my_posts path' do
      click_link 'My posts'
      expect(page.current_path).to eq '/my_posts'
      expect(page).to have_content 'You haven\'t made any posts yet'
    end
  end

  context 'user is signed in and has made a post' do

    let! (:user) { FactoryGirl.create(:user) }
    let! (:other_user) { FactoryGirl.create(:user_faker) }
    before do
      visit '/'
      click_on 'Sign in'
      fill_in 'Email', with: 'test@test.com'
      fill_in 'Password', with: 'Password1'
      click_button 'Log in'
    end

    scenario 'user clicks on My posts and is promted with his posts' do
      user.posts.create(FactoryGirl.attributes_for(:post))
      other_user.posts.create(FactoryGirl.attributes_for(:post_other))
      click_link 'My posts'
      expect(page.current_path).to eq '/my_posts'
      expect(page).to have_content 'Hello world'
      expect(page).not_to have_content 'This is my second post'
    end

  end

end
