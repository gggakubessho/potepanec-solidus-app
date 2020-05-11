class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
end

private
def api_error_handler(status)
  case status
  when 400
    render status: status, json: { status: status, message: "Bad Request" }
  when 401
    render status: status, json: { status: status, message: "Unauthorized" }
  when 404
    render status: status, json: { status: status, message: "Not Found" }
  when 500..599
    render status: 500, json: { status: status, message: "Internal Server Error" }
  else
    render status: status, json: { status: status, message: "Sever Error" }
  end
end