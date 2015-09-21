require_relative 'battle.rb'
require_relative 'world.rb'
require_relative 'player.rb'

class Game 
    attr_reader :players
    attr_reader :world

    def initialize(players)
        @world = World.new
        @players = [ ]

        players.times do |i|
            @players << Player.new(i, @world)
        end
    end

    def set_up
        p = 0
        t = @world.territories.keys.shuffle
        
        # allocate territories
        t.size.times do |i|
            @players[p].acquire_territory @world.territories[t[i]]

            p = p + 1
            p = 0 if p >= @players.size
        end

        # initial unit number
        units = 50 - (5 * @players.size)

        # allocate to each player
        player_units = { }
        @players.each { |p| player_units[p] = units }

        # one unit to each territory
        @players.each do |p|
            p.territories.values.each do |t|
                t.armies += 1
                player_units[p] -= 1
            end
        end

        units.times do 
            @players.each do |p|
                p.allocate_units 1 if player_units[p] > 0
                player_units[p] -= 1
            end
        end

        @players.each do |p|
            p.init
        end
    end

    def win?
        @players.select { |p| p.territories.size > 0 }.size == 1
    end

    def turn(p)
        p.allocate_units p.calculate_muster
        p.attack
    end

    def loop
        while not win?
            @players.each { |p| turn p if p.armies > 0 }
        end

        @players.select { |p| p.territories.size > 0 }[0].log_current_territory_names
    end
end
