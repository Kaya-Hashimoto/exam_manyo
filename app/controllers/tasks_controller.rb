class TasksController < ApplicationController
  before_action :set_task, only: %i[ show edit destroy update ]

  def index
    @tasks = current_user.tasks.page(params[:page]).per(5)
    if params[:sort_expired]
      @tasks = @tasks.all.order(expired_at: "DESC").page(params[:page])
    elsif params[:sort_priority]
      @tasks = @tasks.all.order(priority: "DESC").page(params[:page])
    elsif params[:search].present? || params[:status].present?
      @tasks = @tasks.search_title(params[:search]).search_status(params[:status]).page(params[:page])
    elsif params[:label_ids].present?
      @tasks = @tasks.search_label(params[:label_ids]).page(params[:page])
    end
  end

  def show
  end

  def edit
  end

  def update
    if @task.update(task_params)
      flash[:notice] = 'タスクを編集しました'
      redirect_to task_path
    else
      render :edit
    end
  end

  def new
    @task = Task.new
  end

  def create
    @task = current_user.tasks.build(task_params)
    if @task.save
      flash[:notice] = 'タスクを作成しました'
      redirect_to tasks_path
    else
      render :new
    end
  end

  def destroy
    @task.destroy
    flash[:notice] = 'タスクを削除しました'
    redirect_to tasks_path
  end

  private

  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:title, :content, :expired_at, :status, :priority,
    { label_ids: [] })
  end

end
