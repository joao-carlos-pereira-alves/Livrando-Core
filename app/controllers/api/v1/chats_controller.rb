# frozen_string_literal: true

module Api
  module V1
    class ChatsController < ApplicationController
      before_action :set_chat, only: %i[ show update destroy ]

      # GET /chats
      # GET /chats.json
      def index
        @chats = Chat.all
      end

      # GET /chats/1
      # GET /chats/1.json
      def show
      end

      # POST /chats
      # POST /chats.json
      def create
        @chat = Chat.new(chat_params)

        if @chat.save
          render :show, status: :created
        else
          render json: @chat.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /chats/1
      # PATCH/PUT /chats/1.json
      def update
        if @chat.update(chat_params)
          render :show, status: :ok
        else
          render json: @chat.errors, status: :unprocessable_entity
        end
      end

      # DELETE /chats/1
      # DELETE /chats/1.json
      def destroy
        @chat.destroy
      end

      private
        # Use callbacks to share common setup or constraints between actions.
        def set_chat
          @chat = Chat.find(params[:id])
        end

        # Only allow a list of trusted parameters through.
        def chat_params
          params.fetch(:chat, {})
        end
    end
  end
end
