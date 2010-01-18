authorization do
  role :admin do
    includes :guest, :photo_editor
    has_permission_on :site, :to => :manage
  end
  
  role :photo_editor do
    has_permission_on :gallery, :to => :manage
  end
  
  role :guest do
    has_permission_on :gallery, :to => :create
  end
end
 
privileges do
  privilege :manage, :includes => [:create, :read, :update, :delete]
  privilege :create, :includes => :new
  privilege :read,   :includes => [:index, :show]
  privilege :update, :includes => :edit
  privilege :delete, :includes => :destroy
end