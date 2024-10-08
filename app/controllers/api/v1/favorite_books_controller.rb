class FavoriteBooksController < ApplicationController
  before_action :set_favorite_book, only: %i[ show update destroy ]

  # GET /favorite_books
  # GET /favorite_books.json
  def index
    @favorite_books = FavoriteBook.paginate(page: params[:page], per_page: params[:per_page]) if params[:user_id]
  end

  # GET /favorite_books/1
  # GET /favorite_books/1.json
  def show
  end

  # POST /favorite_books
  # POST /favorite_books.json
  def create
    @favorite_book = FavoriteBook.new(favorite_book_params)

    if @favorite_book.save
      render :show, status: :created
    else
      render json: @favorite_book.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /favorite_books/1
  # PATCH/PUT /favorite_books/1.json
  def update
    if @favorite_book.update(favorite_book_params)
      render :show, status: :ok
    else
      render json: @favorite_book.errors, status: :unprocessable_entity
    end
  end

  # DELETE /favorite_books/1
  # DELETE /favorite_books/1.json
  def destroy
    @favorite_book.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_favorite_book
      @favorite_book = FavoriteBook.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def favorite_book_params
      params.require(:favorite_book).permit(:user_id)
    end
end
