FactoryBot.define do
  factory(:board) do
    rows { rand(1..Board::ROW_LIMIT) }
    columns { rand(1..Board::COLUMN_LIMIT) }
    trait :with_one_cell do
      initial_cells { '[{"row": 1, "column":1}]'}
    end
    trait :with_two_cells do
      initial_cells { '[{"row": 1, "column":1}, {"row":2, "column": 2}]'}
    end
  end
end
