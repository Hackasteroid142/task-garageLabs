class TasksController < ApplicationController
  before_action :find_task, only: [:show,:edit,:update,:destroy]
  
  def index
    @tasks = Task.all.order("created_at DESC")
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(item_params_new)
    if @task.save
      redirect_to root_path
    else 
      format.html {render :new} 
    end

  end

  def show
  end

  def edit
  end

  def update
    if @task.update(item_params)
      redirect_to root_path
    else
      render 'edit'
    end 
  end


  def destroy
    @task.destroy
    redirect_to root_path
  end

  private

  def item_params_new
    params.permit(:title)
  end 

  def item_params
    params.require(:task).permit(:title)
  end 

  def find_task
     @task = Task.find(params[:id])
  end

end
