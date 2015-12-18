feature 'when a user creates a new account' do
  scenario 'a welcome message is shown' do
    fill_in_register_form
    click_button('Register')
    expect(current_path).to eq '/links'
    expect(page).to have_content 'Welcome Giamir!'
  end

  scenario 'user count increases by 1' do
    fill_in_register_form
    expect { click_button('Register') }.to change { User.count }.by(1)
  end

  scenario 'user email address entered matches the one saved in database' do
    fill_in_register_form
    click_button('Register')
    expect(User.last.email).to eq 'giamir.buoncristiani@gmail.com'
  end

  scenario 'if the there is a mismatching password confirmation no new users are created' do
    fill_in_register_form(password_confirmation: 'giamir')
    expect { click_button('Register') }.not_to change { User.count }
  end

  scenario 'if the password does not match stay in register page' do
    fill_in_register_form(password_confirmation: 'giamir')
    click_button('Register')
    expect(current_path).to eq '/users'
  end

  scenario 'if the password does not match should display a message' do
    fill_in_register_form(password_confirmation: 'giamir')
    click_button('Register')
    expect(page).to have_content 'Password and confirmation password do not match'
  end

  scenario 'if the password does not match should keep email address' do
    fill_in_register_form(password_confirmation: 'giamir')
    click_button('Register')
    expect(find('input[name="email"]')['value']).to eq 'giamir.buoncristiani@gmail.com'
  end

  scenario 'if user doesnt enter an email, stays on same page' do
    fill_in_register_form(email: '')
    click_button('Register')
    expect(page).to have_content('Create an account')
  end

  scenario 'if user doesnt enter an email, doesn\'t register user' do
    fill_in_register_form(email: '')
    expect { click_button('Register') }.not_to change { User.count }
  end

  scenario 'if a user enters an invalid email, stays on same page' do
    fill_in_register_form(email: 'john')
    click_button('Register')
    expect(current_path).to eq '/users'
  end

  scenario 'if a user enters an invalid email, doesn\'t save user' do
    fill_in_register_form(email: 'john')
    expect { click_button('Register') }.not_to change { User.count }
  end

  scenario 'if a user enters an already registered email, doesn\'t save user' do
    fill_in_register_form
    click_button('Register')
    fill_in_register_form
    expect { click_button('Register') }.not_to change { User.count }
    expect(page).to have_content('Email address already registered')
  end
end
