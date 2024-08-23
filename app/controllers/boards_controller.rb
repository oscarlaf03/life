class BoardsController < ApplicationController
  before_action :set_board, only: %i[ show update destroy next]

  # GET /boards
  def index
    @boards = Board.all

    render json: @boards
  end

  # GET /boards/1
  def show
    render json: @board.public_attributes
  end

  # POST /boards
  def create
    @board = Board.new(board_params)

    if @board.save
      render json: { board_id: @board.id }, status: :created, location: @board
    else
      render json: @board.errors, status: :unprocessable_entity
    end
  end

  def next
    @board.next!
    render json: @board.public_attributes
  end

  # PATCH/PUT /boards/1
  def update
    if @board.update(board_params)
      render json: @board
    else
      render json: @board.errors, status: :unprocessable_entity
    end
  end

  # DELETE /boards/1
  def destroy
    @board.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_board
      @board = Board.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def permit_params
      params.require(:board).permit(:rows, :columns, initial_cells: [:row,  :column])
    end

    def board_params
      permit_params.merge(initial_cells: permit_params[:initial_cells].to_json)
    end
end
