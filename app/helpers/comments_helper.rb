module CommentsHelper

  def comments_for_article(article)
    # 207778937892_207807317892raise facebook_session.fql_query('SELECT fromid, time, text, id, username FROM comment WHERE xid = "article-123"').to_yaml
  end

end