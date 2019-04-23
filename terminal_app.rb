
class Character 
    attr_accessor(:name, :attk_damage, :health)
    def initialize(name, attk_damage)
        @name = name
        @health = 100
        @attk_damage = attk_damage
    end
    def to_s()
        print "The name of the class is #{@name}, attk damage: #{@attk_damage}, health: #{@health}\n"
    end
    def set_health(health)
        @health = health
    end
    def update_health(health)
        @health += health
    end
    def gets_hit(damage)
        @health -= damage
    end
    def jab()
        print "Player jabs! #{@name} deals #{@attk_damage} damage\n"
    end

end

class Skeleton
    attr_accessor(:name, :attk_damage, :health)
    def initialize(name, attk_damage)
        @name = name
        @health = 100
        @attk_damage = attk_damage
    end
    def to_s()
        print "The name of the class is #{@name}, attk damage: #{@attk_damage}, health: #{@health}\n"
    end
    # def set_health(health)
    #     @health = health
    # end
    def update_health(health)
        @health += health
    end
    def gets_hit(damage)
        @health -= damage
    end
    def slash()
        print "Slash! #{@name} deals #{@attk_damage} damage\n"
    end
        
end



# class Skeleton < Character
#     attr_accessor(:name, :attk_damage, :health)
#     def initialize(name, attk_damage)
#         super(name, attk_damage)
#     end
#     def slash(character_health)
#         print "Slash! #{@name} deals #{@attk_damage} damage\n"
#         character_health -= @attk_damage
#     end

# end

fighter = Character.new("Fighter", 20)
# mage = Character.new("Mage", 20)
skeleton = Skeleton.new("Skeleton", 15)

# fighter.to_s
# skeleton.slash(fighter.health)
# fighter.gets_hit(skeleton.attk_damage)
# fighter.to_s

# mage.to_s

# print "#{fighter}\n"
# print "#{mage}\n"

while (true)

    fighter.jab
    skeleton.gets_hit(fighter.attk_damage)
  
    skeleton.slash
  fighter.gets_hit(skeleton.attk_damage)
    
    if (fighter.health <= 0)
        print "Player has died!\n"
        break
    end
    if (skeleton.health <= 0)
        print "You are victorious!\n"
        break
    end
end