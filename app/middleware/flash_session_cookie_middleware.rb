require 'rack/utils'
 
class FlashSessionCookieMiddleware
  def initialize(app, session_key = '_session_id')
    @app = app
    @session_key = session_key
  end
 
  def call(env)
    if env['HTTP_USER_AGENT'] =~ /^(Adobe|Shockwave) Flash/
      params = ::Rack::Utils.parse_query(env['QUERY_STRING'])
      env['HTTP_COOKIE'] = cookies_from_params(params).freeze unless params[@session_key].nil?
    end
    @app.call(env)
  end
  
  def cookies_from_params(params)
    
    params = params.to_a.select do |key, value|
      key =~ /_session_key$/ || key == @session_key
    end
    
    raise params.inspect
    
    cookie_string = 
      params.to_a.collect do |pair|
        pair.join('=')
      end.join('; ')
    return cookie_string
  end
end