module Menu
  module Helper
    def menu(options = {}, &block)
      Base.new(controller, options, &block).to_s
    end
  end
end
