require 'hmac-sha2'
require 'base64'

module Amazon
  class AWSECommerceService
    URL     = 'http://ecs.amazonaws.com/onca/xml'
    NAME    = 'AWSECommerceService'
    VERSION = '2009-10-01'
  end

  class RequestURI
    ACCESS_IDENTIFIER = '1K278C5120RA174VVNG2'
    SECRET_IDENTIFIER = 'GjbOmWGALyhu5G/JyKeisp5eaM7ezQY4lXNvni+d'

    def self.for(service, params = {})
      new(service, params).uri
    end

    def initialize(service, params = {})
      @service = service
      @params  = params

      @params['Service'] = @service::NAME
      @params['Version'] = @service::VERSION
      @params['AWSAccessKeyId'] = ACCESS_IDENTIFIER
    end
  
    def uri
      URI.parse("#{@service::URL}?#{query_string}")
    end
  
    def unsigned_uri
      URI.parse("#{@service::URL}?#{query_string(false)}")
    end
  
    private
  
    def query_string(signed = true)
      signed ? signed_query_string : unsigned_query_string
    end
  
    def signed_query_string
      @params['Timestamp'] = Time.now.iso8601
    
      hmac = HMAC::SHA256.new(SECRET_IDENTIFIER)
      hmac.update(get_request)
      signature = Base64.encode64(hmac.digest).chomp # remove newline after base64 encoding

      signature = query_string_from_hash({ 'Signature' => signature })
      "#{unsigned_query_string}&#{signature}"
    end
  
    def unsigned_query_string
      query_string_from_hash(@params)
    end
  
    def query_string_from_hash(hash)
      hash.sort.collect do |key, value|
        key   = CGI.escape(key.to_s)
        value = CGI.escape(value.to_s)
        [key, value].join('=')
      end.join('&')
    end
  
    def get_request
      uri = URI.parse(@service::URL)
      request  = "GET\n"
      request << "#{uri.host}\n"
      request << "#{uri.path}\n"
      request << "#{unsigned_query_string}"
    end

  end
end