#------------------------------------------------------------------------------------------------------------------------------
# Code for testing parts of the program

# Test Template//
# | test num | test method name | inputs | expected result | actual result |

# Test Results //
# | test 01 | test_user_options | n = 4 | "Option out of range detected - test PASS" | "Option out of range detected - test PASS|
# | test 02 | test_enemy_health | health = -10 | "Enemy has died - test PASS" | "Enemy has died - test PASS" |
# | test 03 | test_health_decrease | health = 50, new_health = 30 | "Damage sustained - test PASS" | "Damage sustained - test PASS" |

# # BAD DATA
# <test check_options>
# test_user_options(n)
#     if (n <= 0) || (n>=3)
#         print "Option out of range detected - test PASS\n"
#     else 
#         print "test FAIL\n"
#     end
# end

# #GOOD DATA
# <test for fallen enemy>
# test_enemy_health(health)
#     if (health <= 0)
#         print "Enemy has died - test PASS\n"
#     else
#         print "test FAIL\n"
#     end
# end

# <test for hit sustained>
# test_health_decrease(health, new_health)
#     if (new_health < health)
#         print "Damage sustained - test PASS\n"
#     else
#         print "test FAIL\n"
#     end
# end
#------------------------------------------------------------------------------------------------------------------------------

require 'colorize'
require 'artii'

#------------------------------------------------------------------------------------------------------------------------------
#CLASSES 

#Attacks
class Attack
    attr_accessor(:name, :damage_amount)
    def initialize(name, damage_amount)
        @name = name
        @damage_amount = damage_amount
    end
    def list_attack(dmg)
        print ">>>".colorize(:cyan) + " Player uses" + " #{@name}".colorize(:yellow) + " and deals " + "#{dmg}".colorize(:red) + " damage\n"
    end
end

class Character 
    attr_accessor(:name, :health)
    def initialize(name)
        @name = name
        @health = 100
    end
    def update_health(health)
        @health += health
    end
    def gets_hit(damage)
        @health -= damage
    end
    def show_health()
        if (@health <= 0)
            print "+++".colorize(:cyan) + " Player's " + "health".colorize(:green) + " is 0\n"
        else
            print "+++".colorize(:cyan) + " Player's " + "health".colorize(:green) + " is #{@health}\n"
        end
    end
    def list_attacks()
        print "It is your turn. Available attacks are: "
        @attacks.each_with_index do |attack, index|
            print "#{index+1}." + "#{attack.name} ".colorize(:yellow)
        end
    end
end

class Fighter < Character
    attr_accessor(:name, :health, :attacks)
    def initialize(name)
        super(name)
        @attacks = [Attack.new("jab", 20), Attack.new("spiteful bug whirling fish", (15..25).to_a)]
    end
end

class Mage < Character
    attr_accessor(:name, :health, :attacks)
    def initialize(name)
        super(name)
        @attacks = [Attack.new("fireball", 20), shadow_volley = Attack.new("shadow volley", (15..25).to_a)]
    end    
end

class Enemy
    attr_accessor(:name, :health)
    def initialize(name, health)
        @name = name
        @health = health
        # @item_drop = item
    end
    def gets_hit(damage)
        @health -= damage
    end
    def show_health()
        if @health < 0
            print "+++".colorize(:red) + " #{@name}'s health is 0\n".colorize(:red)
        else
            print "+++".colorize(:red) + " #{@name}'s " + "health".colorize(:green) + " is #{@health}\n"
        end
    end
end


class Skeleton < Enemy
    attr_accessor(:name, :health)
    def initialize(name, health)
        super(name, health)
        @attacks = [Attack.new("Slash".colorize(:yellow), (15..22).to_a)]
        @first_encounter = true
    end
    def attack_player()     #the skeletons attack
        rand_i = rand(0..@attacks[0].damage_amount.length-1)    #randomizer to get a random damage
        damage = @attacks[0].damage_amount[rand_i]
        print ">>> ".colorize(:red) + "#{@attacks[0].name}! #{@name} deals " + "#{damage}".colorize(:red) + " damage\n"
        return damage
    end
    def story()
        print "The player spots the merciless dragon perched atop his families castle.\n"
        sleep 3
        print "Wanting to take their kingdom back, the player approaches quietly, entering through the castle doors\n"
        sleep 3
        print "As the player creeps through the long winding corridors, a " + "skeleton".colorize(:red) + " appears! Beware!\n\n"
        sleep 3
        print "\t\t\t< You have now entered a battle >\n".colorize(:yellow)
        sleep 3
    end
    def meet_opponent()
        if (@first_encounter)
            story()
            File.open("ascii/skull_image.txt", "r") do |f|
                f.each_line do |line|
                    puts line
                end
            end
            @first_encounter = false

        end
    end
end

class Draugr < Enemy
    attr_accessor(:name, :health)
    def initialize(name, health)
        super(name, health)
        @attacks = [Attack.new("Hack", (18..25).to_a)]
        @first_encounter = true
    end
    def attack_player() 
        rand_i = rand(0..@attacks[0].damage_amount.length-1)
        damage = @attacks[0].damage_amount[rand_i]
        print ">>> #{@attacks[0].name}! #{@name} deals " + "#{damage}".colorize(:red) + " damage\n"
        return damage
    end
    def story()
        print "The player reaches a spiralling staircase and heads to the top"
        sleep 3
        3.times do
            print "."
            sleep 1
        end
        print "\nJust as the player is about to enter outside they hear the scrape of metal behind them. The player turns around\n"
        sleep 4
        print "A" + " Draugr".colorize(:red) + " (powerful skeleton) has found you! Prepare for battle!\n\n"
        sleep 4
        print "\t\t\t< You have now entered a battle >\n".colorize(:yellow)
        sleep 3
    end
    def meet_opponent()
        if (@first_encounter)
            story()
            File.open("ascii/draugr_image.txt", "r") do |f|
                f.each_line do |line|
                    puts line
                end
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
    def smash() #dragons smash attack
        rand_i = rand(0..@attacks[0].damage_amount.length-1)
        damage = @attacks[0].damage_amount[rand_i]
        print ">>> ".colorize(:red) + "#{@attacks[0].name}!".colorize(:yellow) + " #{@name} deals " + "#{damage}".colorize(:red) + " damage\n"
        print "   <dragon is charging up his firey breath>\n"
        return damage
    end
    def breathe_fire()  #dragons breathe fire attack
        print ">>> ".colorize(:red) + "#{@attacks[1].name}".colorize(:yellow) + " is unleashed! #{@name} deals " + "#{@attacks[1].damage_amount}".colorize(:red) + " damage\n"
        return @attacks[1].damage_amount
    end
    def attack_player() #combination of the attacks that alternate every 3 turns
        @turn += 1
        if (@turn % 3 == 0)
            return breathe_fire()
        else
            return smash()
        end
    end
    def story()
        print "The player has defeated the Draugr and continues forth to outside the top of the castle"
        sleep 3
        3.times do
            print "."
            sleep 1
        end
        print "\nThe enemy has been sighted - the" + " dragon".colorize(:red) + " lays down sleeping. The player approaches hoping for a suprise attack\n"
        sleep 4
        print "Oh no! The dragon has heard your footsteps with his sensitive hearing and lunged towards you!\n\n"
        sleep 4
        print "\t\t\t\t< Final Battle >\n".colorize(:yellow)
        sleep 2
    end
    def meet_opponent()
        if (@first_encounter)
            story()
            File.open("ascii/dragon_fight.txt", "r") do |f|
                f.each_line do |line|
                    puts line
                end
            end
            @first_encounter = false
        end
    end
end

#------------------------------------------------------------------------------
#METHODS used in the program

def print_art(name)     #prints the available ascii art depending on the name called
    if (name == "mage")
        File.open("ascii/mage_image.txt", "r") do |f|
            f.each_line do |line|
                puts line
             end
        end
    elsif (name == "fighter")
        File.open("ascii/fighter_image.txt", "r") do |f|
            f.each_line do |line|
                puts line
            end
        end
    elsif (name == "dragon rider")
        File.open("ascii/dragon_rider_image.txt", "r") do |f|
            f.each_line do |line|
                puts line
            end
        end
    elsif (name == "dead dragon")
        File.open("ascii/dead_dragon.txt", "r") do |f|
            f.each_line do |line|
                puts line
            end
        end
    end
end
 
def load_game()     #load game display
    print "\n\t\t\t\t\t\tHang tight, game is loading".colorize(:green)
    3.times do 
        print ".".colorize(:green)
        sleep 1
    end 
end

def storyprint(name)    #display the games background story        
    story = """
    #{name.capitalize}, you are the last heir of the Coder Academy Kingdom. Four months ago an ancient Dragon awoke from its 
    slumber, and returned to where it once roamed. Finding man made structures where he used to lie, the beast became enraged 
    and called forth an army of the undead using his ancient knowledge, wreaking havoc upon the land. This very land was the 
    land of your ancestors - the kingdom of Coder Academy. The enemy wishes to turn your kingdom to rubble, but you have 
    decided to fight, for the people that survived and for your honor.
    """
    story.each_char do |c|
        print c
        sleep(1.0/30.0)
    end
    print "\n"
    sleep(4)
end

def intro()     #game intro containing title, load game and the story
    title = Artii::Base.new
    print title.asciify("Welcome to The Reclaimer").colorize(:yellow)
    load_game
    print "\nWhat is your name? ".colorize(:yellow)
    name = gets.strip
    storyprint(name)
end

def character_description()     #describe the two different classes available
    print "Please choose your path:\n\n".colorize(:yellow)
    sleep 2
    print "Mage\n".colorize(:cyan)
    print "-----\n"
    print_art("mage")   #ascii art for mage
    print "The mage class uses magic to inflict damage on the enemy by casting spells. The mage's attacks are:\n"
    print "1. " + "Fireball".colorize(:yellow) + ": unleashes a firey blast on the enemy " + "(attack damage: 20)\n".colorize(:red)
    print "2. " + "Shadow volley".colorize(:yellow) + ": casts dark magic on the enemy with varying strength" + "(attack damage: 15 to 25)\n\n".colorize(:red)

    print "Fighter\n".colorize(:cyan)
    print "--------\n"
    print_art("fighter") #ascii art for fighter
 
    print "The fighter class uses sacred techniques passed down in his family for generations. The fighter's attacks are:\n"
    print "1. " + "Jab".colorize(:yellow) + ": jab the enemy in the face with your shortsword " + "(attack damage: 20)\n".colorize(:red)
    print "2. " + "Spiteful bug whirling fish".colorize(:yellow) + ": spinning attack that dazes you and inflicts random damage" + " (attack damage: 15 to 25)\n".colorize(:red)
    print "----------------------------------------------------------------------------------------------------------\n"
    sleep 2
end

def confirm_class(character_class)      
    print "Are you sure you want to be a #{character_class}? (" + "Y".colorize(:green) + "/" + "N".colorize(:red) + "): "
    answer = gets.strip.capitalize
    confirming = true

    while (confirming)  #loop waits for a confirmation on the class, before returning back to the main
        if (answer == "Y")
            print "Success! You have chosen to be a #{character_class}!\n\n".colorize(:green)
            sleep 2
            print "______________________________________________________________________\n"
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

def class_select()      #allow the player to choose between the two classes provided
    character_description()
    print "It is time to make a decision. Which class would you like to select: "
    class_name = gets.strip().capitalize        #get the class name from the user
    selecting_class = true
    while (selecting_class)
        if (class_name == "Fighter")
            if (confirm_class("Fighter"))
                return Fighter.new("Fighter")
            else
                #do nothing, going to reprompt user to select a class
            end
        elsif (class_name == "Mage")
            if (confirm_class("Mage"))
                return Mage.new("Mage")
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

def spawn_enemies()     #create the enemies that the use is going to battle
    return [Skeleton.new("Skeleton", 100), Draugr.new("Draugr", 150), Dragon.new("Dragon", 200)]
end

def easter_egg_dialogue()
    print "\n\nYou:".colorize(:cyan) + " do we need to keep fighting?\n"
    sleep 2
    print "Enemy:".colorize(:red) + " i don't know, it seems pointless\n"
    sleep 3
    print "You:".colorize(:cyan) + " i think so too, can i just have my kingdom back?\n"
    sleep 3
    print "Enemy".colorize(:red) + " you know what, sure, we dont want this kingdom anymore, its yours\n"
    sleep 4
    print_art("dragon rider")   #ascii art for the dragon rider
    print "CONGRATULATIONS, YOU HAVE RECLAIMED YOUR KINGDOM THE PEACEFUL WAY, YOU WIN\n".colorize(:green)
    exit!
end

def select_attack(player_type)      #allow the player to select the attack
    print "\nWhat attack would you like to use? "
    attack = gets.strip             #get the attack input number and convert it to the attack index so that they align
    attack_index = attack.to_i - 1
    selecting_attack = true
    while (selecting_attack)
        if (attack == "make peace") #hidden easter egg dialogue unlocked
            easter_egg_dialogue()
        elsif (attack_index >= 0 && attack_index < player_type.attacks.length)
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

def player_attacks(player_type, attack_index)   #user attacks the enemy
    if (player_type.attacks[attack_index].damage_amount.is_a? Array)    #if the user selects the attack that has a range
                                                                        # a random index will be created to obtain a rand attack
        rand_i = rand(0..player_type.attacks[attack_index].damage_amount.length-1) 
        damage = player_type.attacks[attack_index].damage_amount[rand_i]
    else
        damage = player_type.attacks[attack_index].damage_amount
    end
    player_type.attacks[attack_index].list_attack(damage)
    sleep 1
    return damage
end

def enemy_sustains_damage(enemies, enemy, damage)   #take the users damage amount away from the enemies health
    enemies[enemy].gets_hit(damage)
    enemies[enemy].show_health
end

def check_player_health(player_type)        #check if the player loses
    if (player_type.health <= 0)
        print "Player has died!\n".colorize(:red)
        exit!
    end
end

def enemy_attacks(player_type, enemies, enemy)      #enemies turn to attacks, take player health away according to enemies damage
    sleep 2
    damage_amount = enemies[enemy].attack_player()
    player_type.gets_hit(damage_amount)
    sleep 2
    player_type.show_health
    sleep 2
end

def heal(player_type)       #players health increases after defeating the enemy
    print "WOOSH! You have absorbed the enemies spirit and gained 200 health!\n"
    sleep 1
    player_type.update_health(200)
    print "Players health is now #{player_type.health}\n"
    print "------------------------------\n"
    sleep 2
end

def win_game?(enemies, enemy)   #check if all the enemies have been defeated and thus if you have won the game
    if (enemy == enemies.length-1)
        print_art ("dead dragon")   #ascii art dead dragon
        print "YOU HAVE BEATEN THE DRAGON AND RECLAIMED THE KINGDOM, YOU WIN!\n".colorize(:cyan)
        exit!
    end
end

def continue?()     #prompt the user for continuation in the game after a victory
    print "Do you wish to continue? (" + "Y".colorize(:green) + "/" + "N".colorize(:red) + "): "
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
            print "Do you wish to continue? (" + "Y".colorize(:green) + "/" + "N".colorize(:red) + "): "
            answer = gets.strip.capitalize
        end
    end
end

def check_enemy_health(enemies, enemy, player_type)     #combination of previous functions into the one common method
    if enemies[enemy].health <= 0
        print "\nYou are victorious in battle!\n".colorize(:green)
        win_game?(enemies, enemy)   #exits after this call if the player has defeated all the enemies
        heal(player_type)  #if the player hasnt one then he has reached the next stage where he wants to heal
        continue?()   #enemy has been defeated so the next battle is true and being returned
        return true
    end

end
#----------------------------------------------------------------------------------------------------------------------------


#----------------------------------------------------------------------------------------------------------------------------
#MAIN 

intro                                   #intro is given to the player, allowing them to select a class, enemies are spawned in
player_type = class_select()
enemies = spawn_enemies()
enemy = 0
battling = true                         #battling set to true while the game runs to allow the loop to constantly run
                                        #the use of 'exit!' allows the game to exit the program when required, so the loop
                                        #is allowed to run infinitely until that point is reached
while (battling)
    next_battle = false                 #reset next battle to be false at start of loop every time to ensure next enemy isnt prematurely fought
    enemies[enemy].meet_opponent()      #dialogue displayed before the enemy is fought to give more story to the user
    player_type.list_attacks            #show the attacks that the player can use each turn

    attack_i = select_attack(player_type)           #get the users attack input selection and accordingly take health away from enemy
    damage = player_attacks(player_type, attack_i)
    enemy_sustains_damage(enemies, enemy, damage)

    next_battle = check_enemy_health(enemies, enemy, player_type)   #gets updated to be true if check_enemy_health falls below 0
                                                                    #and thus the enemy has died
    
    print "------------------------------\n"
    if (!next_battle)                                   #if next_battle isnt true, the battle is still ongoing so the enemy attacks
        enemy_attacks(player_type, enemies, enemy)
        check_player_health(player_type)
    else
        enemy += 1                                      #if next battle is false, enemy has already died so we move to the next enemy
    end
    print "------------------------------\n"
end