class Admin::ToolsController < Admin::ApplicationController
  
  @@tools = {}
  def self.tool(action, &block)
    raise ArgumentError unless block_given?
    @@tools[action.to_sym] = block
  end

  def show
    key  = params[:id].to_sym
    tool = @@tools[key]
    begin
      tool.call
    render :action => 'test'
    rescue NoMethodError => exception
      if exception.message =~ /The error occurred while evaluating nil\.call/
        raise ActionController::UnknownAction, "No action responded to #{key}"
      else
        raise exception
      end
    end
  end
  
  tool :import_beta_users do
    raise controller.inspect
  end

end