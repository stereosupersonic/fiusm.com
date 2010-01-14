class RadioHosting < ActiveRecord::Base
  belongs_to :show, :class_name => 'RadioShow', :foreign_key => 'show_id'
  belongs_to :host, :class_name => 'RadioHost', :foreign_key => 'host_id'
end

# == Schema Information
#
# Table name: radio_hostings
#
#  id         :integer         not null, primary key
#  host_id    :integer
#  show_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

