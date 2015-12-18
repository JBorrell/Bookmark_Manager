feature 'Existing user can sign in' do
  scenario 'Displays welcome message upon sign in' do
    fill_in_register_form
    click_button('Register')
    click_button('Sign Out')
    visit '/'
    fill_in(:email, with: 'giamir.buoncristiani@gmail.com')
    fill_in(:password, with: 'giamir90')
    click_button('Log In')
    expect(page).to have_content('Welcome Giamir!')
  end
end
