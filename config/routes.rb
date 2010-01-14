ActionController::Routing::Routes.draw do |map|

  # admin
  map.namespace :admin do |admin|
    # root
    admin.root :controller => 'home', :action => 'show'
    
    # articles
    admin.resources :articles, :member => [:publish, :retract] do |article|
      article.resources :attachments
      article.resources :revisions, :controller => 'article_revisions'
    end
    admin.resources :attachments
    admin.resources :categories, :member => [:move_up, :move_down]
    
    # galleries
    admin.resources :galleries, :has_many => :images
    admin.resources :videos
    admin.resources :images
    
    # designer
    admin.namespace :designer do |designer|
      designer.root :controller => 'canvases'
      designer.resources :canvases do |canvas|
        canvas.resources :columns do |column|
          column.resources :items
        end
      end
      designer.resources :templates
    end
    
    # radio
    admin.namespace :radio do |radio|
      radio.root :controller => 'sessions'
    end
    
    # extras
    admin.resources :polls
    admin.resources :users
    admin.resources :tools
    
  end

  map.resources :comments

  map.namespace :radio do |radio|
    radio.root :controller => 'home'
    radio.resources :pages
    radio.resources :plays
    radio.resources :promotions
    radio.resource  :schedule
    radio.resources :shows
    radio.resources :signals
    radio.resources :staff
    radio.about     'about', :controller => 'about'
  end
  
  map.namespace :print, :path_prefix => 'the-beacon' do |print|
    print.resources :issues, :only => [:index, :show], :collection => { :latest => :get }
  end

  # article
  map.connect ':category_url/:year/:month/:day/:id',
                  :controller => 'articles',:action => 'show',
                  :year => /\d{4}/, :month => /\d{1,2}/, :day => /\d{1,2}/, :id => /\d+-.*/

  # authentication
  map.register 'register', :controller => 'users', :action => :create
  map.logout   'logout',   :controller => 'user_sessions', :action => :destroy
  map.login    'login',    :controller => 'user_sessions', :action => :new

  # category
  map.category ':category_url', :controller => 'articles'

  # root
  map.root :controller => 'home', :action => 'show'

end
