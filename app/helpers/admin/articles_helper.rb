module Admin::ArticlesHelper
  
  def created_at_cell_formatter(date)
    date.strftime('%Y/%m/%d')
  end
  
  def status_cell_formatter(status)
    status.to_s.humanize
  end
  
  def class_for_revision(revision)
    returning '' do |str|
      str << 'published ' if revision.published_revision?
      str << 'viewing'    if resource.revisable_number == revision.revisable_number
    end
  end
  
end