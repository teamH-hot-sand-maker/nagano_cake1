class Admin::ItemsController < ApplicationController
  def new
    @item = Item.new
  end
  
  def index
    @items = Item.page(params[:page]).per(10)
  end

  def edit
    @item = Item.find(params[:id])
  end

  def create
    @item = Item.new(item_params)
    @item.save
    redirect_to admin_item_path(@item)
  end

  def update
    @item = Item.find(params[:id])
    @item.update(item_params)
    redirect_to admin_item_path(@item)
  end

  def show
    @item = Item.find(params[:id])
    @genre = @item.genre.name
  end

  private
   def item_params
     params.require(:item).permit(:genre_id, :name, :introduction, :price, :is_active, :image)
   end

end
