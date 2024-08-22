class Board < ApplicationRecord
  ROW_LIMIT = 100
  COLUMN_LIMIT = 100
  validates :rows, numericality: { less_than_or_equal_to: ROW_LIMIT }
  validates :columns, numericality: { less_than_or_equal_to: COLUMN_LIMIT }
  validate :initial_cells_format

  has_many :cells

  after_create :init_board

  def live_cells
    cells.where(alive: true)
  end

  private

  def init_board
    create_initial_cells
    fill_rest_of_board
  end

  def init_cells
    JSON.parse(initial_cells)
  end

  def create_initial_cells
    init_cells.each do |cell|
      Cell.create(**cell, alive: true, board: self)
    end
  end

  def fill_rest_of_board
    (1..rows).each do |row|
      (1..columns).each do |column|
        unless taken?(row, column)
          Cell.create(row: row, column: column, board: self)
        end
      end
    end
  end

  def taken?(row, column)
    live_cells.where(row: row, column: column).present?
  end



  def initial_cells_format
    return if initial_cells == '[]'

    begin
      cells = init_cells
      unless cells.is_a?(Array) && cells.all? { |cell| cell.is_a?(Hash) && cell.key?('row') && cell.key?('column') && cell['row'].is_a?(Integer) && cell['column'].is_a?(Integer) }
        errors.add(:initial_cells, "must be an array of objects with 'row' and 'column' keys and integer values")
      end
    rescue JSON::ParserError
      errors.add(:initial_cells, "must be a valid JSON array")
    end
  end

end
