# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  
  def left_sub_item(iurl, name, div='view-content')
    return "<div>
              #{image_tag 'arrow.png'}
              #{link_to name,'javascript:void(0)', :onclick => 'render("'+iurl+'","'+div+'")'}
        		</div>"
  end
  
end
