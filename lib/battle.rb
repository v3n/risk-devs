require_relative 'die.rb'

class Battle
    def self.sim(attacker, defender)
        puts "attacker: " + attacker.to_s
        puts "defender: " + defender.to_s

        return attacker, defender if defender <= 0 or attacker <= 1

        nm_attk = (attacker >= 3) ? 3 : attacker
        nm_attk = 1 if attacker == 2

        nm_dfdr = (defender >= 2) ? 2 : defender
        nm_dfdr = nm_attk if nm_dfdr > nm_attk

        attk = Array.new(nm_attk) { Die.roll }.sort.reverse
        dfdr = Array.new(nm_dfdr) { Die.roll }.sort.reverse

        attack_result = 0
        defend_result = 0

        dfdr.each_index do |i|
            if attk[i] > dfdr[i]
                defend_result = defend_result + 1
            else
                attack_result = attack_result + 1 
            end
        end

        sim(attacker - attack_result, defender - defend_result)
    end

    def self.monte(attacker, defender)
        # iteration number chosen by 
        # http://stats.stackexchange.com/a/34710
        result = Array.new(Random.rand(20) + 1) { |i| sim(attacker, defender) }.map do |p|
            p[1] == 0
        end

        result.inject(0) { |sum, el| (el) ? sum + 1 : sum }.to_f / result.size
    end
end
