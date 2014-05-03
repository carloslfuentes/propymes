module ErrorMessagesHelper
  
  def errorFlash(flash)
    message_frame="".html_safe
    
    if flash[:error]
      message_frame += content_tag(:div, flash[:error].html_safe, :class=>"flash error")
    end

    if flash[:warning]
      message_frame += content_tag(:div, flash[:warning].html_safe, :class=>"flash warning")
    end
   
    if flash[:notice]
      message_frame += content_tag(:div, flash.notice.html_safe, :class=>"flash notice")
    end
    
    message_frame
  end

end
