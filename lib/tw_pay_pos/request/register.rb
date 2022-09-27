require 'faraday'
require 'json'
require_relative 'base'
require_relative '../response/register'

module TwPayPos
  module Request
    class Register < Base

      private

      def response_klass
        Response::Register
      end

      def sign?
        false
      end

      def type
        'TREG_REQ'
      end

      def version
        '1.0'
      end

      def to_hash
        super.merge(
          device_type: '11'
        ).compact
      end

      def api_action
        'reg'
      end
    end
  end
end
