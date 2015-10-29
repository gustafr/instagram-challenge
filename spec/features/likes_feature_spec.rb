require 'rails_helper'

describe 'likes' do

  context 'a post is added and a non signed-in user is viewing that post' do

    let! (:user) { create(:user) }
    let! (:post) { user.posts.create(FactoryGirl.attributes_for(:post)) }

    before do
      visit '/'
    end

    scenario 'user is promted with a Like button' do
      expect(page).to have_content 'Like'
      expect(page).not_to have_button 'Unlike'
    end

    scenario 'user trying to like a post is asked to log in' do
      click_on 'Like'
      expect(page).to have_content 'You need to sign in or sign up before continuing.'
      expect(page.current_path).to eq '/users/sign_in'
    end
  end

  context 'a post is added and a logged in user is viewing that post' do

    let! (:user) { create(:user) }
    let! (:post) { user.posts.create(FactoryGirl.attributes_for(:post)) }

    before do
      visit '/'
      click_on 'Sign in'
      fill_in 'Email', with: 'test@test.com'
      fill_in 'Password', with: 'Password1'
      click_button 'Log in'
    end

    scenario 'user is promted with a Like button' do
      expect(page).to have_content 'Like'
      expect(page).not_to have_button 'Unlike'
    end

    scenario 'user clicks on Like button raises likes by 1' do
      click_button 'Like'
      expect(page).to have_content '1 Likes'
      expect(page).not_to have_button 'Like'
    end
  end

  context 'a post is added and a logged in user has liked a post' do

    let! (:user) { create(:user) }
    let! (:post) { user.posts.create(FactoryGirl.attributes_for(:post)) }

    before do
      visit '/'
      click_on 'Sign in'
      fill_in 'Email', with: 'test@test.com'
      fill_in 'Password', with: 'Password1'
      click_button 'Log in'
      click_button 'Like'
    end

    scenario 'user is promted with a Unlike button' do
      expect(page).to have_button 'Unlike'
      expect(page).not_to have_button 'Like'
    end

    scenario 'user clicks on Unlike button lower likes by 1' do
      click_button 'Unlike'
      expect(page).to have_content '0 Likes'
      expect(page).not_to have_button 'Unlike'
    end

  end

end
