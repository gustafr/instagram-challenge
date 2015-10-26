require 'rails_helper'

describe 'comments' do

  context 'a post is added and user is viewing that post' do

    let! (:post) {create(:post)}
    before do
      visit '/posts'
      click_link 'First post'
    end

    scenario 'user is promted with an add comment link' do
      expect(page).to have_content 'Add Comment'
    end

    scenario 'user clicks on add comment link and is promted a comment form' do
      click_link 'Add comment'
      expect(page).to have_field 'post_comment'
      expect(page).to have_button 'like'
    end

    scenario 'user can add a comment and like a post' do
      click_link 'First post'
      fill_in 'post_comment', with: 'Nice picture'
      click_button 'Like'
      click_button 'Create Comment'
      expect(page).to have_content 'Nice picture'
    end

  end

end
