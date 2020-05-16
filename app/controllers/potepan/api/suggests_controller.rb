class Potepan::Api::SuggestsController < ApplicationController
  TOKEN = ENV["SUGGESTS_API_KEY"]
  before_action :authenticate
  def index

  end

  def authenticate
    authenticate_token || render_unauthorized
  end

  def authenticate_token
    authenticate_with_http_token do |token, options|
      token == TOKEN
    end
  end

  def render_unauthorized
    render json: "unauthorized", status: :unauthorized
  end
end
