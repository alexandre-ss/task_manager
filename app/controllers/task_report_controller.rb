class TaskReportController < ApplicationController
  before_action :authenticate_user!, only: %i[index]

  def index
    @task = Task.where(user_id: current_user.id, status: 10).includes(:comments).order('comments.body asc')
  end

end
