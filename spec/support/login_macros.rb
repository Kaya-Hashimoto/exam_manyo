module LoginMacros
  def login(user)
    visit new_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_on 'ログイン'
    expect(page).to have_content 'ログインしました'
  end

  def admin_login(admin)
    visit new_session_path
    fill_in 'Email', with: admin.email
    fill_in 'Password', with: admin.password
    click_on 'ログイン'
    expect(page).to have_content '管理者としてログインしました'

  end

  def logout
    click_on 'Logout'
    expect(page).to have_content 'ログアウトしました'
  end
end