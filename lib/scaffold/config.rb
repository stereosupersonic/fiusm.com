module Scaffold
  class Config
    attr_accessor :settings
    
    def initialize(&config)
      @settings = {}
      instance_eval(&config)
    end

    def method_missing(symbol, *args, &block)
      if args.empty?
        @settings[symbol]
      else
        value  = (args.size == 1 ? args[0] : args)
        @settings[symbol] = value
      end
    end
  end
end