module Scaffold
  module Helper
  
    DELETE_CONFIRMATION_MESSAGE = "Are you sure you want to delete this record?"
  
    def action(type, target)
      method = "#{type}_action"
      if respond_to?(method)
        send("#{type}_action", target)
      else
        link_to type.to_s.humanize, { :action => type, :id => target.to_param }
      end
    end
  
    def edit_action(target)
      link_to "Edit", { :action => :edit, :id => target.to_param }
    end
  
    def delete_action(target)
      link_to "Delete", { :action => :show, :id => target.to_param }, :method => :delete, :confirm => DELETE_CONFIRMATION_MESSAGE
    end
  
    def format_column(column, target)
      if respond_to?("#{column}_cell_formatter")
        send("#{column}_cell_formatter", target)
      else
        target
      end
    end

  end
end