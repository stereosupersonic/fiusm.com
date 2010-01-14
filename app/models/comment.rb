class Comment
  
  @@attributes = [:xid, :object_id, :post_id, :fromid, :time, :text, :id, :username, :reply_xid]

  attr_accessor :xid, :object_id, :post_id, :fromid, :time, :text, :id, :username, :reply_xid
  
  def self.create(*args)
    
  end
  
  def initialize(hash)
    hash.each_pair do |key, value|
      send("#{key}=", value)
    end
  end

  def created_at
    @created_at ||= Time.at(time.to_i)
  end

  def from
    Facebooker::User.new(fromid)
  end
  
  def body
    @body ||= Article::Body.new(text)
  end
  
  def self.for_article(article, *args)
    fql = "SELECT #{@@attributes.join(', ')} FROM comment WHERE xid = 'article-#{article.id}'"
    query(fql).collect{|hash| new(hash) }
  end
  
  def self.limit
    
  end
  
  protected
  
    def self.session
      Facebooker::Session.current
    end
    
    def session
      self.class.session
    end
    
    def self.query(query)
      session.fql_query(query)
    end
    
    def query
      self.class.query
    end

end