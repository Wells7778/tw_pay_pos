require 'faraday'
require 'json'
require_relative 'base'
require_relative '../response/refund'

module TwPayPos
  module Request
    class Refund < Base
      attr_accessor :bank_transaction_id

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
        Response::Refund
      end

      def type
        'REFUND_REQ'
      end

      def version
        '1.0'
      end

      def api_action
        'refund'
      end

      def to_hash
        super.merge(
          transaction_id: @bank_transaction_id,
          currency: 'TWD',
          amount: @amount,
          time: @payment_time.to_s
        )
      end
    end
  end
end
