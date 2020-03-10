class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user, only: [:edit, :update]

  def index
    @users = User.all
    @book = Book.new
    @user = current_user
  end

  def show
    @book = Book.new
    @user = User.find(params[:id])
    @books = @user.books
    flash[:notice] = "Signed in successfully."

  end

  
  def edit
    @user = User.find(params[:id])
    
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
    redirect_to user_path(@user)
    flash[:notice] = "User was successfully updated."
    else
      render :edit
    end
  end
  
  private
    def user_params
        params.require(:user).permit(:name, :introduction, :profile_image)
    end

    def correct_user
      @user = User.find(params[:id])
    if current_user != @user
      redirect_to user_path(current_user)
    end
  end

end

