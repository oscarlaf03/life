class CreateBoards < ActiveRecord::Migration[7.2]
  def change
    create_table :boards do |t|
      t.integer :runs, null: false, default: 0
      t.integer :last_affected, null: false, default: 0
      t.jsonb :initial_cells, null: false, default: '[]'
      t.integer :rows
      t.integer :columns

      t.timestamps
    end
  end
end
