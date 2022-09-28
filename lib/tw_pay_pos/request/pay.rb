require 'faraday'
require 'json'
require_relative 'base'
require_relative '../response/pay'

module TwPayPos
  module Request
    class Pay < Base
      attr_accessor :order_id,
                    :barcode,
                    :products,
                    :transaction_id

      def amount=(value_amount)
        @amount = value_amount.to_i * 100
      end

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
        Response::Pay
      end

      def type
        'PAY_REQ'
      end

      def version
        '1.2'
      end

      def api_action
        'payment'
      end

      def to_hash
        super.merge(
          order_no: @order_id.to_s,
          order_desc: @products.to_s,
          time: @payment_time,
          currency: 'TWD',
          amount: @amount,
          auth_code: @barcode,
          ext_data: @transaction_id.to_s,
        ).compact
      end
    end
  end
end
