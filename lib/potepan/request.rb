module Potepan
  module Request
    class SuggestsRequest < APIRequest
      def self.opts
        req_info = {}
        req_info[:path] = "/potepan/api/suggests"
        req_info[:params_key] = [:keyword, :max_num]
        req_info
      end
    end
  end
end
