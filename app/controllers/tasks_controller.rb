class TasksController < ApplicationController
  
  def index
    @tasks = Task.all
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(item_params)
    if @task.save
      redirect_to root_path
    else 
      format.html {render :new} 
    end

  end

  def show
  end

  def destroy
  end

  private

  def item_params
    params.permit(:title)
  end 
end
