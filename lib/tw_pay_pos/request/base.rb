require 'faraday'
require 'json'

module TwPayPos
  module Request
    class Base

      attr_accessor :config
      attr_reader :response_raw

      def initialize(params=nil)
        return unless params.is_a? Hash

        @config = nil
        params.each do |key, value|
          send "#{key}=", value
        end
        post_initialize
      end

      def request
        raise TwPayPos::Error, "Missing Merchant ID" unless config&.merchant_id
        raise TwPayPos::Error, "Missing Terminal ID" unless config&.terminal_id

        res = send_request
        return res unless response_klass
        @response_raw = res.body
        result = JSON.parse res.body rescue {}
        response_klass.new(result, raw: res.body)
      end

      def request_raw
        request_data
      end

      private

      def post_initialize; end

      def response_klass; end

      def sign?
        true
      end

      def version; end

      def nonce
        @nonce ||= SecureRandom.hex(16)
      end

      def to_hash
        {
          type: type,
          store: config.merchant_id,
          terminal: config.terminal_id,
          version: version,
          nonce: nonce,
        }
      end

      def api_action
        raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
      end

      def request_data
        return to_hash unless sign?

        to_hash.merge(sign: verify_code)
      end

      def verify_code
        string_a = to_hash.sort.map { |k, v| "#{k}=#{v}"}.join('&')
        string_b = "#{string_a}&key=#{config.secret}"
        Base64.strict_encode64 Digest::SHA2.digest(string_b)
      end

      def send_request
        conn = Faraday.new(
          url: api_host,
          headers: { 'Content-Type' => 'application/json' }
        )
        res = conn.post(api_action) do |req|
          req.body = request_data.to_json
        end
        return if res.status != 200

        res
      end

      def api_host
        config&.api_host
      end
    end
  end
end