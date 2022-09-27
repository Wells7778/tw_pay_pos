module TwPayPos
  module Response
    class Base
      def initialize(params, resp=nil)
        params.each do |key, value|
          instance_variable_set("@#{key}", value)
        end
      end

      def success?
        code == '000000'
      end

      def error_message
        @return_msg
      end

      def status
        @return_code
      end
    end
  end
end
