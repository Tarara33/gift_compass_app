module LoginSupport
  def login(user)
    visit root_path
    click_link 'ログイン'
    fill_in 'email', with: user.email
    fill_in 'password', with: 'password'
    click_button 'ログイン'
    expect(page).to have_current_path(items_path)
  end
end