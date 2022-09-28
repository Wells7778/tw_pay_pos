module TwPayPos
  class Config
    attr_accessor :mode,
                  :key,
                  :store_key,
                  :merchant_id,
                  :terminal_id,
                  :secret

    def initialize
      @mode = :sandbox
    end

    def production?
      @mode != :sandbox
    end

    def api_host
      return TwPayPos.config.host if production?
      TwPayPos.config.sandbox_host
    end
  end
end