feature 'Existing user can sign out' do
  scenario 'Displays welcome message upon sign in' do
    fill_in_register_form
    click_button('Register')
    click_button('Sign Out')
    expect(page).to have_content('Goodbye!')
  end
end
