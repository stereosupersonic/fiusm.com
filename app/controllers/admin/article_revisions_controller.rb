class Admin::ArticleRevisionsController < Scaffold::Controller

  inherit_resources
  
  before_filter :fetch_article
  
  def index
    @from_revision = 3
    @to_revision   = 4
  end

  class IndexSettings
    def self.columns
      [:created_at, :headline]
    end
  
    def self.linked_column
      :headline
    end
  
    def self.actions
      [:edit, :delete]    
    end    
  end
  
  private
  
  def fetch_article
    @article = Article.find(params[:article_id])
  end
  
end