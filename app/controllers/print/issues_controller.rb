require 'digest/md5'
require 'open-uri'
require 'rss/2.0'

class Print::IssuesController < ApplicationController
  def latest
    request = issuu('documents.list', :documentSortBy => :publishDate,
                                      :resultOrder => :desc,
                                      :documentStates => 'A',
                                      :access => 'public')
                                      
    raise request.inspect

    issue = issuu_search("user:TheBeacon")['items'].first
    documentId = issue['fields'].select{ |hsh| hsh['name'] =~ /documentId/ }.first['value']
    @front_page_url = "http://image.issuu.com/#{documentId}/jpg/page_1.jpg"
    
    @issue = rss.items.first
  end
  
  def issuu(action, options = {})
    
    secret = 
    
    # prepare options
    options.merge!({
      :action => "issuu.#{action}",
      :apiKey => 'uybcpo3guushuanlbyhs48yoxx0cpwka',
      :format => 'json'
    })

    signature = 'gj4jqr7sfzuccz5vkqohati6n1wxj34k' # API secret

    options.to_a.sort do |a, b|
      a[0].to_s <=> b[0].to_s
    end.collect do |key, value|
      signature << "#{key}#{value}"
    end
    
    signature = Digest::MD5.hexdigest(signature)
    
    options = options.to_a.collect { |key, value| "#{key}=#{value}" }.join('&')
    options << "&signature=#{signature}"

    url = "http://api.issuu.com/1_0?#{options}"
    ActiveSupport::JSON.decode(open(url).read)['rsp']['_content']
  end
  
  def issuu_search(query)
    url = "http://search.issuu.com/api/1_0/generic?q=#{query}&type=document&sort=created&format=json"
    result = open(url).read
    ActiveSupport::JSON.decode(result)
  end
  
  def issuu_request(args)
    
  end
  
end