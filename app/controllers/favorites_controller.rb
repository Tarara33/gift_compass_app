class FavoritesController < ApplicationController

  def create
    @item = Item.find(params[:item_id])
    current_user.bookmark(@item)
    respond_to do |format|
      format.html { redirect_to @item }
      format.turbo_stream
    end
  end

  def destroy
    @item = current_user.favorites.find(params[:id]).item
    current_user.unbookmark(@item)
    respond_to do |format|
      format.html { redirect_to @item, status: :see_other }
      format.turbo_stream
    end
  end
end
