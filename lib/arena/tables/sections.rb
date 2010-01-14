module Arena::Tables::Sections

  class Section < Arena::BuilderView
    def initialize(attributes_to_display)
      @attributes = attributes_to_display
      super()
    end

    def section_tag
      "t#{self.class.to_s.demodulize.underscore[0..3]}"
    end
  end

  class EdgeSection < Section
    def compile
      b.tag!(section_tag) do
        Arena::Table::EdgeRow.new(@attributes).to_html
      end
    end
  end

  class Header < EdgeSection
  end

  class Footer < EdgeSection
  end

  class Body < Section
    def initialize(attributes_to_display, collection)
      @collection = collection
      super(attributes_to_display)
    end

    def compile
      b.tag!(section_tag) do
        b << "test"
        @collection.each do |record|
          Arena::Table::DataRow.new(record, @attributes).to_html
        end
      end
    end
  end 

end