class Keyword < ActiveRecord::Base
  has_many :suggestions
  belongs_to :category
  validates :value, :presence => true

  def suggestion_count
    result = 0
    suggestions.each { |s| result += s.variants.count }
    result
  end
end
