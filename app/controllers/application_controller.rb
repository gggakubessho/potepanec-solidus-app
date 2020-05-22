class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  private

  def api_error_handler(status, err_msg: "")
    case status
    when 400
      err_msg = err_msg.blank? ? "Bad Request" : err_msg
      render status: :bad_request, json: { status: status, message: err_msg }
    when 401
      err_msg = err_msg.blank? ? "Unauthorized" : err_msg
      render status: :unauthorized, json: { status: status, message: err_msg }
    when 404
      err_msg = err_msg.blank? ? "Not Found" : err_msg
      render status: :not_found, json: { status: status, message: err_msg }
    when 500..599
      err_msg = err_msg.blank? ? "Internal Server Error" : err_msg
      render status: :internal_server_error,
             json: { status: status, message: err_msg }
    else
      render status: status, json: { status: status, message: err_msg }
    end
  end

  def authenticate(api_key)
    authenticate_token(api_key) || api_error_handler(401)
  end

  def authenticate_token(api_key)
    authenticate_with_http_token do |token, options|
      Rack::Utils.secure_compare(token, ENV[api_key])
    end
  end
end
