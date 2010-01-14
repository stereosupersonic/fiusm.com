# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#   
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Major.create(:name => 'Daley', :city => cities.first)
require 'faker'
require 'progressbar'

article_limit = 50

def issue(name)
  issue_file = Rails.root.join("lib/issues/issue-#{name}.txt")
  data = File.read(issue_file).gsub(/\r\n/, "\n")
  date = Date.parse("20#{name}")
  
  divider = "\n******************************************\n******************************************\n"
  articles = data.split(divider).collect{|a| a.strip }
  articles[0..-2].collect do |article|
    begin
      header, body = article.split('&nbsp;').collect{|p| p.strip }

      section  = header.match(/Section: ([^\n]+)/)[1].strip
      headline = header.match(/Headline: ([^\n]+)/)[1].strip
      
      begin
        unless header.match(/Author: \[no author name found\]/)
          author_matches = header.match(/Author: \s?([^\/]+)\s?(\/\s?([^\n]+))?\s?/)
          author_name, author_title = author_matches[1].to_s.strip, author_matches[3].to_s.strip
        else
          author_name, author_title = nil, nil
        end
      rescue
        author_name, author_title = nil, nil
      end
      
      body = body.to_s.gsub(/\n+|\r+/, "\n").split("\n").collect{|l| l.to_s.strip }.join("\n\n").strip
    rescue NoMethodError => e
      raise "Failed header:\n\n#{header}"
    end

    puts "Issue: #{date}"
    puts "Article: #{headline}"
    puts ""

    {
      :headline => headline,
      :author_name  => author_name,
      :author_title => author_title,
      :section => section,
      :date => date,
      :body => body
    }
  end
end

def old_issues
  returning Hash.new do |issues|
    Dir[Rails.root.join('lib/issues/issue-*.txt')].each do |path|
      articles = issue(path.match(/\d+-\d+-\d+/)[0])
      next if articles.empty?
      date = articles.first[:date]
      issues[date] = articles
    end
  end
end

def article_hash
  {
    :headline => Faker::Lorem.sentence(rand(4) + 2).gsub('.', ''),
    :summary  => Faker::Lorem.sentence(rand(12) + 5).gsub('.', ''),
    :raw_body => Faker::Lorem.paragraphs(rand(6) + 4).join("\n\n")
  }
end

begin
  cached_issues = Marshal.load(File.read('seeds.rb.cache'))
rescue
  # do nothing
end

issues = cached_issues || old_issues

cached_file = File.new('seeds.rb.cache', 'w')
Marshal.dump(issues, cached_file)
cached_file.close

puts "Calculating articles..."
all_articles_count = article_limit || issues.collect{|a,b| b }.flatten.count
puts "Importing #{all_articles_count}..."
all_articles_pb = ProgressBar.new("All Articles", all_articles_count)
article_count = 0
issues.each_pair do |date, articles|
  articles.each do |article|
    break if article_count > all_articles_count
    article_count += 1
    category = Category.find_or_create_by_name(article[:section])
    author   = Author.find_or_create_by_name(article[:author_name])
    category.articles.create_and_publish!({
      :headline => article[:headline],
      :raw_body => article[:body],
      :publish_at => article[:date],
      :updated_at => article[:date],
      :author_id => author.id
    })
    all_articles_pb.inc
  end
end
all_articles_pb.finish

puts "Done!"