require 'faraday'
require 'json'
require_relative 'base'
require_relative '../response/register'

module TwPayPos
  module Request
    class RenewKey < Base

      private

      def response_klass
        Response::Register
      end

      def type
        'TKEY_REQ'
      end

      def version
        '1.0'
      end

      def api_action
        'key'
      end
    end
  end
end
