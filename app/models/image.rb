# == Schema Information
#
# Table name: images
#
#  id                :integer         not null, primary key
#  title             :string(255)
#  credit            :string(255)
#  caption           :text
#  file_file_name    :string(255)
#  file_content_type :string(255)
#  file_file_size    :string(255)
#  file_updated_at   :string(255)
#  gallery_id        :integer
#  created_at        :datetime
#  updated_at        :datetime
#

class Image < ActiveRecord::Base
  has_attached_file :file, :styles => {
    :small => '75x75#',
    :thumbnail => '137x137#',
    :preview => '550x366#',
    :featured_front_page => '380x250#',
    :article_inline => '300',
    :article_wide => '620x300#'
  }
  
  belongs_to :gallery
  
  def next_in_gallery
    gallery.image_after(self) if gallery
  end
  
  def previous_in_gallery
    gallery.image_before(self) if gallery    
  end
end
