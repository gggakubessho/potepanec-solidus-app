module Potepan
  class APIRequest
    def self.opts
      raise NotImplementedError
    end

    def self.build(params)
      req_info = opts
      uri = "https://presite-potepanec-task5.herokuapp.com"
      url = uri + req_info[:path]
      api_key = ENV["POTEPAN_API_KEY"]
      connection = Faraday.new(url) do |builder|
        builder.request :url_encoded
        builder.headers["Authorization"] = "Bearer #{api_key}"
        builder.response :logger
        builder.response :raise_error
        # builder.response :json, :content_type => "application/json"
      end

      req_info[:params_key].each do |key|
        connection.params[key] = params.fetch(key, "")
      end
      connection
    end

    def self.send(con)
      begin
        response = con.get
        status = response.status
        body = response.body
        case status
        when 400
          raise "BadRequest res:#{body}"
        when 401
          raise "unauthorized res:#{body}"
        when 404
          raise "NotFound res:#{body}"
        when 500..599
          raise "ServerError res:#{body}"
        end
      rescue => e
        raise e.message
      end
      body
    end
  end
end
