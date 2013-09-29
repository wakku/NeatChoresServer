class TasksController < ApplicationController
  # GET /tasks
  # GET /tasks.json
  def index
    filter = params[:filter].downcase.to_sym if params[:filter]

    case filter
    when :all
      @tasks = Task.all
    when :open
      @tasks = Task.where(status: "open")
    when :waiting
      @tasks = Task.where(status: "waiting")
    when :done
      @tasks = Task.where(status: "done")
    else
      @tasks = Task.all
    end

    render json: @tasks
  end

  # GET /tasks/1
  # GET /tasks/1.json
  def show
    @task = Task.find(params[:id])

    render json: @task
  end

  def check_punishment
    render json: Task.check_punishment(params[:uid])
  end

  # POST /tasks
  # POST /tasks.json
  def create
    @task = Task.new(task: params[:task])
    user = User.order("RANDOM()").first
    @task.user = user

    if @task.save!
      render json: @task, status: :created, location: @task
    else
      render json: @task.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /tasks/1
  # PATCH/PUT /tasks/1.json
  def update
    @task = Task.find(params[:id])

    if @task.update_attributes(task: params[:task])
      head :no_content
    else
      render json: @task.errors, status: :unprocessable_entity
    end
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.json
  def destroy
    @task = Task.find(params[:id])
    @task.destroy

    head :no_content
  end
end
