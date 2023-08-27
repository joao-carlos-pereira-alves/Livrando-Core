# frozen_string_literal: true

module Api
  module V1
    class TradesController < ApplicationController
      before_action :set_trade, only: %i[ show update destroy ]

      # GET /trades
      # GET /trades.json
      def index
        @trades = Trade.all
      end

      # GET /trades/1
      # GET /trades/1.json
      def show
      end

      # POST /trades
      # POST /trades.json
      def create
        @trade = Trade.new(trade_params)

        if @trade.save
          render :show, status: :created
        else
          render json: @trade.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /trades/1
      # PATCH/PUT /trades/1.json
      def update
        if @trade.update(trade_params)
          render :show, status: :ok
        else
          render json: @trade.errors, status: :unprocessable_entity
        end
      end

      # DELETE /trades/1
      # DELETE /trades/1.json
      def destroy
        @trade.destroy
      end

      private
        # Use callbacks to share common setup or constraints between actions.
        def set_trade
          @trade = Trade.find(params[:id])
        end

        # Only allow a list of trusted parameters through.
        def trade_params
          params.require(:trade).permit(:negotiator_id, :sender_id, :status, :category, :negociation_date)
        end
    end
  end
end
