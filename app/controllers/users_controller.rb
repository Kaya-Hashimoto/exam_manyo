class UsersController < ApplicationController
  skip_before_action :login_required, only: %i[new create]
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = '新規登録しました'
      redirect_to @user
    else
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
    if current_user.admin? || @user == current_user
    else
      flash[:notice] = '自分以外のマイページにはアクセスできません'
      redirect_to tasks_path
    end
  end


  private

  def user_params
    params.require(:user).permit(:name, :email, :password,
                                :password_confirmation)
  end
end
