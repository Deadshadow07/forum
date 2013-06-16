# -*- encoding : utf-8 -*-
class Setting < ActiveRecord::Base
  belongs_to :user
  attr_accessible :bg_color, :font, :font_color, :font_size, :decoration, :caption
  validates :font_color, format: { :with => /#([A-Fa-f0-9]{6}|[A-Fa-f0-9]{3})/i},length:{maximum:7}
  validates :bg_color, format: { :with => /#([A-Fa-f0-9]{6}|[A-Fa-f0-9]{3})/i},length:{maximum:7}
  validates :font_size, numericality: {greater_than: 0}
  def self.dafault
    Setting.new({ => })
  end
  end