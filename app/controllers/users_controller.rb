class UsersController < ApplicationController
 def new
    @user = User.new
    UserMailer.test_email.deliver
  end

  def create
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id
      redirect_to movies_path, notice: "Welcome aboard, #{@user.firstname}!"
    else
      render :new
    end
  end

  def destroy
    user = User.find(params[:id])
    UserMailer.delete_email(user).deliver
    if user.destroy
      redirect_to admin_users_path
    else
      redirect_to admin_users_path, notice: 'Could not delete user.'
    end
  end

  protected

  def user_params
    params.require(:user).permit(:email, :firstname, :lastname, :password, :password_confirmation)
  end
end
 