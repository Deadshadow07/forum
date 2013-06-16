# -*- encoding : utf-8 -*-
class User < ActiveRecord::Base
  authenticates_with_sorcery!
  attr_accessible :email, :password, :password_confirmation, :username
  validates :username, presence: true, uniqueness: true, length:{minimum:5,maximum:80}
  validates :password, presence: true, length:{minimum:5}, confirmation: true
  validates :email, presence: true, uniqueness: true, format: { :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i}
  ROLES=["Пользователь","Модератор","Администратор"]
  validates :role, presence: true, inclusion:{in:0...ROLES.size}
  has_many :posts, order: "posts.created_at"
  has_one :setting

  def edit?
    current_user && (current_user.id==user_id || current_user.admin?)
  end
  def privilege?
    role>0
  end
  def user
    role==0
  end
  def admin?
    role==2
  end
user.setting=Setting.default
end
