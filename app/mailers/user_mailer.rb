class UserMailer < ActionMailer::Base
  default from: "from@example.com"
 
  def delete_email(user)
    @user = user
    @url  = 'http://localhost:3000/movies'
    mail(to: @user.email, subject: 'Your account has been deleted')
  end

  def test_email
  	mail(to: "neal@gmail.com", subject: "New email")
  end
end
