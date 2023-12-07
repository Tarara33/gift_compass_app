# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview
  def reset_password_email
    user = User.first
    UserMailer.reset_password_email(user)
  end
end
