class CreateTeams < ActiveRecord::Migration
    def change
        create_table :teams do |t|
            t.string :sport
            t.integer :num_of_players
            t.string :team_name
            t.string :location
            t.integer :coach_id
        end
    end
end