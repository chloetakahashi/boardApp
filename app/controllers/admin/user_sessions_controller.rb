class Admin::UserSessionsController < Admin::BaseController
  skip_before_action :require_login, only: %i[new create]
  skip_before_action :check_admin, only: %i[new create]
  layout 'admin/layouts/admin_login'

  def new; end

  def create
    @user = login(params[:email], params[:password])
    if @user
      redirect_to admin_root_path, success: t('admin.user_sessions.create.success')
    else
      flash.now[:danger] = t('admin.user_sessions.create.fail')
      render :new
    end
  end

  def destroy
    logout
    redirect_to admin_login_path, success: t('admin.user_sessions.destroy.success')
  end
end