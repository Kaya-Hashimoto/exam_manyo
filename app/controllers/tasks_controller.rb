class TasksController < ApplicationController
  before_action :set_task, only: %i[ show edit destroy update ]

  def index
    if params[:sort_expired]
      @tasks = Task.all.order(expired_at: "ASC")
    else
      @tasks = Task.all
    end
  end

  def show
  end

  def edit
  end

  def update
    if @task.update(task_params)
      redirect_to task_path, notice: "タスクを編集しました"
    else
      render :edit
    end
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      redirect_to tasks_path, notice: "タスクを作成しました"
    else
      render :new
    end
  end

  def destroy
    @task.destroy
    redirect_to tasks_path, notice: "タスクを削除しました"
  end

  private

  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:title, :content, :expired_at)
  end
end
