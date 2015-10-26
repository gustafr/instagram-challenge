require 'rails_helper'

describe 'comments' do


  context 'a post is added and user is viewing that post' do

    let! (:post) {create(:post)}
    before do
      visit '/posts'
    end

    scenario 'user is promted with an add comment link' do
      click_link 'First post'
      expect(page).to have_content 'Add comment'
    end

    scenario 'user clicks on add comment link and is promted a comment form' do
      click_link 'First post'
      click_link 'Add comment'
      expect(page).to have_field 'comment_thoughts'
    end

    scenario 'user can add a comment' do
      click_link 'First post'
      click_link 'Add comment'
      fill_in 'comment_thoughts', with: 'Nice picture'
      click_button 'Create Comment'
      expect(page).to have_content 'Nice picture'
    end

  end

end
