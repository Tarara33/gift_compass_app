class ItemsController < ApplicationController
  def index
    @items = Item.all
  end

  def show
    @item = Item.find(params[:id])
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params.merge(user_id: 1))

    if @item.save
      redirect_to item_path(@item), success: t('.success')
    else
      flash.now[:danger] = t('.fail')
      render :new, status: :unprocessable_entity
    end
  end

  def edit

  end

  def update

  end

  def destroy

  end

  private
    def item_params
      params.require(:item).permit(:item_name, :price, :price_range, :target_gender, :item_url, :memo)
    end
end
