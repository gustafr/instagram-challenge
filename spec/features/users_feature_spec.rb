require 'rails_helper'

describe 'users' do

  context 'visiting root path and havent logged in' do

    scenario 'is promted a sign in and sign up link' do
      visit '/'
      expect(page).to have_content 'Sign in'
      expect(page).to have_content 'Sign up'
    end

    scenario 'clicks on sign up redirects to sign up path and promts a sign up form ' do
      visit '/'
      click_link 'Sign up'
      expect(page.current_path).to eq '/users/sign_up'
      expect(page).to have_field 'Email'
      expect(page).to have_field 'Password'
      expect(page).to have_field 'Password confirmation'
    end

    scenario 'clicks on sign in redirects to sign in path and promts a sign in form ' do
      visit '/'
      click_link 'Sign in'
      expect(page.current_path).to eq '/users/sign_in'
      expect(page).to have_field 'Email'
      expect(page).to have_field 'Password'
    end

  end
end
