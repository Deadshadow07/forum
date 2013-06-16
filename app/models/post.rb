# -*- encoding : utf-8 -*-
class Post < ActiveRecord::Base
  belongs_to :user
  belongs_to :topic,touch: true
  attr_accessible :body
  validates :user_id, presence:true
  validates :body,presence: true,length:{maximum: 2000}
  validates :topic_id,presence: true
  def edit?(current_user)
    current_user && (current_user.id==user_id || current_user.privilege?)
  end

end
