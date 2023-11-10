class ItemsController < ApplicationController
  skip_before_action :require_login, only: %i[index]
  before_action :set_item, only: %i[edit update destroy]

  def index
    item = if (tag_name = params[:tag_name])
      Item.with_tag(tag_name)
    else
      Item.all
    end
    @items = item.order(created_at: :desc)
  end

  def show
    @item = Item.find(params[:id])
  end

  def new
    @item = Item.new
  end

  def create
    @item = current_user.items.new(item_params)
    tag_list = params[:item][:tag_name].split(/[,、]/)

    if @item.save
      @item.save_tags(tag_list)
      redirect_to item_path(@item), success: t('.success')
    else
      flash.now[:danger] = t('.fail')
      @tag = params[:post][:tag_names].split(/[,、]/)
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @item.update(item_params)
      redirect_to item_path(@item), success: t('.success')
    else
      flash.now[:danger] = t('.fail')
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @item.destroy!
    redirect_to items_path, status: :see_other, success: t('.success')
  end

  private
    def item_params
      params.require(:item).permit(:item_name, :price, :price_range, :target_gender, :item_url, :memo, :item_image, :item_image_cache)
    end

    def set_item
      @item = current_user.items.find(params[:id])
    end
end
