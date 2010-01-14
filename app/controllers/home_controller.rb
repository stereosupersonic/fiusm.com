class HomeController < ApplicationController
  def show  
    @canvas = Canvas.find_by_key 'front_page'
  end
end


# #featured_items.canvas.clearfix
#   .column.grid_5.alpha
#     .item
#       %h5.label.centered UM, FIU Brawl
#       .photo
#         %p.image
#           = link_to image_tag('placeholders/home_feature.jpg', :alt => 'Caption')
#         %p.credit
#           == <span class="name">Chris Cutro</span>/<span class="organization">FIUSM.com</span>
#       %h4= link_to 'Miami, FIU have 31 suspended for role in brawl'
#       %p After reviewing a sideline-clearing brawl between players from Miami and FIU, officials announced the suspension of 31 players -- 13 from the Hurricanes, and 18 from Golden Panthers.
#   .column.grid_3.omega
#     .item
#       %h6.label Iran
#       %h2= link_to 'BSU grows from club to council'
#       %p It was not the first such test conducted by Iran, but it came at a time of high tension over Tehran's nuclear program..item
#     .item
#       %h6.label Iran
#       %h3= link_to 'U.S. Is Seeking a Range of Sanctions Against Iran'
#       %p It was not the first such test conducted by Iran, but it came at a time of high tension over Tehran's nuclear program.
#       %ul
#         %li
#           %span.tag Opinion:
#           = link_to 'War re-enactment has valid place in SGA budget'
#         %li
#           - link_to({}, :class => 'video') do
#             = 'Watch Rionda defend bill'
#             = image_tag('icons/video_tiny.gif')