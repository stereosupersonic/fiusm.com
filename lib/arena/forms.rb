module Arena
  module Forms
    class Form < Arena::HtmlView

      def initialize(record_or_name_or_array, *args, &proc)
        @record_or_name_or_array = record_or_name_or_array
        @args                    = args
        @proc                    = proc
        super({}, &proc)
      end
      
      def compile
        form_for(@record_or_name_or_array, *@args, &@proc)
      end
      
    end
  end
end