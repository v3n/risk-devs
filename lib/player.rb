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
        @territories.reduce { |sum, t| sum += t.armies }
    end
    ## @armies => number of armies
    def allocate_units(armies)
        armies.times do 
            t = eval_territories

            t[0][0].armies += 1
        end

        @armies += armies
    end

    def calculate_muster
        n = armies.size / 3
        n < 3 ? 3 : n
    end

    def eval_territories
        @territories.values.map do | tt | # map all territories
            t_mult = 0
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

            # [Territory, real rating]
            [tt, (raw_t_vals.inject(:+) / raw_t_vals.size) * t_mult * rand(0.9..1.1) ]
        end.sort { |a,b| b[1] <=> a[1] }
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
        if @territories.keys.include? t
            @territories[:t].owner = nil
            @territories[:t].armies = 0
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
