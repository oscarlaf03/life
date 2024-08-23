module Api
  module V1
    class BoardsController < ApplicationController
      before_action :set_board, only: %i[ show next]

      def show
        render json: @board
      end

      def create
        @board = Board.new(board_params)

        if @board.save
          render json: { board_id: @board.id }, status: :created, location: @board
        else
          render json: @board.errors, status: :unprocessable_entity
        end
      end

      def next
        next_times.times do
          @board.next!
        end
        render json: @board
      end
      private

      def set_board
        @board = Board.find(params[:id])
      end

      def permit_params
        params.require(:board).permit(:rows, :columns, initial_cells: [ :row,  :column ])
      end

      def board_params
        permit_params.merge(initial_cells: permit_params[:initial_cells].to_json)
      end

      def next_params
        params.permit(:times)
      end

      def next_times
        next_params[:times] || 1
      end
    end
  end
end
