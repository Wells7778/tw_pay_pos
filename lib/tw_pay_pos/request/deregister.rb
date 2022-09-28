require 'faraday'
require 'json'
require_relative 'register'

module TwPayPos
  module Request
    class Deregister < Register

      private

      def type
        'UNREG_REQ'
      end

      def to_hash
        super.merge(
          registry_key: config.key,
        ).compact
      end
    end
  end
end
