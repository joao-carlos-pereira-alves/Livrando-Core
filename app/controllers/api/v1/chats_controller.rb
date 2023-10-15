# frozen_string_literal: true

module Api
  module V1
    class ChatsController < ApplicationController
      before_action :set_chat, only: %i[ show update destroy ]

      # GET /chats
      # GET /chats.json
      def index
<<<<<<< HEAD
        @chats = Chat.all
=======
        @chats = Chat.joins(:chat_users).where(chat_users: { user_id: current_user.id })
>>>>>>> save-dev
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

<<<<<<< HEAD
=======
      def chat_with_chat_user_id
        @chat = Chat.joins(:chat_users).where(chat_users: { id: params[:chat_user_id] }).first

        if @chat.present?
          render partial: 'api/v1/chats/chat', locals: { chat: @chat }
        else
          render json: { message: 'Bate papo não encontrado.' }, status: 404
        end
      end

>>>>>>> save-dev
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
