require_relative 'pay'

module TwPayPos
  module Response
    class Query < Pay
      def success?
        super && order_success?
      end

      def order_success?
        %w[03 05].include?(order_status)
      end

      def order_status
        @status
      end

      def refund_amount
        @refund_amount / 100
      end

      def cancel_method
        return :reverse if @submit_reverse == 1
        return :refund if @submit_refund == 1
      end
    end
  end
end
