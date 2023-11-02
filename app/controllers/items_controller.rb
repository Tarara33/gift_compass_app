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
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])

    if @item.update(item_params)
      redirect_to item_path(@item), success: t('.success')
    else
      flash.now[:danger] = t('.fail')
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @item = Item.find(params[:id])
    
    @item.destroy!
    redirect_to items_path, status: :see_other, success: t('.success')
  end

  private
    def item_params
      params.require(:item).permit(:item_name, :price, :price_range, :target_gender, :item_url, :memo)
    end
end
