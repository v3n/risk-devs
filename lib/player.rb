require_relative 'battle.rb'

class Player
    attr_reader :num
    attr_reader :starting_territories

    attr_accessor :territories

    def initialize(num, world)
        @world = world
        @territories = { }
        @num = num
    end

    def init
        @starting_territories = @territories.dup
    end

    def armies
        @territories.values.reduce(0) { |sum, t| sum += t.armies }
    end

    def attack
        t = @territories.values.map do |t|
            t.links.map do |l|
                (@world.territories[l] != self) ? @world.territories[l] : nil
            end.compact.map do |tt|
                [t, tt, Battle.monte(t.armies, tt.armies)]
            end.reduce do | target, tt |
                target[2] > tt[2] ? target : tt
            end
        end.reduce do | target, t |
            target[2] > t[2] ? target : t
        end

        attack_target(t[0], t[1])
    end

    ## @ret => bool representing if attack occured
    def attack_target(attacker, defender)
        r_atk, r_def = Battle.sim(attacker.armies, defender.armies)
        if r_def < 1
            acquire_territory defender
            attacker.armies = r_atk

            attacker.armies -= 1
            defender.armies += 1

            # balance territory
            while attacker.armies > 1 and eval_territory(defender) > eval_territory(attacker)
                attacker.armies -= 1
                defender.armies += 1
            end 
        end
    end

    ## @armies => number of armies
    def allocate_units(armies)
        armies.times do 
            t = eval_territories

            t[0][0].armies += 1
        end
    end

    def calculate_muster
        n = territories.size / 3
        n < 3 ? 3 : n
    end

    ## @tt => territory to evaluate
    def eval_territory(tt)
        t_mult = 1
        raw_t_vals = tt.links.map do | stt | # map all adjacent territories
            # currently evaluated adjacent territory
            eval_tt = @world.territories[stt]

            # ignore owned territories
            if eval_tt.owner == tt.owner
                next nil
            end

            t_mult += 1

            # higher number = more danger 
            eval_tt.armies.to_f / tt.armies.to_f 
        end.compact

        return -1 if raw_t_vals.nil? or raw_t_vals.size == 0

        (raw_t_vals.inject(:+) / raw_t_vals.size) * (tt.links.size / t_mult) * rand(0.7..1.0)
    end

    ## evaluate all territories for player
    def eval_territories
        @territories.values.map do | tt | # map all territories
            # [Territory, real rating]
            [tt, eval_territory(tt)]
        end.reject { |v| v[1] == -1 }.sort { |a,b| b[1] <=> a[1] }
    end

    ## @t => Territory
    def acquire_territory(t)
        t.owner.remove_territory t if not t.owner.nil?

        t.owner = self
        t.armies = 0

        @territories[t.name.downcase.to_sym] = t
    end

   ## @t => Territory
    def remove_territory(t)
        if t.is_a?(Territory)
            t = t.name.downcase.to_sym
        end

        if @territories.keys.include? t
            @territories[t].owner = nil
            @territories[t].armies = 0
            @territories.delete t
        end
    end

    def log_current_territory_names
        print "Player ##{ @num }: [ "
        @territories.values.each do |t|
            print "#{t.name} => #{t.armies}, "
        end
        print "]\n"
    end    
end
