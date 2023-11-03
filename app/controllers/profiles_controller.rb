class ProfilesController < ApplicationController

  def show
    @user = User.find(current_user.id)
    @items = current_user.items
  end

  def edit

  end

  def update

  end
end
