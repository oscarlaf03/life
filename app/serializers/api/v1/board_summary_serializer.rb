module Api
  module V1
    class BoardSummarySerializer < ActiveModel::Serializer
      attributes :id, :runs
      attribute :run_limit

      def run_limit
        object.class::RUN_LIMIT
      end
    end
  end
end
