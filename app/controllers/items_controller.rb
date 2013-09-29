class ItemsController < ApplicationController
  # GET /items
  # GET /items.json
  def index
    filter = params[:filter].downcase.to_sym

    case filter
    when :all
      @items = Item.all
    when :open
      @items = Item.where(status: "open")
    when :waiting
      @items = Item.where(status: "waiting")
    when :done
      @items = Item.where(status: "done")
    end

    render json: @items
  end

  # GET /items/1
  # GET /items/1.json
  def show
    @item = Item.find(params[:id])

    render json: @item
  end

  # POST /items
  # POST /items.json
  def create
    @item = Item.new(item: params[:item])

    if @item.save
      render json: @item, status: :created, location: @item
    else
      render json: @item.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /items/1
  # PATCH/PUT /items/1.json
  def update
    @item = Item.find(params[:id])

    @user = User.find_by_UID(params[:user])
    @item.user = @user

    if @item.update_attributes(item: params[:item])
      head :no_content
    else
      render json: @item.errors, status: :unprocessable_entity
    end
  end

  # DELETE /items/1
  # DELETE /items/1.json
  def destroy
    @item = Item.find(params[:id])
    @item.destroy

    head :no_content
  end
end
