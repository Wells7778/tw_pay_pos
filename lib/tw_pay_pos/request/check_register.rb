require 'faraday'
require 'json'
require_relative 'base'
require_relative '../response/register'

module TwPayPos
  module Request
    class CheckRegister < Base

      private

      def response_klass
        Response::Register
      end

      def type
        'CONFREG_REQ'
      end

      def version
        '1.0'
      end

      def api_action
        'reg'
      end

      def to_hash
        data = super
        data.delete :nonce
        data
      end
    end
  end
end
