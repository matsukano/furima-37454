class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new]
  before_action :redirect_root, only: :edit
  before_action :redirect_new_user_session, only: :edit

  def index
    @items = Item.all.order("created_at DESC")
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @item = Item.find(params[:id])
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      redirect_to item_path(@item.id)
    else
      render :edit
    end
  end

  private
  def item_params
    params.require(:item).permit(:item_name, :item_description, :item_category_id, :item_condition_id, :shipping_charge_id, :prefecture_id,  :days_to_ship_id, :price, :image).merge(user_id: current_user.id)
  end

  def redirect_root
    item = Item.find(params[:id])
    if user_signed_in?
      unless current_user.id == item.user_id
        redirect_to new_user_session_path
      end
    end
  end

  def redirect_new_user_session
    unless user_signed_in?
      redirect_to new_user_session_path
    end
  end
end  