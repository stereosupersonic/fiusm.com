class CommentsController < ApplicationController

  def create
    text = params[:comment][:text].gsub("\n", "\n\n").gsub("\n\n\n\n", "\n\n")
    article = Article.find(params[:comment][:article_id])
    facebook_session.post('facebook.comments.add', {
      :text => text,
      :xid => "article-#{article.id}",
      :title => article.headline,
      :url => url_for(article)
    })
    redirect_to article_url(article, :anchor => 'comments')
  end

  #
  # Facebooker is missing some responses for features
  # we'll be using here
  #
  module FacebookerParsers
    include Facebooker
    
    class CommentsAdd < Parser#:nodoc:
      def self.process(data)
        element('comments_add_response', data).content.strip
      end
    end

    Parser::PARSERS.merge!({
      'facebook.comments.add' => CommentsAdd
    })
  end

end