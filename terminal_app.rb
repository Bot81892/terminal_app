
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

end

class Fighter < Character
    attr_accessor(:name, :attk_damage, :health, :attacks)
    def initialize(name, attk_damage)
        super(name, attk_damage)
    end
    def jab()
        "Player jabs! #{@name} deals #{@attk_damage} damage\n"
    end
    def SpitefulBugWhirlingFish()
        "Player uses spiteful bug whirling fish! #{@name} deals #{@attk_damage} damage\n"
    end
    @attacks = ["jab", "spiteful bug whirling fish"]
end

class Mage < Character
    attr_accessor(:name, :attk_damage, :health)
    def initialize(name, attk_damage)
        super(name, attk_damage)
    end
    def fireball()
        "Player attacks with a firey blast! #{@name} deals #{@attk_damage} damage\n"
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


skeleton = Skeleton.new("Skeleton", 15)

mage = Mage.new("Mage", 20)

print "Welcome to The Reclaimer\n"

print "----story----\n"

print "Please select your class: "
class_name = gets.strip()
print "---------------------------\n"

if (class_name == "Fighter")
    fighter = Fighter.new("Fighter", 20)
    player_type = fighter
    player_attk = fighter.jab

elsif (class_name == "Mage")
    mage = Mage.new("Mage", 20)
    player_type = mage
    player_attk = player_type.fireball
end



battling = true
while (battling)
    print "What attack would you like to use?"
    print "Available attacks are: "
    (player_type.attacks).each do |attack|
        print attack
    end
    printplayer_attk
    
    skeleton.gets_hit(player_type.attk_damage)
    print "Skeletons health is #{skeleton.health}\n"
    if (skeleton.health <= 0)
        print "You are victorious!\n"
        break
    end
    print "-----------------------------\n"
    skeleton.slash
    player_type.gets_hit(skeleton.attk_damage)
    print "Players health is #{player_type.health}\n"
    if (player_type.health <= 0)
        print "Player has died!\n"
        break
    end
    print "-----------------------------\n"
end