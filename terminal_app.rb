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
        if (@health <= 0)
            print "+++ Player's ".colorize(:cyan) + "health".colorize(:green) + " is 0\n"
        else
            print "+++ Player's ".colorize(:cyan) + "health".colorize(:green) + " is #{@health}\n"
        end
    end
    def list_attacks()
        print "It is your turn. Available attacks are: "
        @attacks.each_with_index do |attack, index|
            print "#{index+1}." + "#{attack.name} ".colorize(:yellow)
        end
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
        print ">>> Player uses " + "#{@name}".colorize(:yellow) + " and deals " + "#{dmg}".colorize(:red) + " damage\n"
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
end

class Mage < Character
    attr_accessor(:name, :attk_damage, :health, :attacks)
    def initialize(name, attk_damage)
        super(name, attk_damage)
        @attacks = [Attack.new("fireball", 20), shadow_volley = Attack.new("shadow volley", (15..25).to_a)]
        @items = [Potion.new("potion of weak healing", 30)]
    end    
end
#------------------------------------------------------------------------------------

#------------------------------------------------------------------------------------
#Enemy class
class Enemy
    attr_accessor(:name, :health)
    def initialize(name, health)
        @name = name
        @health = health
        # @item_drop = item
    end
    def update_health(health)
        @health += health
    end
    def gets_hit(damage)
        @health -= damage
    end
    def show_health()
        if @health < 0
            print "+++ #{@name}'s health is 0\n".colorize(:red)
        else
            print "+++ #{@name}'s ".colorize(:red) + "health".colorize(:green) + " is #{@health}\n"
        end
    end
end


class Skeleton < Enemy
    attr_accessor(:name, :health)
    def initialize(name, health)
        super(name, health)
        @attacks = [Attack.new("Slash", (15..22).to_a)]
        @first_encounter = true
    end
    def attack_player() #the skeletons attack
        rand_i = rand(0..@attacks[0].damage_amount.length-1)
        damage = @attacks[0].damage_amount[rand_i]
        print ">>> #{@attacks[0].name}! #{@name} deals " + "#{damage}".colorize(:red) + " damage\n"
        return damage
    end
    def meet_opponent()
        if (@first_encounter)
            print "A #{@name} has appeared, beware!\n"
            if (@name == "Draugr")
                #------------------------------------------------------------------------------
                File.open("ascii/draugr_image.txt", "r") do |f|
                    f.each_line do |line|
                        puts line
                    end
                end
                #------------------------------------------------------------------------------
            else
                #------------------------------------------------------------------------------
                File.open("ascii/skull_image.txt", "r") do |f|
                    f.each_line do |line|
                        puts line
                    end
                end
                #------------------------------------------------------------------------------
            end
            @first_encounter = false
        end
    end
end


class Dragon < Enemy
    attr_accessor(:name, :health)
    def initialize(name, health)
        super(name, health)
        @attacks = [Attack.new("Smash", (20..24).to_a), Attack.new("Firey breath", 30)]
        @turn = 0
        @first_encounter = true
    end
    def smash()
        rand_i = rand(0..@attacks[0].damage_amount.length-1)
        damage = @attacks[0].damage_amount[rand_i]
        print ">>> " + "#{@attacks[0].name}!".colorize(:yellow) + " #{@name} deals " + "#{damage}".colorize(:red) + " damage\n"
        print "   <fireball is charging up>\n"
        return damage
    end
    def breathe_fire()
        print ">>> " + "#{@attacks[1].name}".colorize(:yellow) + " is unleashed! #{@name} deals " + "#{@attacks[1].damage_amount}".colorize(:red) + " damage\n"
        return @attacks[1].damage_amount
    end
    def attack_player()
        @turn += 1
        if (@turn % 3 == 0)
            return breathe_fire()
        else
            return smash()
        end
    end
    def meet_opponent()
        if (@first_encounter)
            print "The final fight has arrived, can you beat the dragon and reclaim your kingdom?\n"
            #------------------------------------------------------------------------------
            File.open("ascii/dragon_fight.txt", "r") do |f|
                f.each_line do |line|
                    puts line
                end
            end
            #------------------------------------------------------------------------------
            @first_encounter = false
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
    print "\nHang tight, game is loading".colorize(:green)
    3.times do 
        print ".".colorize(:green)
        sleep 1
    end 
end

def storyprint(name)                
    story = "#{name.capitalize}, you are the last heir of the Coder Academy Kingdom, four months ago an ancient Dragon awoken from its slumber, and returned to where it once roamed, finding man made structures where he use to nap, the beast became enraged, with his ancient knowledge he calls forth an army of the undead and wreaks havoc upon the land, your ancestors land, the kingdom of coder academy. The enemy has recently taken over to destroy your kingdom, but you have decided to fight the beast for the people that survived and for honor."
    story.each_char do |c|
        if (c == ".")
            print c
            print "\n"
        else
            print c
            # sleep(1.0/20.0)
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
    storyprint(name)      #undo comment to get the story description at the start
end

def character_description()
    print "Please choose your path:\n\n"
    # sleep 2
    print "Mage\n".colorize(:cyan)
    print "-----\n"
    # -----------------------------------------------------------------------------
    ## ascii art ##
    File.open("ascii/mage_image.txt", "r") do |f|
        f.each_line do |line|
            puts line
         end
    end
    # -----------------------------------------------------------------------------
    print "The mage class uses magic to inflict damage on the enemy by casting spells. The mage's attacks are:\n"
    print "1. " + "Fireball".colorize(:yellow) + ": unleashes a firey blast on the enemy (attack damage: 20)\n"
    print "2. " + "Shadow volley".colorize(:yellow) + ": casts dark magic on the enemy (attack damage: 15 to 20)\n\n"
    # sleep 6
    print "Fighter\n".colorize(:cyan)
    print "--------\n"
    # -----------------------------------------------------------------------------
     ## ascii art ##
    File.open("ascii/fighter_image.txt", "r") do |f|
        f.each_line do |line|
            puts line
        end
    end
    # -----------------------------------------------------------------------------
    print "The fighter class uses sacred techniques passed down in his family for generations. The fighter's attacks are:\n"
    print "1. " + "Jab".colorize(:yellow) + ": jab the enemy in the face with your shortsword (attack damage: 20)\n"
    print "2. " + "Spiteful bug whirling fish".colorize(:yellow) + ": spinning attack that dazes you and inflicts minimal damage (attack damage: 15 to 20)\n"
    print "----------------------------------------------------------------------------------------------------------\n"
    # sleep 2
end

def confirm_class(character_class)
    print "Are you sure you want to be a #{character_class}? (" + "Y".colorize(:green) + "/" + "N".colorize(:red) + "): "
    answer = gets.strip.capitalize
    confirming = true

    while (confirming)
        if (answer == "Y")
            print "Success! You have chosen to be a #{character_class}!\n".colorize(:green)
            print "_________________________________________________________\n"
            return true
        elsif (answer == "N")
            return false
        end
        print "Sorry, you didnt enter the right input".colorize(:light_yellow)
        print "\n\n"
        print "Are you sure you want to be a #{character_class}? (" + "Y".colorize(:green) + "/" + "N".colorize(:red) + "): "
        answer = gets.strip.capitalize
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
            print "Sorry, that is not a proper class\n\n".colorize(:yellow)

        end
        print "Please select your class, you can choose to be a mage or a fighter: "
        class_name = gets.strip.capitalize()
    end
end

def spawn_enemies()
    return [Skeleton.new("Skeleton", 100), Skeleton.new("Draugr", 150), Dragon.new("Dragon", 200)]
end

def easter_egg_dialogue()
    print "You:".colorize(:cyan) + " do we need to keep fighting?\n"
    sleep 2
    print "Enemy:".colorize(:red) + " i don't know, it seems pointless\n"
    sleep 3
    print "You:".colorize(:cyan) + " i think so too, can i just have my kingdom back?\n"
    sleep 3
    print "Enemy".colorize(:red) + " you know what, sure, we dont want this kingdom anymore, its yours\n"
    sleep 4
# -----------------------------------------------------------------------------
### ascii art ###
    File.open("ascii/dragon_rider_image.txt", "r") do |f|
        f.each_line do |line|
            puts line
        end
    end
 # -----------------------------------------------------------------------------
    print "CONGRATULATIONS, YOU HAVE RECLAIMED YOUR KINGDOM THE PEACEFUL WAY, YOU WIN\n".colorize(:green)
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
            print "Sorry, you have not selected an appropriate attack, please try again\n".colorize(:yellow)
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
    player_type.update_health(200)
    print "Players health is now #{player_type.health}\n"
    print "------------------------------\n"
end

def win_game?(enemies, enemy)
    if (enemy == enemies.length-1)
        #--------------------------------------------------------------------
        ### ascii art ####
        File.open("ascii/dead_dragon.txt", "r") do |f|
            f.each_line do |line|
                puts line
            end
        end
        #--------------------------------------------------------------------
        print "YOU HAVE BEATEN ALL ENEMIES AND RECLAIMED THE KINGDOM, YOU WIN!\n".colorize(:cyan)
        exit!
    end
end

def continue?()
    print "You are entering a new battle!\n".colorize(:yellow)
    print "Do you wish to continue? (Y/N): "
    answering = true
    answer = gets.strip.capitalize
    while (answering)
        if (answer == "Y")
            return
        else
            if (answer == "N")
                print "It's okay, dont be scared\n\n".colorize(:yellow)
            else
                print "You were mumbling, i didnt hear your answer\n\n".colorize(:yellow)
            end
            print "Do you wish to continue? (Y/N): "
            answer = gets.strip.capitalize
        end
    end
end

def check_enemy_health(enemies, enemy, player_type)
    if enemies[enemy].health <= 0
        print "\nYou are victorious in battle!\n".colorize(:green)
        win_game?(enemies, enemy)   #exits after this call if the player has defeated all the enemies
        heal(player_type)  #if the player hasnt one then he has reached the next stage where he wants to heal
        continue?()   #enemy has been defeated so the next battle is true and being returned
        return true
    end

end

def print_line_break()
    30.times do 
        print "-"
        sleep (1.0/50.0)
    end
    print "\n"
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
    enemies[enemy].meet_opponent()
    player_type.list_attacks    #show the attacks that the player can use
    #option = select_option     #show the player the items that you can use

    attack_i = select_attack(player_type)   #this should return the attack index (not the attack number)
    damage = player_attacks(player_type, attack_i)
    enemy_sustains_damage(enemies, enemy, damage)

    next_battle = check_enemy_health(enemies, enemy, player_type)   #gets updated to be true if check_enemy_health falls below 0
    
    print "------------------------------\n"
    if (!next_battle)
        enemy_attacks(player_type, enemies, enemy)
        check_player_health(player_type)
    else
        enemy += 1
    end
    print "------------------------------\n"
end