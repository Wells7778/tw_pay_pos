require_relative 'base'

module TwPayPos
  module Response
    class Pay < Base
      attr_reader :payment_type,
                  :payment_desc,
                  :amount

      def order_id
        @order_no
      end

      def bank_transaction_id
        @transaction_id
      end

      def transaction_time
        /\A(?<year>\d{4})(?<month>\d{2})(?<day>\d{2})(?<hour>\d{2})(?<minute>\d{2})(?<second>\d{2})\Z/ =~ @transaction_time
        DateTime.new(year.to_i, month.to_i, day.to_i, hour.to_i, minute.to_i, second.to_i, '+8')
      end

      def payment_info
        @payment_lastno
      end

      def transaction_id
        @ext_data
      end

      def success?
        super && result_code == 'SUCCESS'
      end

      private

      attr_reader :result_code
    end
  end
end
