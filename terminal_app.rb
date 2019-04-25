
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
    def show_health()
        print "Player's health is #{@health}\n"
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
    def list_attack(dmg)
        print "Player uses #{@name} and deals #{dmg} damage\n"
    end
end
#-------------------------------------------------------------------------------------------

#-------------------------------------------------------------------------------------------
#Player classes
class Fighter < Character
    attr_accessor(:name, :attk_damage, :health, :attacks)
    def initialize(name, attk_damage)
        super(name, attk_damage)
        @attacks = [Attack.new("jab", 20), Attack.new("spiteful bug whirling fish", (15..25).to_a)]
        @items = [Potion.new("potion of strong healing", 60)]
    end
    def list_attacks()
        print "Available attacks are: "
        @attacks.each_with_index do |attack, index|
            print "#{index+1}.#{attack.name} "
        end
    end
end

class Mage < Character
    attr_accessor(:name, :attk_damage, :health, :attacks)
    def initialize(name, attk_damage)
        super(name, attk_damage)
        @attacks = [Attack.new("fireball", 20), shadow_volley = Attack.new("shadow volley", (15..25).to_a)]
        # (15..25).to_a
        @items = [Potion.new("potion of weak healing", 30)]
    end
    def list_attacks()
        print "Available attacks are: "
        @attacks.each_with_index do |attack, index|
            print "#{index+1}.#{attack.name} "
        end
    end
    
end
#------------------------------------------------------------------------------------

#------------------------------------------------------------------------------------
#Enemy class
class Skeleton
    attr_accessor(:name, :health)
    def initialize(name, health)
        @name = name
        @health = health
        @attacks = [Attack.new("Slash", 15)]
        # @item_drop = item
    end
    def to_s()
        print "The name of the class is #{@name}, attk damage: #{@attk_damage}, health: #{@health}\n"
    end
    def update_health(health)
        @health += health
    end
    def gets_hit(damage)
        @health -= damage
    end
    def attack_player()
        print "#{@attacks[0].name}! #{@name} deals #{@attacks[0].damage_amount} damage\n"
        return @attacks[0].damage_amount
    end
    # def slash()
    #     print "Slash! #{@name} deals #{@attk_damage} damage\n"
    # end
    def show_health()
        if @health < 0
            print "#{@name}'s health is 0\n"
        else
            print "#{@name}'s health is #{@health}\n"
        end
    end
end

#------------------------------------------------------------------------------
#new
class Potion
    attr_accessor(:name, :health_increase)
    def initialize(name, health)
        @name = name
        @health_increase = health
    end
end
#------------------------------------------------------------------------------

#------------------------------------------------------------------------------
#METHODS used in the program

def load_game()
    print "\nHang tight, game is loading".colorize(:cyan)
    3.times do 
        print ".".colorize(:red)
        sleep 1
    end 
end

def storyprint(name)
    story = "#{name}, you are the lost heir of the Coder Akademy Kingdom and have been wrongly banished for treason.The enemy has recently taken over to destroy your kingdom, but you have been recalled to fight back for the heirdom"
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
    load_game
    print "\nWhat is your name? "
    name = gets.strip
    # storyprint(name)      #undo comment to get the story description at the start
end

def character_description()
    print "Please choose your path:\n"
    # sleep 2
    print "Mage\n"
    print "-----\n"
    print "The mage class uses magic to inflict damage on the enemy by casting spells. The mage's attacks are:\n"
    print "1. Fireball: unleashes a firey blast on the enemy (attack damage: 20)\n"
    print "2. Shadow volley: casts dark magic on the enemy (attack damage: 10)\n\n"
    # sleep 6
    print "Fighter\n"
    print "--------\n"
    print "The fighter class uses sacred techniques passed down in his family for generations. The fighter's attacks are:\n"
    print "1. Jab: jab the enemy in the face with your shortsword (attack damage: 20)\n"
    print "2. Spiteful bug whirling fish: spinning attack that dazes you and inflicts minimal damage (attack damage: 10)\n"
    print "----------------------------------------------------------------------------------------------------------\n"
    # sleep 2
end

def confirm_class(character_class)
    print "Are you sure you want to be a #{character_class}? (Y/N): "
    answer = gets.strip
    confirming = true

    while (confirming)
        if (answer == "Y")
            print "Success! You have chosen to be a #{character_class}!".colorize(:green)
            print "\n"
            return true
        elsif (answer == "N")
            return false
        end
        print "Sorry, you didnt enter the right input".colorize(:orange)
        print "\n"
        print "Are you sure you want to be a #{character_class}? (Y/N): "
        answer = gets.strip
    end
end


def class_select()
    character_description()
    print "Which class would you like to select: "
    class_name = gets.strip().capitalize        #get the class name from the user
    selecting_class = true
    while (selecting_class)
        if (class_name == "Fighter")
            if (confirm_class("Fighter"))
                return Fighter.new("Fighter", 20)
            else
                #do nothing, going to reprompt user to select a class
            end
        elsif (class_name == "Mage")
            if (confirm_class("Mage"))
                return Mage.new("Mage", 20)
            else
                #do nothing, going to reprompt user to select a class
            end
        else 
            #At this point a proper class has not been selected, so we prompt the user again
            print "Sorry, that is not a proper class\n"

        end
        print "Please select your class, you can choose to be a mage or a fighter: "
        class_name = gets.strip
    end
end

def spawn_enemies()
    return [Skeleton.new("Skeleton", 100), Skeleton.new("Draugr", 150)]
end

def easter_egg_dialogue()
    print "You:".colorize(:green) + " do we need to keep fighting?\n"
    sleep 2
    print "Enemy:".colorize(:red) + " i don't know, it seems pointless\n"
    sleep 3
    print "You:".colorize(:green) + " i think so too, can i just have my kingdom back?\n"
    sleep 3
    print "Enemy".colorize(:red) + " you know what, sure, we dont want this kingdom anymore, its yours\n"
    sleep 4
    print "CONGRATULATIONS, YOU HAVE RECLAIMED YOUR KINGDOM THE PEACEFUL WAY, YOU WIN\n".colorize(:cyan)
    exit!
end

def select_attack(player_type)
    print "\nWhat attack would you like to use? "
    attack = gets.strip
    attack_index = attack.to_i - 1
    selecting_attack = true
    while (selecting_attack)
        if (attack == "make peace")
            easter_egg_dialogue()
        elsif (attack_index >= 0 && attack_index < player_type.attacks.length) #gonna have to change this to player.attacks.length
            return attack_index
        else
            print "Sorry, you have not selected an appropriate attack, please try again\n"
        end
        #at this point a proper attack has not been selected
        print "Please select an attack: "
        attack = gets.strip
        attack_index = attack.to_i - 1
    end
end

def player_attacks(player_type, attack_index)
    if (player_type.attacks[attack_index].damage_amount.is_a? Array)
        rand_i = rand(0..player_type.attacks[attack_index].damage_amount.length-1)  #create a random index
        damage = player_type.attacks[attack_index].damage_amount[rand_i]
    else
        damage = player_type.attacks[attack_index].damage_amount
    end
    player_type.attacks[attack_index].list_attack(damage)
    sleep 1
    return damage
end

def enemy_sustains_damage(enemies, enemy, damage)
    enemies[enemy].gets_hit(damage)
    enemies[enemy].show_health
end

def check_player_health(player_type)
    if (player_type.health <= 0)
        print "Player has died!\n".colorize(:red)
        exit!
    end
end

def enemy_attacks(player_type, enemies, enemy)
    sleep 2
    damage_amount = enemies[enemy].attack_player()
    player_type.gets_hit(damage_amount)
    sleep 2
    player_type.show_health
    sleep 2
end

def heal(player_type)
    print "Woosh, you have absorbed the enemies spirit and regained health!\n"
    sleep 1
    player_type.update_health(100)
    print "Players health is now #{player_type.health}\n"
end

def win_game?(enemies, enemy)
    if (enemy == enemies.length-1)
        print "YOU HAVE BEATEN ALL ENEMIES AND RECLAIMED THE KINGDOM, YOU WIN!\n".colorize(:cyan)
        exit!
    end
end

def continue?()
    print "You are entering a new battle!\n"
    print "Do you wish to continue? (Y/N): "
    answering = true
    answer = gets.strip
    while (answering)
        if (answer == "Y")
            return
        else
            if (answer == "N")
                print "It's okay, dont be scared\n".colorize(:magenta)
            else
                print "You were mumbling, i didnt hear your answer\n"
            end
            print "Do you wish to continue? (Y/N): "
            answer = gets.strip
        end
    end
end

def check_enemy_health(enemies, enemy, player_type)
    if enemies[enemy].health <= 0
        print "You are victorious in battle!\n".colorize
        win_game?(enemies, enemy)   #exits after this call if the player has defeated all the enemies
        heal(player_type)  #if the player hasnt one then he has reached the next stage where he wants to heal
        continue?()   #enemy has been defeated so the next battle is true and being returned
        return true
    end

end

#------------------------------------------------------------------------------


#------------------------------------------------------------------------------
#MAIN 

intro
player_type = class_select()
enemies = spawn_enemies()       #could make this a hash
enemy = 0

battling = true
while (battling)
    next_battle = false     #reset next battle to be false every time to ensure it works properly

    player_type.list_attacks    #show the attacks that the player can use
    #option = select_option     #show the player the items that you can use

    attack_i = select_attack(player_type)   #this should return the attack index (not the attack number)
    damage = player_attacks(player_type, attack_i)
    enemy_sustains_damage(enemies, enemy, damage)

    next_battle = check_enemy_health(enemies, enemy, player_type)   #gets updated to be true if check_enemy_health falls below 0
    
    print "-----------------------------\n"
    if (!next_battle)
        enemy_attacks(player_type, enemies, enemy)
        check_player_health(player_type)
    else
        enemy += 1
    end

    print "-----------------------------\n"
ends