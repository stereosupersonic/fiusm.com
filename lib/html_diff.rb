class HtmlDiff
  
  attr_accessor :from, :to

  def initialize(from, to)
    @from = from
    @to   = to
  end
  
  def to_html
    path = File.expand_path('../html_diff_php/script.php', __FILE__)
    systemu("php #{path}", :env => { :from => @from, :to => @to })[1]
  end

end