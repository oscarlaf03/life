require 'rails_helper'

RSpec.describe Board, type: :model do
  describe "assert validations" do
    it "respects row limit" do
      board = Board.new(rows: Board::ROW_LIMIT + 1)
      expect(board.valid?).to be false
      expect(
        board.errors.messages[:rows].any? {
          |message| message.match? "must be less than or equal to #{Board::ROW_LIMIT}"}
        ).to be true
    end

    it "respects column limit" do
      board = Board.new(columns: Board::COLUMN_LIMIT + 1)
      expect(board.valid?).to be false
      expect(
        board.errors.messages[:columns].any? {
          |message| message.match? "must be less than or equal to #{Board::COLUMN_LIMIT}"}
        ).to be true
    end

    it "validates syntax for initial_cells" do
      board = build(:board, :with_one_cell)
      expect(board.valid?).to be true
    end

    it "validates syntax for initial_cells" do
      board = build(:board, :with_two_cells)
      expect(board.valid?).to be true
    end
  end

  describe "#create" do
    it "sets board cells upon creation" do
      board = create(:board, :star_shape)
      expect(board.live_cells.size).to be 5
      expect(board.cells.size).to be (board.rows * board.columns)
    end
  end
end
