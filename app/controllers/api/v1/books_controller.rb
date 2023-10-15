# frozen_string_literal: true

module Api
  module V1
    class BooksController < ApplicationController
      before_action :set_book, only: %i[ show update destroy ]

      # GET /books
      # GET /books.json
      def index
        @books = Book.all
        @books = Book.filter(params, @books, current_user.id) if filter_params_present?
        @books = @books.paginate(page: params[:page], per_page: params[:per_page]) if params[:page].present? && params[:per_page].present?
      end

      # GET /books/1
      # GET /books/1.json
      def show
      end

      # POST /books
      # POST /books.json
      def create
        @book = Book.new(book_params)
<<<<<<< HEAD
        
=======

>>>>>>> save-dev
        if @book.save
          render :show, status: :created
        else
          render json: @book.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /books/1
      # PATCH/PUT /books/1.json
      def update
        if @book.update(book_params)
          render :show, status: :ok
        else
          render json: @book.errors, status: :unprocessable_entity
        end
      end

      # DELETE /books/1
      # DELETE /books/1.json
      def destroy
        @book.destroy
      end

      private
        # Use callbacks to share common setup or constraints between actions.
        def set_book
          @book = Book.find(params[:id])
        end

        # Only allow a list of trusted parameters through.
        def book_params
          params.require(:book).permit(:added_by, :responsible, :author, :title, 
                                       :description, :status, :negotiation_type, :isbn, :publishing_company, 
                                       :publication_year, :language, :amount, book_categories_attributes: [:category_id])
        end

        def filter_params_present?
          params.slice(
            :title, :author, :description, :publication_year, :publishing_company,
            :isbn, :negotiation_type, :language, :amount, :status, :responsible, :added_by,
            :created_at, :updated_at, :favorite, :category_ids
          ).values.compact.any?
        end
    end
  end
end