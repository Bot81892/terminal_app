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

#-----------------------------------------------------------------------------------------------
#Attacks
class Attack
    attr_accessor(:name, :damage_amount)
    def initialize(name, damage_amount)
        @name = name
        @damage_amount = damage_amount
    end
    def list_attack(character)
        print "Player uses #{@name}! #{character} deals #{@damage_amount} damage\n"
    end
end

jab = Attack.new("jab", 20)
sbwf = Attack.new("spiteful bug whirling fish", 10)

fireball = Attack.new("fireball", 20)
shadow_volley = Attack.new("shadow volley", 10)
#-------------------------------------------------------------------------------------------

#-------------------------------------------------------------------------------------------
#Player classes
class Fighter < Character
    attr_accessor(:name, :attk_damage, :health, :attacks)
    def initialize(name, attk_damage)
        super(name, attk_damage)
        @attacks = []
    end
    def add_attack(attack)
        @attacks << attack
    end
end

class Mage < Character
    attr_accessor(:name, :attk_damage, :health, :attacks)
    def initialize(name, attk_damage)
        super(name, attk_damage)
        @attacks = []
    end
    def add_attack(attack)
        @attacks << attack
    end
end
#------------------------------------------------------------------------------------




#------------------------------------------------------------------------------------
#Enemy class
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
draugr = Skeleton.new("Draugr", 25)



print "Welcome to The Reclaimer\n"
print "----story----\n"

print "Please select your class: "
class_name = gets.strip()
print "---------------------------\n"

if (class_name == "Fighter")
    fighter = Fighter.new("Fighter", 20)
    fighter.add_attack(jab)
    fighter.add_attack(sbwf)
    player_type = fighter
elsif (class_name == "Mage")
    mage = Mage.new("Mage", 20)
    mage.add_attack(fireball)
    mage.add_attack(shadow_volley)
    player_type = mage
end




battling = true
while (battling)
    enemy = 0
    #---------------------------------------------------------
    #Player attacks
    print "Available attacks are: "
    (player_type.attacks).each_with_index do |attack, index|
        print "#{index+1}.#{attack.name} "
    end
    print "\nWhat attack would you like to use? "
    attack = gets.strip.to_i

    player_type.attacks[attack-1].list_attack(player_type.name)

    skeleton.gets_hit(player_type.attacks[attack-1].damage_amount)
    print "Skeletons health is #{skeleton.health}\n"
    if (skeleton.health <= 0)
        print "You are victorious!\n"
        break
    end
    
    print "-----------------------------\n"

    #-----------------------------------------------------
    #Skeleton attacks
    skeleton.slash
    player_type.gets_hit(skeleton.attk_damage)
    print "Players health is #{player_type.health}\n"
    if (player_type.health <= 0)
        print "Player has died!\n"
        break
    end
    print "-----------------------------\n"
end