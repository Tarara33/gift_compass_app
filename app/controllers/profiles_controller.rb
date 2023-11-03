class ProfilesController < ApplicationController

  def show
    @user = User.find(current_user.id)
    @items = Item.all
  end

  def edit

  end

  def update

  end
end
