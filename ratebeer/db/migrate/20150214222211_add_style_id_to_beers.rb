class AddStyleIdToBeers < ActiveRecord::Migration
  def change
    change_table :beers do |t|
      t.integer :style_id
    end
  end
end
