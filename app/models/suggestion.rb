require 'json'

class Suggestion < ActiveRecord::Base

  belongs_to :keyword

  def self.from_ebay_suggestion ebay_suggestion
    raw_json = ebay_suggestion.match(/\._do\(([^\(]*)\)/)[1]
    json = JSON.parse raw_json
    attributes = {
        :value => json['prefix'],
        :variants => json['res']? json['res']['sug'] : []
    }
    new attributes
  end
end
