module Menu
  class Separator < Item
    def initialize(level)
      @level = level
    end

    def to_s
      tag(:hr)
    end
  end
end