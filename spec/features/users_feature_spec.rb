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
      fill_in 'Email', with: 'test@test.com'
      fill_in 'Password', with: 'Password1'
      fill_in 'Password confirmation', with: 'Password1'
      click_button 'Sign up'
      expect(page).to have_content 'You have signed up successfully'
    end

    scenario 'cant register as a new user with email address in wrong format' do
      click_on 'Sign up'
      fill_in 'Email', with: 'test.com'
      fill_in 'Password', with: 'Password1'
      fill_in 'Password confirmation', with: 'Password1'
      click_button 'Sign up'
      expect(page).to have_content 'Email is invalid'
    end

    scenario 'cant register with a password shorter than 8 chars' do
      click_on 'Sign up'
      fill_in 'Email', with: 'test@test.com'
      fill_in 'Password', with: 'Pass'
      fill_in 'Password confirmation', with: 'Pass'
      click_button 'Sign up'
      expect(page).to have_content 'Password is too short (minimum is 8 characters)'
    end

    scenario 'cant register with password that doesnt match confirmation' do
      click_on 'Sign up'
      fill_in 'Email', with: 'test@test.com'
      fill_in 'Password', with: 'Password1'
      fill_in 'Password confirmation', with: 'Password2'
      click_button 'Sign up'
      expect(page).to have_content 'Password confirmation doesn\'t match Password'
    end
  end

  context 'visiting sign in path' do

    let! (:user) { create(:user) }
    before do
      visit '/'
    end

    scenario 'user can log in with valid credentials' do
      click_on 'Sign in'
      fill_in 'Email', with: 'test@test.com'
      fill_in 'Password', with: 'Password1'
      click_button 'Log in'
      expect(page).to have_content 'Signed in successfully'
    end

    scenario 'user cant log in with invalid email address' do
      click_on 'Sign in'
      fill_in 'Email', with: 'othertest@test.com'
      fill_in 'Password', with: 'Password1'
      click_button 'Log in'
      expect(page).to have_content 'Invalid email or password'
    end

    scenario 'user cant log in with invalid password' do
      click_on 'Sign in'
      fill_in 'Email', with: 'test@test.com'
      fill_in 'Password', with: 'Password2'
      click_button 'Log in'
      expect(page).to have_content 'Invalid email or password'
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

    scenario 'user can see that he is logged in' do
      expect(page).to have_content 'Signed in as: test@test.com'
    end

    scenario 'user has a sign out link' do
      expect(page).to have_content 'Sign out'
      expect(page).not_to have_content 'Sign in'
      expect(page).not_to have_content 'Sign up'
    end

    scenario 'user can sign out' do
      click_link 'Sign out'
      expect(page).to have_content 'Signed out successfully'
    end

    scenario 'user has a edit user link' do
      expect(page).to have_content 'Edit user'
    end

    scenario 'user has a edit user link' do
      click_link 'Edit user'
      expect(page.current_path).to eq '/users/edit'
      expect(page).to have_field 'Email'
    end
  end

  context 'user is signed in and visiting edit user path' do

    let! (:user) { create(:user) }
    before do
      visit '/'
      click_on 'Sign in'
      fill_in 'Email', with: 'test@test.com'
      fill_in 'Password', with: 'Password1'
      click_button 'Log in'
      click_link 'Edit user'
    end

    scenario 'is promted a form for updating user info' do
      expect(page).to have_field 'Email', with: ('test@test.com')
    end

    scenario 'can update user info' do
      fill_in 'Email', with: ('new@test.com')
      fill_in 'Current password', with: ('Password1')
      click_button 'Update'
      expect(page).to have_content 'Signed in as: new@test.com'
    end

  end

end
