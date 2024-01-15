class ItemsController < ApplicationController
  skip_before_action :require_login, only: %i[index show]
  before_action :set_item, only: %i[edit update destroy]
  before_action :set_search, only: %i[index]

  def index
    @items = if (tag_name = params[:tag_name])
               Item.with_tag(tag_name).order(created_at: :desc).page(params[:page])
             elsif params[:situation_id]
               items_from_situation
             else
               @q.result(distinct: true).includes(:tags).order(created_at: :desc).page(params[:page])
             end
  end

  def search
    @items = Item.where("item_name like ?", "%#{params[:q]}%")
    respond_to do |format|
      format.js
    end
  end

  def situation; end

  def show
    @item = Item.includes(:tags).find(params[:id])
    @tags = @item.tags.pluck(:tag_name).join(',')
  end

  def new
    @item = Item.new
  end

  def create
    @item = current_user.items.new(item_params)
    tag_list = tag_list_from_params

    ActiveRecord::Base.transaction do
      @item.save!
      @item.save_tags(tag_list)
    end

    redirect_to item_path(@item), success: t('.success')
  rescue StandardError
    flash.now[:danger] = t('.fail')
    @tags = tag_list_from_params
    render :new, status: :unprocessable_entity
  end

  def edit
    @tags = @item.tags.pluck(:tag_name).join(',')
  end

  def update
    tag_list = tag_list_from_params

    ActiveRecord::Base.transaction do
      @item.update!(item_params)
      @item.save_tags(tag_list)
    end

    redirect_to item_path(@item), success: t('.success')
  rescue StandardError
    flash.now[:danger] = t('.fail')
    @tags = tag_list_from_params
    render :edit, status: :unprocessable_entity
  end

  def destroy
    @item.destroy!
    redirect_to items_path, status: :see_other, success: t('.success')
  end

  private

  def item_params
    params.require(:item).permit(:item_name, :price, :price_range, :target_gender, :genre_id, :situation_id, :item_url, :memo, :item_image, :item_image_cache)
  end

  def set_item
    @item = current_user.items.find(params[:id])
  end

  def set_search
    search_params = params[:q]&.dup || {}
    # 男女の検索条件を調整
    if search_params[:target_gender_in] == '1'
      search_params[:target_gender_in] = %w[1 0]
    elsif search_params[:target_gender_in] == '2'
      search_params[:target_gender_in] = %w[2 0]
    end
    @q = Item.ransack(search_params)
  end

  def tag_list_from_params
    params[:item][:tag_name].to_s.split(/[,、]/)
  end

  def items_from_situation # rubocop:disable Metrics/AbcSize
    case params[:situation_id]
    when '1'
      Item.where(situation_id: 1).or(Item.where(genre_id: [1, 2, 3, 5, 6]).where(price_range: [3, 4, 5, 6, 7, 8])).includes(:tags).order(created_at: :desc).page(params[:page])
    when '2'
      Item.where(situation_id: 2).or(Item.where(genre_id: [2, 3, 7, 8, 10]).where(price_range: [0, 1, 2])).includes(:tags).order(created_at: :desc).page(params[:page])
    when '3'
      Item.where(situation_id: 3).or(Item.where(genre_id: [1, 2, 3, 4, 5, 6, 7]).where(price_range: [1, 2, 3, 4, 5])).includes(:tags).order(created_at: :desc).page(params[:page])
    when '4'
      Item.where(situation_id: 4).or(Item.where(genre_id: [2, 7, 8, 9]).where(price_range: [0, 1, 2, 3, 4])).includes(:tags).order(created_at: :desc).page(params[:page])
    when '5'
      Item.where(situation_id: 5).or(Item.where(genre_id: [1, 2, 3, 4, 7, 8, 9]).where(price_range: [0, 1, 2, 3, 4])).includes(:tags).order(created_at: :desc).page(params[:page])
    when '6'
      Item.where(situation_id: 6).or(Item.where(genre_id: [2, 3, 4, 7, 8, 9]).where(price_range: [0, 1, 2, 3, 4])).includes(:tags).order(created_at: :desc).page(params[:page])
    when '7'
      Item.where(situation_id: 7).or(Item.where(genre_id: [2, 4, 7, 8, 9]).where(price_range: [0, 1, 2, 3, 4])).includes(:tags).order(created_at: :desc).page(params[:page])
    end
  end
end
