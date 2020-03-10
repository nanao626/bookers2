class BooksController < ApplicationController 
  before_action :authenticate_user!, only: [:show, :index, :create, :edit, :update, :destroy]

  def home
  end

  def about
  end
  
  def index
    @books = Book.all
    @book = Book.new
    @user = current_user
  end
  
  def show
    @book = Book.find(params[:id])
    @user = @book.user
    # @book_new = Book.new
  end
  def create
   @book = Book.new(book_params)
   @book.user_id = current_user.id
   if @book.save
       flash[:notice] = "You have creatad book successfully."
   redirect_to book_path(@book) #成功の場合
   else 
     @books = Book.all
     @users = User.all  
     render 'index' #失敗の場合 
   end
 end
  
def edit
  @book = Book.find(params[:id])
  if current_user != @book.user
    redirect_to books_path
  end
end
  
def update
  @book = Book.find(params[:id])
  if @book.update(book_params)
    flash[:notice] = "You have updated book successfully.."
    redirect_to book_path(@book)
  else
    render 'edit'
  end
end

def destroy
  @book = Book.find(params[:id])
  @book.destroy
  redirect_to books_path
end

private
  def book_params
    params.require(:book).permit(:title, :body)
  end
end

def correct_user
  @user = User.find(params[:id])
  unless @user
    redirect_to(root_url) unless current_user?(@user)
  end
end
