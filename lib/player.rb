class Player
    attr_reader :num
    attr_reader :starting_territories
    attr_reader :armies

    attr_accessor :territories

    def initialize(num, world)
        @world = world
        @territories = { }
        @num = num
        @armies = 0
    end

    def init
        @starting_territories = @territories.dup
    end

    ## @armies => number of armies
    def allocate_units(armies)
        t = @territories.values.map do | tt | # map all territories
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

            [tt, (raw_t_vals.inject(:+) / raw_t_vals.size) * t_mult ]
        end.sort { |a,b| a[1] <=> b[1] }

        armies.times do 
            t[0][0].armies += 1

            t.sort { |a,b| a[1] <=> b[1] }
        end
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
end
