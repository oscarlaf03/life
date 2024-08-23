module Api
  module V1
    class CellSerializer < ActiveModel::Serializer
      attributes :row, :column
    end
  end
end
