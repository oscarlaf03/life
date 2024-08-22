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
  end
end
