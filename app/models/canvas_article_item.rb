class CanvasArticleItem

  attr_accessor :article_id, :options
  
  def article
    @article ||= Article.find(article_id)
  end

  protected

    def to_yaml_properties
      [:article_id, :options]
    end

end