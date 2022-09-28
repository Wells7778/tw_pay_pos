require_relative 'base'

module TwPayPos
  module Response
    class Register < Base
      attr_reader :store_key, :key, :key_expiry

      def key_expire_at
        /\A(?<year>\d{4})(?<month>\d{2})(?<day>\d{2})(?<hour>\d{2})(?<minute>\d{2})(?<second>\d{2})\Z/ =~ @key_expiry
        DateTime.new(year.to_i, month.to_i, day.to_i, hour.to_i, minute.to_i, second.to_i, '+8')
      end
    end
  end
end
