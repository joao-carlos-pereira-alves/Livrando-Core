# frozen_string_literal: true

module Api
  module V1
    class BookCategoriesController < ApplicationController
      before_action :set_book_category, only: %i[ show update destroy ]

      # GET /book_categories
      # GET /book_categories.json
      def index
        @book_categories = BookCategory.all
      end

      # GET /book_categories/1
      # GET /book_categories/1.json
      def show
      end

      # POST /book_categories
      # POST /book_categories.json
      def create
        @book_category = BookCategory.new(book_category_params)

        if @book_category.save
          render :show, status: :created
        else
          render json: @book_category.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /book_categories/1
      # PATCH/PUT /book_categories/1.json
      def update
        if @book_category.update(book_category_params)
          render :show, status: :ok
        else
          render json: @book_category.errors, status: :unprocessable_entity
        end
      end

      # DELETE /book_categories/1
      # DELETE /book_categories/1.json
      def destroy
        @book_category.destroy
      end

      private
        # Use callbacks to share common setup or constraints between actions.
        def set_book_category
          @book_category = BookCategory.find(params[:id])
        end

        # Only allow a list of trusted parameters through.
        def book_category_params
          params.require(:book_category).permit(:book_id, :category_id)
        end
    end
  end
end
