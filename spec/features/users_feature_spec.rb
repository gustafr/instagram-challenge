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

  context 'visiting sign up path' do

    before do
      visit '/'
    end

    scenario 'can register as a new user with valid credentials' do
      click_on 'Sign up'
      fill_in 'Email', with:'test@test.com'
      fill_in 'Password', with:'Password1'
      fill_in 'Password confirmation', with:'Password1'
      click_button 'Sign up'
      expect(page).to have_content 'You have signed up successfully'
    end
  end

end
