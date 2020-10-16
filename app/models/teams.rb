class Teams < ActiveRecord::Base
    validates_presence_of :sport, :num_of_players
    belongs_to :coaches
  end