module Arena::Tables::Data

  class DataCell < Arena::Table::Cell
    def initialize(data, record, options = {}, &block)
      @record = record
      super(data, options, &block)
    end
  end
  
  
  class DataRow < Arena::Table::Row
    def initialize(record, attributes_to_display, options = {}, &block)
      @attributes = attributes_to_display
      @record     = record
      @data_cache = {}
      super(options, &block)
    end

    def compile
      b.tr do
        @attributes.each do |attribute|
          data  = attribute_data(attribute)
          klass = Arena::DataCellFinder.find_for(@record, attribute)
          begin
            b << klass.new(data, @record)
          rescue ArgumentError
            raise "Could not send arguments to initializer for: #{klass}"
          end
        end
      end
    end

    protected
    def attribute_data(attribute)
      @data_cache[attribute] ||= @record.__send__(attribute)
    end
  end

end