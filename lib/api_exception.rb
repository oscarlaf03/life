module ApiException
  module Handler
    def self.included(klass)
      klass.class_eval do
        ApiException::BaseError.descendants.each do |error_class|
          rescue_from error_class do |err|
            render status: err.status_code, json: { error_code: err.error_code, message: err.message }
          end
        end
      end
    end
  end

  class BaseError < StandardError
    attr_reader :status_code, :error_code
  end

  class NotAllowed < BaseError
    def initialize(msg = nil)
      @status_code = 405
      @error_code = 405
      msg ||= "Ooops, something is not right, try again or contact us"
      super
    end
  end

  class OutOfRange < BaseError
    def initialize(msg = nil)
      @status_code = 416
      @error_code = 416
      msg ||= "Ooops, something is not right, try again or contact us"
      super
    end
  end
end
