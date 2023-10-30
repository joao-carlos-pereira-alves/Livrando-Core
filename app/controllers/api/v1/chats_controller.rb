# frozen_string_literal: true

module Api
  module V1
    class ChatsController < ApplicationController
      before_action :set_chat, only: %i[ show update destroy ]

      # GET /chats
      # GET /chats.json
      def index
        @chats = Chat.joins(:chat_users).where(chat_users: { user_id: current_user.id })
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

      def chat_with_chat_user_id
        @chat = Chat.find(params[:chat_user_id])

        if @chat.present?
          render partial: 'api/v1/chats/chat', locals: { chat: @chat }
        else
          render json: { message: 'Bate papo não encontrado.' }, status: 404
        end
      end

      def get_messages
        chat      = Chat.find(params[:chat_id])
        @messages = chat.messages
        @messages = @messages.paginate(page: params[:page], per_page: params[:per_page]) if params[:page].present? && params[:per_page].present?

        render template: 'api/v1/messages/index'
      end

      def save_message_preview
        chat      = Chat.find(params[:chat_id])
        messages = chat.messages.where.not(user_id: current_user.id)

        if messages.update_all(viewed: true)
          render json: { message: 'Mensagens visualizadas com sucesso' }, status: 200
        else
          render json: { message: 'Não foi possível atualizar as mensagens como visualizadas.' }, status: 400
        end
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
