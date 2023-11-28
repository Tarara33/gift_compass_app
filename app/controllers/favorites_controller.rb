class FavoritesController < ApplicationController

  def create
    @item = Item.find(params[:item_id])
    current_user.bookmark(@item)
  end

  def destroy
    @item = current_user.favorites.find(params[:id]).item
    current_user.unbookmark(@item)
  end
end
