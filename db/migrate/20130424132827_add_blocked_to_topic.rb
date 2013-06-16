# -*- encoding : utf-8 -*-
class AddBlockedToTopic < ActiveRecord::Migration
  def change
    add_column :topics, :blocked, :boolean
  end
end
