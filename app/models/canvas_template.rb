# == Schema Information
#
# Table name: canvas_templates
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  source     :text
#  created_at :datetime
#  updated_at :datetime
#

class CanvasTemplate < ActiveRecord::Base
  def available_assigns
    if @available_assigns.nil?
      @available_assigns = []
      @assign_types = {}
      
      assigns = source.scan(/\{([^}]+)\}/).collect {|m| m[0] }
      assigns.each do |assign|
        split = assign.split('|')
        name = assign_with_name_only(assign)
        type = assign_with_type_only(assign).try(:to_sym) || :text
        @available_assigns << name
        @assign_types[name] = type
      end
    end
    @available_assigns
  end
  
  def assign_with_name_only(assign)
    assign.split('|')[0]
  end
  
  def assign_with_type_only(assign)
    assign.split('|')[1]
  end
  
  def assign_types
    available_assigns unless @available_assigns
    @assign_types
  end

  def assign_groups
    @assign_groups = available_assigns.collect{|g| g.match(/^([\w\s]+) - .*$/)[1].to_s }.uniq
  end
  
  def assigns_for_group(group)
    available_assigns.select {|a| a =~ /^#{group} - .*$/ }.uniq
  end
  
  def assign_type(assign)
    assign_types[assign]
  end
  
  def compile(assigns = {})
    returning self.source.dup do |source|
      assigns.each_pair do |assign, value|
        source.gsub!(/\{#{assign}(\|.+)?\}/, value)
      end
    end
  end
end
