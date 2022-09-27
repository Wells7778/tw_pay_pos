require_relative 'base'
require_relative '../utils/emv_qrcode/decoder.rb'

module TwPayPos
  module Response
    class Pay < Base
      attr_reader :payment_type,
                  :payment_desc


      def order_id
        @order_no
      end

      def bank_transaction_id
        @transaction_id
      end

      def transaction_time
        @transaction_time
      end

      def payment_info
        @payment_lastno
      end

      def success?
        super && result_code == 'SUCCESS'
      end

      private

      attr_reader :result_code
    end
  end
end
