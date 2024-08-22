class CreateCells < ActiveRecord::Migration[7.2]
  def change
    create_table :cells do |t|
      t.integer :row
      t.integer :column
      t.boolean :alive, null: false, default: false
      t.references :board, null: false, foreign_key: true

      t.timestamps
    end

    add_index :cells, [ :row, :column, :board_id ], unique: true
  end
end
