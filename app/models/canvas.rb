class Canvas < ActiveRecord::Base
  serialize :assigns
  
  def template
    @template ||= CanvasTemplate.first
  end
  
  def hash
    article1 = {
      :class_name => 'Article',
      :id => 1,
      :render_options => {
        :photo => :featured_front_page
      }
    }
    column1 = [article1]
    column2 = [article2, article3]
    [column1, column2]
  end
  
  def compile
    template.compile(assigns)
  end
end

# == Schema Information
#
# Table name: canvases
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  key        :string(255)
#  data       :text
#  created_at :datetime
#  updated_at :datetime
#

