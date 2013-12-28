class AddKeywordRefToSuggestions < ActiveRecord::Migration
  def change
    add_reference :suggestions, :keyword, index: true
  end
end
