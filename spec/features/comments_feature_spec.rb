require 'rails_helper'

describe 'comments' do


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

    scenario 'user is promted with an add comment link' do
      expect(page).to have_content 'Add comment'
    end

    scenario 'user clicks on add comment link and is promted a comment form' do
      click_link 'Add comment'
      expect(page).to have_field 'comment_thoughts'
    end

    scenario 'user can add a comment' do
      click_link 'Add comment'
      fill_in 'comment_thoughts', with: 'Nice picture'
      click_button 'Create Comment'
      expect(page).to have_content 'Nice picture'
    end

  end

end
