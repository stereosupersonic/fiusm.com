module ArticlesHelper
  
  def featured_story
    collection.first
  end
  
  def article_byline(article)
    article.authors.to_sentence(:last_word_connector => ' and ') # AP style
  end

end