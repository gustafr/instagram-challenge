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

    scenario 'user clicks on Like button and are presented with a new Like button ' do
      click_link 'Like'
      expect(page).to have_button 'Like'
    end

    xscenario 'user can add a comment' do
      click_link 'Add comment'
      fill_in 'comment_thoughts', with: 'Nice picture'
      click_button 'Create Comment'
      expect(page).to have_content 'Nice picture'
    end

  end

end
