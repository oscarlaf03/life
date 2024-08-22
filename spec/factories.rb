FactoryBot.define do
  factory(:board) do
    rows { rand(1..Board::ROW_LIMIT) }
    columns { rand(1..Board::COLUMN_LIMIT) }
    trait :with_one_cell do
      initial_cells { '[{"row": 1, "column":1}]' }
    end
    trait :with_two_cells do
      initial_cells { '[{"row": 1, "column":1}, {"row":2, "column": 2}]' }
    end

    trait :star_shape do
      rows { 50 }
      columns { 50 }
      initial_cells { '[{"row": 25, "column":25}, {"row":25, "column": 24}, {"row":25, "column": 26}, {"row":24, "column": 25}, {"row":26, "column": 25}]' }
    end
  end
end
