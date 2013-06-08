module Helpers

  def sign_in_user(user=FactoryGirl.create(:user))
      visit new_user_session_path
      fill_in :user_email, with: user.email
      fill_in :user_password, with: "password"
      click_button "Sign In"
  end
end
