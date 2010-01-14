# == Schema Information
#
# Table name: articles
#
#  id                         :integer         not null, primary key
#  headline                   :string(255)
#  summary                    :string(255)
#  raw_body                   :text
#  created_at                 :datetime
#  updated_at                 :datetime
#  revisable_original_id      :integer
#  revisable_branched_from_id :integer
#  revisable_number           :integer         default(0)
#  revisable_name             :string(255)
#  revisable_type             :string(255)
#  revisable_current_at       :datetime
#  revisable_revised_at       :datetime
#  revisable_deleted_at       :datetime
#  revisable_is_current       :boolean         default(TRUE)
#  views_count                :integer         default(0), not null
#  permalink                  :string(255)
#  first_published_version    :integer
#  published_version          :integer
#  publish_at                 :datetime
#

class Article < ActiveRecord::Base

  acts_as_revisable do
    only :raw_body
  end

  has_many :categorizations, :as => :categorizable
  has_many :categories, :through => :categorizations
  has_many :attachments, :as => :owner, :class_name => '::Attachment'
  has_many :authorships
  has_many :authors, :through => :authorships

  named_scope :published, :conditions => ['published_version IS NOT NULL AND publish_at > ?', DateTime.now]
  named_scope :latest, lambda { |limit| { :order => 'publish_at desc', :limit => (limit || 10) } }

  def after_find # revert to the current version
    if published? && published_version != revisable_number
      revert_to published_version, :without_revision => true
    end
  rescue
    # stop reverting
  end
  
  def attach(asset)
    attachments << Attachment.new(:asset => asset)
  end
  
  class Body < Struct.new(:raw_body)
    def to_html
      @rdiscount ||= RDiscount.new(raw_body || '')
      @rdiscount ? @rdiscount.to_html : raw_body
    end
  end

  def body
    @body ||= Body.new(raw_body)
  end
  
  def default_gallery
    attachments.find_by_asset_type('Gallery', :order => 'id ASC').try(:asset)
  end
  
  def images
    default_gallery.try(:images)
  end
  
  def write_attribute(attr_name, value)
    return super do
      @body = nil if attr_name == :raw_body
    end
  end
  
  def viewed!  
    self.class.record_timestamps = false
    increment!(:views_count)
    self.class.record_timestamps = true
  end
    
  def publish!(publish_time = nil)
    first_published_version = published? ? published_version : nil
    update_attributes({
      :first_published_version => first_published_version,
      :published_version => revisable_number,
      :publish_at => (publish_time || DateTime.now)
    })
  end
  
  def update_published_version!(version = nil)
    raise "Invalid revision" unless version.nil? or find_revision(version)
    update_attribute(:published_version, version || current_revision.revision_number)
  end
  
  def publish_at!(datetime)
    publish!(datetime)
  end
  
  def retract!
    update_attributes({
      :first_published_version => nil, 
      :published_version => nil,
      :publish_at => nil
    })
  end

  def to_param
    headline ? "#{id}-#{headline.parameterize}" : id.to_s
  end
  
  def published_revision?
    current_revision.published_version == revisable_number
  end
  
  def status
    if published?
      :published
    elsif scheduled?
      :scheduled
    elsif draft?
      :draft
    end
  end
  
  def published?
    published_version && (DateTime.now > publish_at)
  end
  
  def scheduled?
    published_version && !published?
  end
  
  def draft?
    !published? && !scheduled?
  end
  
  def first_paragraph
    body.to_html.match(/<p>(.*)<\/p>/)[1] rescue ''
  end
  
  def self.create_and_publish(*args)
    create(*args).publish!(args[0][:publish_at])
  end
  
  def self.create_and_publish!(*args)
    create!(*args).publish!(args[0][:publish_at])
  end
  
  def category_id=(category_id)
    categories.clear
    categories << Category.find(category_id)
  end
  
  def primary_category
    categories.first
  end
  
  def recently_updated?
    updated_at > 5.hours.ago
  end

  def comments
    @comments ||= Comment.for_article(self)
  end
  
  def comments_count
    comments.count
  end

end
