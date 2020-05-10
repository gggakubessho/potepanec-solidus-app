module Potepan
  class APIRequest
    def self.opts
      raise NotImplementedError
    end

    def self.build(params)
      req_info = opts
      url = ENV["POTEPAN_API_URI"] + req_info[:path]
      api_key = ENV["POTEPAN_API_KEY"]
      connection = Faraday.new(url) do |builder|
        builder.request :url_encoded
        builder.headers["Authorization"] = "Bearer #{api_key}"
        builder.response :logger
      end

      req_info[:params_key].each do |key|
        connection.params[key] = params.fetch(key, "")
      end
      connection
    end

    def self.send(con)
      con.get
    rescue => e
      raise e.message
    end
  end
end
