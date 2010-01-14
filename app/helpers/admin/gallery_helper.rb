module Admin::GalleryHelper

  def gallery(gallery, *args)
    options = args.extract_options!
    options[:columns] ||= 5
    haml_tag :div, :class => 'gallery' do
      haml_tag :table do
        ((gallery.images.size / options[:columns]) + 1).times do |row|
          haml_tag :tr do
            start  = row * options[:columns]
            finish = start + 4
            gallery.images[start..finish].each do |image|
              haml_tag :td do
                haml_concat link_to(image_tag(image.file.url(:thumbnail)), [:admin, image])
                haml_tag :br
                haml_concat link_to("Edit", [:admin, image])
                haml_concat ' | '
                haml_concat link_to("Delete", [:admin, image], :method => :delete)
              end
            end
          end
        end
      end
    end
  end
  
end