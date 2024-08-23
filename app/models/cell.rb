class Cell < ApplicationRecord
  belongs_to :board

  delegate :cells, to: :board

  def should_toggle?
    should_become_alive? || should_be_killed?
  end

  def toggle!
    update(alive: !alive)
  end

  def neighbors
    cells.where(
      row: [ row, row - 1, row + 1 ],
      column: [ column, column - 1, column + 1 ]
      ).where.not(row: row, column: column)
  end

  private

  def lonely?
    live_neighbors.count <= 1
  end

  def crowded?
    live_neighbors.count >= 4
  end

  def should_be_killed?
    alive && (lonely? || crowded?)
  end

  def should_become_alive?
    !alive && live_neighbors.count == 3
  end

  def live_neighbors
    neighbors.where(alive: true)
  end
end
