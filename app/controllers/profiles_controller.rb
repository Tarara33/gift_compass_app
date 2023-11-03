class ProfilesController < ApplicationController

  def show
    @user = User.find(current_user.id)
  end

  def edit

  end

  def update

  end
end
