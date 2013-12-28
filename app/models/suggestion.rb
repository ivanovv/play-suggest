require 'json'

class Suggestion < ActiveRecord::Base

  belongs_to :keyword

  def self.from_play_suggestion suggestion
    puts suggestion
    matches = suggestion[:r].match(/\((\[\{.*\}\])\)/)
    return nil unless matches
    raw_json = matches[1]
    json = JSON.parse raw_json
    attributes = {
        :value => suggestion[:l],
        :variants => json.map {|j| j['s']}
    }
    new attributes
  end
end
