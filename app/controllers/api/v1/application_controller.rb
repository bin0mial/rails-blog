class Api::V1::ApplicationController < ActionController::API
  include Pundit
  after_action :verify_authorized, unless: :devise_controller?

  private

  def success(data, status = :success, parser = nil, parser_options = {})
    options = { root: :data, **parser_options }
    json_response = parser.nil? ? data : parser.render(data, options)

    render json: json_response, status: status
  end

  def error(errors, status = :bad_request)
    render json: {
      :success => false,
      :errors => errors
    }, :status => status
  end
end
