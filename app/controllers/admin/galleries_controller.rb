class Admin::GalleriesController < Scaffold::Controller

  filter_resource_access
  inherit_resources

  class IndexSettings
    def self.columns
      [:id]
    end

    def self.linked_column
      :id
    end

    def self.actions
      []
    end    
  end

end