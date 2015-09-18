require_relative "territories.rb"

class Territory
    attr_reader :name
    attr_reader :country
    attr_reader :links

    attr_accessor :owner
    attr_accessor :armies

    def initialize(nm, ctry, lnks)
        @links = lnks
        @name = nm
        @country = ctry
    end
end

class World
    attr_reader :territories

    def initialize
        @territories = { }

        TerritoryDefs::NA.each do |t|
            @territories[t[0].downcase.to_sym] = Territory.new(t[0], :na, t[1..-1])
        end
        
        TerritoryDefs::SA.each do |t|
            @territories[t[0].downcase.to_sym] = Territory.new(t[0], :sa, t[1..-1])
        end
        
        TerritoryDefs::EU.each do |t|
            @territories[t[0].downcase.to_sym] = Territory.new(t[0], :eu, t[1..-1])
        end
        
        TerritoryDefs::Africa.each do |t|
            @territories[t[0].downcase.to_sym] = Territory.new(t[0], :africa, t[1..-1])
        end
        
        TerritoryDefs::Asia.each do |t|
            @territories[t[0].downcase.to_sym] = Territory.new(t[0], :asia, t[1..-1])
        end
        
        TerritoryDefs::Australia.each do |t|
            @territories[t[0].downcase.to_sym] = Territory.new(t[0], :australia, t[1..-1])
        end
    end

    # verify graph 
    def verify
        @territories.each_value do |t| 
            if t.links.include? t.name.downcase.to_sym
                puts "Circular link in " + t.name
            end

            t.links.each do |l|
                if @territories[l].nil?
                    puts "Nil reference for territory link " + l.to_s
                    next
                end

                if not @territories[l].links.include? t.name.downcase.to_sym
                    puts l.to_s + " does not having matching link " + t.name
                end
            end
        end
    end
end

