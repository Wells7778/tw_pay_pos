require 'faraday'
require 'json'
require_relative 'base'
require_relative '../response/reverse'

module TwPayPos
  module Request
    class Reverse < Base
      attr_accessor :order_id

      def payment_time=(value_payment_time)
        if value_payment_time.instance_of? String
          raise Error, 'Argument format error for payment time' if value_payment_time.size != 14

          @payment_time = value_payment_time
        else
          @payment_time = value_payment_time.strftime("%Y%m%d%H%M%S")
        end
      end

      private

      def response_klass
        Response::Reverse
      end

      def type
        'CANCEL_REQ'
      end

      def version
        '1.0'
      end

      def api_action
        'reverse'
      end

      def to_hash
        {
          order_no: @order_id,
          time: @payment_time.to_s,
        }
      end
    end
  end
end
