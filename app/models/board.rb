class Board < ApplicationRecord
  ROW_LIMIT = 100
  COLUMN_LIMIT = 100
  RUN_LIMIT = 100
  validates :rows, numericality: { less_than_or_equal_to: ROW_LIMIT }
  validates :columns, numericality: { less_than_or_equal_to: COLUMN_LIMIT }
  validate :initial_cells_format

  has_many :cells, dependent: :destroy

  after_create :init_board

  def live_cells
    cells.where(alive: true)
  end

  def next!
    raise OutOfRange::BadRequest.new "Over Board number of runs limit" if runs + 1 >= RUN_LIMIT
    affected = cells_to_analize.select { |cell| cell.should_toggle? }
    if affected.size.zero? && !runs.zero?
      raise ApiException::NotAllowed.new "Board concluded, nothing changed after run number #{runs}"
    end
    affected.each(&:toggle!)
    update(runs: runs + 1, last_affected: affected.size)
  end

  private

  def cells_to_analize
    live_neighbors_ids = live_cells.map { |cell| cell.neighbors.pluck(:id) }.flatten.uniq
    live_cells.or(cells.where(id: live_neighbors_ids))
  end

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
    existing_cells = live_cells.pluck(:row, :column)
    new_cells = []

    (1..rows).each do |row|
      (1..columns).each do |column|
        unless existing_cells.include?([ row, column ])
          new_cells << { row: row, column: column, board_id: id }
        end
      end
    end

    Cell.insert_all(new_cells) unless new_cells.empty?
  end

  def taken?(row, column)
    live_cells.where(row: row, column: column).present?
  end

  def initial_cells_format
    return if initial_cells == "[]"

    begin
      cells = init_cells
      unless cells.is_a?(Array) && cells.all? { |cell| cell.is_a?(Hash) && cell.key?("row") && cell.key?("column") && cell["row"].is_a?(Integer) && cell["column"].is_a?(Integer) }
        errors.add(:initial_cells, "must be an array of objects with 'row' and 'column' keys and integer values")
      end
    rescue JSON::ParserError
      errors.add(:initial_cells, "must be a valid JSON array")
    end
  end
end
