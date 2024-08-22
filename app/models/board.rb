class Board < ApplicationRecord
  ROW_LIMIT = 100
  COLUMN_LIMIT = 100
  validates :rows, numericality: { less_than_or_equal_to: ROW_LIMIT }
  validates :columns, numericality: { less_than_or_equal_to: COLUMN_LIMIT }
  validate :initial_cells_format

  private

  def initial_cells_format
    return if initial_cells == '[]'

    begin
      cells = JSON.parse(initial_cells)
      unless cells.is_a?(Array) && cells.all? { |cell| cell.is_a?(Hash) && cell.key?('row') && cell.key?('column') && cell['row'].is_a?(Integer) && cell['column'].is_a?(Integer) }
        errors.add(:initial_cells, "must be an array of objects with 'row' and 'column' keys and integer values")
      end
    rescue JSON::ParserError
      errors.add(:initial_cells, "must be a valid JSON array")
    end
  end

end
