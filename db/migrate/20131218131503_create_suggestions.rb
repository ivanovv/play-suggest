class CreateSuggestions < ActiveRecord::Migration
  def change
    create_table :suggestions do |t|
      t.string :value
      t.string :variants, :array => true, :default => []

      t.timestamps
    end
  end
end
