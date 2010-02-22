# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def reply_class(level)
    if(level == 1)
      return "first_reply"
    elsif level == 2
      return "second_reply"
    elsif level >= 3
      return "third_reply"
    end
  end
  
  def get_reply_level(comment)
    i = 0
    original = comment
    while(original.class == Comment)
      original = original.commentable
      i = i + 1
    end
    return i
  end
end
