class UsersController < ApplicationController
  # GET /users
  # GET /users.json
  def index
    @users = User.all

    render json: @users
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])

    render json: @user
  end

  def get_info
    @user = User.find_by_UID(params[:uid])

    render json: @user
  end

  # POST /users
  # POST /users.json
  def create
    if params[:group]
      group = Group.find(params[:group])
    else
      group = Group.new
    end
    @user = User.new(user: params[:user])
    @user.group = group

    if @user.save!
      render json: @user, status: :created, location: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    @user = User.find(params[:id])

    if params[:group]
      @user.group = Group.find(params[:group])
      @user.save!
      head :no_content
      return
    end

    if @user.update_attributes(user: params[:user])
      head :no_content
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    head :no_content
  end
end
