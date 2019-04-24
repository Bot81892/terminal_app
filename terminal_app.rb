require 'colorize'
require 'artii'

class Character 
    attr_accessor(:name, :attk_damage, :health)
    def initialize(name, attk_damage)
        @name = name
        @health = 100
        @attk_damage = attk_damage
        # @items = []
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
#-------------------------------------------------------------------------------------------

#-------------------------------------------------------------------------------------------
#Player classes
class Fighter < Character
    attr_accessor(:name, :attk_damage, :health, :attacks)
    def initialize(name, attk_damage)
        super(name, attk_damage)
        @attacks = [Attack.new("jab", 20), Attack.new("spiteful bug whirling fish", 10)]
    end
    def add_attack(attack)
        @attacks << attack
    end
end

class Mage < Character
    attr_accessor(:name, :attk_damage, :health, :attacks)
    def initialize(name, attk_damage)
        super(name, attk_damage)
        @attacks = [Attack.new("fireball", 20), shadow_volley = Attack.new("shadow volley", 10)]
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
    def initialize(name, attk_damage, health)
        @name = name
        @health = health
        @attk_damage = attk_damage
        # @item_drop = item
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
#------------------------------------------------------------------------------

#------------------------------------------------------------------------------
#METHODS used in the program

def load_dots(color)
    print "\nLoading game"
    1.upto(3) do |n|
        print ".".colorize(color)
        sleep 1
    end 
end

def storyprint(name)
    story = "#{name}, you are the lost heir of the Coder Akademy Kingdom and have been wrongly banished for treason.The enemy has recently taken over to destroy your kingdom, but you have been recalled to fight back for the heridom"
    story.each_char do |c|
        if (c == ".")
            print c
            print "\n"
        else
            print c
            sleep(1.0/20.0)
        end
    end
    print "\n"
    sleep(1)
end

def intro()
    title = Artii::Base.new
    print title.asciify("Welcome to The Reclaimer").colorize(:yellow)
    load_dots("yellow".to_sym)
    print "\nWhat is your name? "
    name = gets.strip
    storyprint(name)
end

def loadmove(time)
    time.times do
        sleep 1
    end
end

def class_select()
    print "Please select your class: "
    class_name = gets.strip()
    selecting_class = true
    while (selecting_class)
        if (class_name == "Fighter")
            return Fighter.new("Fighter", 20)
        elsif (class_name == "Mage")
            return Mage.new("Mage", 20)
        else 
            print "Sorry, that is not a proper class\n"
        end
        #At this point a proper class has not been selected, so we prompt the user again
        print "Please select your class: "
        class_name = gets.strip
    end
end

def spawn_enemies()
    return [Skeleton.new("Skeleton", 15, 100), Skeleton.new("Draugr", 20, 150)]
end

def easter_egg_dialogue()
    print "You: do we need to keep fighting?\n"
    loadmove(2)
    print "Enemy: i don't know, it seems pointless\n"
    loadmove(3)
    print "You: i think so too, can i just have my kingdom back?\n"
    loadmove(3)
    print "Enemy: you know what, sure, we dont want this kingdom anymore, its yours\n"
    loadmove(4)
    print "CONGRATULATIONS, YOU HAVE RECLAIMED YOUR KINGDOM THE PEACEFUL WAY, YOU WIN\n"
    exit!
end

def select_attack()
    print "\nWhat attack would you like to use? "
    attack = gets.strip
    selecting_attack = true
    while (selecting_attack)
        if (attack == "make peace")
            easter_egg_dialogue()
        elsif ((attack.to_i)-1 >= 0 && (attack.to_i-1) < 2)
            return attack.to_i
        else
            print "Sorry, you have not selected an appropriate attack, please try again\n"
        end
        #at this point a proper attack has not been selected
        print "Please select an attack: "
        attack = gets.strip
    end
end

#------------------------------------------------------------------------------


#------------------------------------------------------------------------------
#MAIN 

intro
player_type = class_select()
enemies = spawn_enemies()
enemy = 0


battling = true
while (battling)
    
    #---------------------------------------------------------
    #Player attacks
    print "Available attacks are: "
    (player_type.attacks).each_with_index do |attack, index|
        print "#{index+1}.#{attack.name} "
    end
    
    attack = select_attack()
    player_type.attacks[attack-1].list_attack(player_type.name)
    loadmove(1)

    enemies[enemy].gets_hit(player_type.attacks[attack-1].damage_amount)
    print "#{enemies[enemy].name}'s health is #{enemies[enemy].health}\n"
    if (enemies[enemy].health <= 0)
        print "You are victorious!\n"
        #--------------------------
        #Heal
        print "You have absorbed the enemies spirit and regained health!\n"
        player_type.update_health(100)
        print "You are entering a new battle!\n"
        print "Players health is #{player_type.health}\n"
        #--------------------------
        if (enemy == 1)
            print "You have reclaimed the kingdom!\n"
            break
        end
        enemy += 1
    end
    
    print "-----------------------------\n"

    #-----------------------------------------------------
    #Skeleton attacks
    loadmove(2)
    enemies[enemy].slash
    loadmove(1)
    player_type.gets_hit(enemies[enemy].attk_damage)
    print "Players health is #{player_type.health}\n"
    loadmove(1)
    if (player_type.health <= 0)
        print "Player has died!\n"
        break
    end
    print "-----------------------------\n"
end