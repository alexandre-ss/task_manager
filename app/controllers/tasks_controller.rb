class TasksController < ApplicationController
  before_action :authenticate_user!, only: %i[index new create destroy search show]
  before_action :user_profile?
  before_action :find_task, only: %i[edit update show confirm_delete destroy delete_comment]
  skip_before_action :verify_authenticity_token, only: %i[search]
    
  def index
    @tasks = Task.where(user_id: current_user)
  end

  def show
    @task = Task.find(params[:id]) 
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.create(task_params)

    if @task.save
      redirect_to tasks_path, notice: "Task was successfully created"
    else
      render :new, notice: @task.errors.full_messages
    end
  end

  def edit
    @task = Task.find(params[:id])
  end
  
  def update
    @task = Task.find(params[:id])
    begin
      @task.update!(task_params)
      redirect_to @task, notice: "Task was successfully updated"
    rescue => exception
      redirect_to task_path(@task), notice: @task.errors.full_messages
    end
  end
  
  def destroy
    @task = Task.find(params[:id])
    if @task.destroy
      flash[:success] = 'Task was successfully deleted.'
      redirect_to tasks_path
    else
      flash[:error] = 'Something went wrong'
      redirect_to tasks_url
    end
  end
  

  def complete
    @task = Task.find(params[:id])
    if @task.update(status: "complete" )
      redirect_to @task, notice: "Task completed"
    else
      flash[:error] = "Something went wrong"
      render :edit
    end
  end

  def incomplete
  end

  private

  def task_params
    params.require(:task).permit(:title, :description, :priority, :share, :status, :user_id)
  end  

  def comment_params
  end 

  def find_task
    @task = Task.find(params[:id])
  end
  

  def sanitize_sql_like(string, escape_character = "\\")
    pattern = Regexp.union(escape_character, "%", "_")
    string.gsub(pattern) { |x| [escape_character, x].join }
  end
end

