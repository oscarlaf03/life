module Api
  module V1
    class BoardSerializer < ActiveModel::Serializer
      attributes :id, :runs, :rows, :columns, :last_affected
      attribute :live_cell_count

      def live_cell_count
        object.live_cells.count
      end

      has_many :cells, key: "live_cells" do
        object.live_cells
      end
    end
  end
end
