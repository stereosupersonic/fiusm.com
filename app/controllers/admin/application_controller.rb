class Admin::ApplicationController < ApplicationController

  filter_access_to :all, :context => :site, :require => :manage

  def rescue_action_in_public(exception)
    if exception.is_a?(Authorization::NotAuthorized)
      render_optional_error_file(:not_found)
    else
      super
    end
  end

  def permission_denied
    raise cookies.inspect
    raise Authorization::NotAuthorized
  end

end