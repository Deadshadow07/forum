# -*- encoding : utf-8 -*-
class Topic < ActiveRecord::Base
  attr_accessible :name
  validates :name, presence: true, length:{minimum: 2,maximum: 200}
  has_many :posts, order: "posts.created_at", dependent: :destroy
  def edit?(user)
    user && user.privilege?
  end
end
