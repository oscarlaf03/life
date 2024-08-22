class Board < ApplicationRecord
  ROW_LIMIT = 100
  COLUMN_LIMIT = 100
  validates :rows, numericality: { less_than_or_equal_to: ROW_LIMIT }
  validates :columns, numericality: { less_than_or_equal_to: ROW_LIMIT }
end
