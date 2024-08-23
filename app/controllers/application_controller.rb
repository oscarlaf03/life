class ApplicationController < ActionController::API
  rescue_from StandardError, with: :show_errors

  private

  def show_errors(e)
    render status: 500, json: { error_code: 500, message: e.message || "Ooops, something unexpected happened" }
  end
end
