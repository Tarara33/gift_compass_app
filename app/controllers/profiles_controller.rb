class ProfilesController < ApplicationController
  before_action :set_user, only: %i[show edit update]

  def show
    @items = current_user.items
  end

  def edit; end

  def update
    if @user.update(user_params)
      redirect_back_or_to items_path, success: t('.success')
    else
      flash.now[:danger] = t('.fail')
      render :edit, status: :unprocessable_entity
    end
  end

  private
    def set_user
      @user = User.find(current_user.id)
    end

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end
