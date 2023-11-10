class Admin::UsersController < ApplicationController
  before_action :admin_user
  before_action :set_user, only: %i[ show edit destroy update ]

  def index
    @users = User.all.includes(:tasks)
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = 'ユーザーを作成しました'
      redirect_to admin_users_path
    else
      flash[:notice] = '作成できませんでした'
      render :new
    end
  end

  def show
  end

  def new
    @user = User.new
  end

  def destroy
    if @user.destroy
      flash[:notice] = '削除しました'
      redirect_to admin_users_path
    else
      flash[:error] = @user.errors.full_messages.join(', ')
      redirect_to admin_users_path
    end
  end

  def update
    if @user.update(user_params)
      flash[:notice] = 'ユーザー情報を更新しました'
      redirect_to admin_users_path
    else
      flash.now[:error] = @user.errors.full_messages.join(', ')
      render :edit
    end
  end

  def edit
  end


  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :password,
                                :password_confirmation, :admin)
  end

  def admin_user
    unless current_user && current_user.admin?
      flash[:danger] = '管理者以外アクセスできません'
      redirect_to tasks_path
    end
  end
end
