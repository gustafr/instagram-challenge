require 'rails_helper'

describe 'likes' do


  context 'a post is added and a logged in user is viewing that post' do

    let! (:user) { create(:user)}
    let! (:post) { user.posts.create(FactoryGirl.attributes_for(:post))}

    before do
      visit '/'
      click_on 'Sign in'
      fill_in 'Email', with: 'test@test.com'
      fill_in 'Password', with: 'Password1'
      click_button 'Log in'
    end

    scenario 'user is promted with a Like button' do
      expect(page).to have_content 'Like'
    end

    scenario 'user clicks on Like button and are presented with a Like checkbox' do
      click_link 'Like'
      expect(page).to have_button 'Like'
    end

    scenario 'user check the like checkbox press the Create like button' do
      click_link 'Like'
      check 'Like'
      click_button 'Create Like'
      expect(page.current_path).to eq posts_path
      expect(page).to have_content 'Likes: 1'
    end

  end

end
