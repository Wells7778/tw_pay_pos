require 'faraday'
require 'json'
require_relative 'base'
require_relative '../response/query'

module TwPayPos
  module Request
    class Query < Base
      attr_accessor :order_id

      private

      def response_klass
        Response::Query
      end

      def type
        'ORDER_REQ'
      end

      def version
        '1.0'
      end

      def api_action
        'queryorder'
      end

      def to_hash
        super.merge(
          order_no: @order_id.to_s,
        ).compact
      end
    end
  end
end
