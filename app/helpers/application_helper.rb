# -*- encoding : utf-8 -*-
module ApplicationHelper
  def error_messages_for(object)
    render("layouts/error",object: object)
  end
end
