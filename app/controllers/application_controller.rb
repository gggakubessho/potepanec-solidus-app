class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
end

private
def api_error_handler(status)
  case status
  when 400
    render status: :bad_request, json: { status: status, message: "Bad Request" }
  when 401
    render status: :unauthorized, json: { status: status, message: "Unauthorized" }
  when 404
    render status: :not_found, json: { status: status, message: "Not Found" }
  when 500..599
    render status: :internal_server_error, json: { status: status, message: "Internal Server Error" }
  else
    render status: status, json: { status: status, message: "Sever Error" }
  end
end