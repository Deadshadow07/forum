# -*- encoding : utf-8 -*-
class CreateSettings < ActiveRecord::Migration
  def change
    create_table :settings do |t|
      t.string :font
      t.string :font_color
      t.string :bg_color
      t.string :font_size
      t.string :decoration
      t.string :caption

      t.timestamps
    end
  end
end
