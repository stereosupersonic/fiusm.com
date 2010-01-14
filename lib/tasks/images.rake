namespace :images do
  task :refresh => :environment do
    require 'rmagick'
    require 'progressbar'

    count = Image.count

    puts "Reprocessing images... (#{count})"
    progress = ProgressBar.new("Progress", count)

    Image.all.each do |i|
      i.file.reprocess!
      progress.inc
    end

    progress.finish    
    puts "done!"
  end
end