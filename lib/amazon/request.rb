require 'open-uri'

module Amazon
  class Request
    def self.open(uri)
      begin
        Nokogiri::XML(open(uri))
      rescue OpenURI::HTTPError => error
        error.message << "\n\n#{error.io.read}"
        raise error
      end
    end
  end
end