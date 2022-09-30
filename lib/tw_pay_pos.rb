# frozen_string_literal: true

require_relative "tw_pay_pos/version"
require_relative "tw_pay_pos/config"
require_relative "tw_pay_pos/configure"
require_relative "tw_pay_pos/request"
require_relative "tw_pay_pos/response"
module TwPayPos
  class Error < StandardError; end
  class ChannelTimeout < Error; end
  class SecureKeyExpired < Error; end

  def self.setup
    yield config
  end

  def self.config
    @config ||= TwPayPos::Configure.new
  end
end
