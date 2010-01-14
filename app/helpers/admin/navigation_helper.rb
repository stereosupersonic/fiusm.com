module Admin::NavigationHelper

  def navigation
    semantic_menu do |root|
      root.add "Articles", admin_articles_url do |articles|
        articles.add "Create New", new_admin_article_url
        articles.add "List",       admin_articles_url
        articles.add "Categories", admin_categories_url
      end
      root.add "Topics",   ''
      root.add "Designer", admin_designer_root_url
      root.add "Media",    ''
      root.separator
      root.add "Galleries", admin_galleries_url
      root.add "Video", admin_videos_url
      root.add "Polls", admin_polls_url
      root.separator
      root.add "Radio", admin_radio_root_url
      root.separator
      root.add "Users", admin_users_url  
    end
  end

  def toolbar(&block)
    semantic_menu :class => :toolbar, &block
  end

end