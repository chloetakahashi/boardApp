class PasswordResetsController < ApplicationController
  ## In Rails 5 and above, this will raise an error if
  # before_action :require_login
  # is not declared in your ApplicationController.
  skip_before_action :require_login

  # redirect_to password reset page
  def new; end

	# action for when password reset is created
  def create
    @user = User.find_by(email: params[:email])

    @user&.deliver_reset_password_instructions!
    redirect_to login_path, success: t('.success')
  end

  # reset password
  def edit
    @token = params[:id]
    @user = User.load_from_reset_password_token(params[:id])
    return not_authenticated if @user.blank?
  end

  # when user enters and sends the reset request form
  def update
    @token = params[:id]
    @user = User.load_from_reset_password_token(params[:id])
    return not_authenticated if @user.blank?

    # reenter password to confirm and validate
    @user.password_confirmation = params[:user][:password_confirmation]
		# clears the temporary token and updates the password
    if @user.change_password(params[:user][:password])
      redirect_to login_path, success: t('.success')
    else
      flash.now[:danger] = t('.fail')
      render :edit
    end
  end
end
