module TwPayPos
  module Response
    class Base
      def initialize(params, resp=nil)
        params.each do |key, value|
          instance_variable_set("@#{key}", value)
        end
      end

      def success?
        status == '000000'
      end

      def error_message
        @return_msg
      end

      def status
        @return_code
      end

      def timeout?
        %w[999990 999996].include? status
      end

      def secret_expired?
        status == '100103'
      end
    end
  end
end
