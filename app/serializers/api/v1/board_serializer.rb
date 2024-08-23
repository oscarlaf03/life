module Api
  module V1
    class BoardSerializer < ActiveModel::Serializer
      attributes :id, :runs, :rows, :columns

      has_many :cells, key: "live_cells" do
        object.live_cells
      end
    end
  end
end
