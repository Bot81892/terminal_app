# Terminal_App "The Reclaimer"

This application is a game, were you can choose a class, and deal damage to monsters with an engaging story. It is run in the Bash command line written in ruby.

## Contributors

|<img src="https://avatars2.githubusercontent.com/u/48897382?s=460&v=4" alt="Jovan Nikolic" width="100"/> |<img src="https://avatars1.githubusercontent.com/u/45807277?s=460&v=4" alt="Melissa McAdam" width="100"/> |
|-----------|-----------|
|  <a href="https://github.com/Jovnik">Jovan Nikolic</a> | <a href="https://github.com/Bot81892">Melissa McAdam</a> |


### Link

https://github.com/Bot81892/terminal_app

### Purpose

Made for gamers that want a fun way to spend time and love a simplified old school style of game. The Reclaimer is made to emerge the user within it's world, through the story and fun art. The goal is for the player to overcome enemies and find intrigue with the story line, resulting in a fun overall experience.

### Functionality

 At the beginning, the user will be introduced into The Reclaimers world. The game will prompt the user to input a name and then choose a character class to play the game as.
 
 Based on user inputs, The Reclaimer will return a class selection, enter the arena and attack the enemy with the choice of two attacks, there is also the option to exit and if you look for it a easter egg.

### Instructions for use

Open a Terminal or preferred console.
To initialise program, enter:

Gem install
```terminal
'artii'
'colorize'
```

To initialise program, enter:

```terminal
$ ruby terminal_app.rb
```

Ready to go!

![title.png](screen_shots/title.png) 


## Design & Planing

Initially we did most of our brainstorming through slack, due to logistics. We quickly decided to build a game for our terminal application and went on to discuss different possibilities and limitations that we may encounter, as well as our time restraints.
Our main priority, was providing an engaging experience for the user.

![slack_chat.png](screen_shots/slack_chat.png) 



![interface.png](screen_shots/interface.png) 



![to_do.jpg](screen_shots/to_do.jpg) 


### Task Management

We used Trello to plan and keep track of different elements we had planed to use in our code. Trello allowed us to breakdown tasks to be performed and arrange new ideas as we built our minimum viable product.

![trello1.png](screen_shots/trello1.png) 
![trello2.png](screen_shots/trello2.png) 
![trello3.png](screen_shots/trello3.png) 

### User Journey/Workflow
![userinteraction.jpg](screen_shots/userinteraction.jpg) 

### Project Plan & Timeline
For The Reclaimer's initial build, we had two days to code the minimum viable product and another two days make changes before submission. Our first step was to decide on what ideas we want to use and which were possible within the MVP.

Day 1: 

As we had already discussed and brain stormed some ideas, we could dive straight into designing and building our MVP. On the first day we were focused on creating a solid plan for what we knew we could achieve and what we eventually wanted to have in the final version. As we started to code, we soon completed the player and character classes, mage and fighter with two attacks each, a enemy class and one enemy object with its own attack. By the end of the day we had a loop for the battles, two enemies and all characters with their own name, attacks, attack damage and health value.

Day 2: 

On the second day we completed multiple methods and a MVP, soon we were thinking of new ideas for user interactions and a visual display to break apart the main body of text that was our game. With the MVP complete we started adding some of our other ideas, a third enemy, possibly using a heal function and a hidden easter egg. We also implemented a sleep count, a character each loop and gems, artii as well as colorize, to make the code easier to read.

Day3 & day 4:

The last two days before submission, involved finalizing and testing the code, finding little issues for example the wrong name being displayed or little additions and changes to the narrative, for users to enjoy.

## Coding Process
After defining the main character and enemy types, our focus was on getting a working battle simulation. As we had discussed, we planed to have the players choose between two attacks with different attack values as they fought an enemy.

This lead to a lot of writing and rewriting code as we started to build upon our ideas, adding features to see the damage being dealt and received, concepts for replenishing health and a story/interface for the users.

For our MVP, the goal was a playable game that was easy for the user to use and gave use a foundation to build on.

With time permitting, we were able to add random values to the attack damages for all classes, a engaging story line and ascii art, for fun and to break apart the code.

Throughout the process of making this application, we tested the application, to ensure users could type lower case and it would be capitalized, couldn't input a integer when asking for a string and could loop back to the main menu if he decided to change classes.

After testing throughout the program, our final step was to clean up the user interface and helpful comments to describe parts of the code. 


## Challenges

Scaling back our ideas for the minimum viable product.

Having a battle loop taking multiple inputs.

No functionality to self heal.

Finding a way to add ascill art and display it.

Building a delay into the display.

## User Stories

"I'm a student who games regularly and I found the app quite entertaining despite its current simplicity. I was able to have fun with this quick game/challenge
with assistance from the game's story delivery." — random_user

"I've been playing games since I was a young lad and am glade to see a game with some originality again, the story though a bit strange was quite enjoyable and only having to press a couple of buttons avoid inflaming me arthritis" — random_old_guy

"I'm a big fan of dragons, as a child use to think I was one... ANYWAY, this game was sick, ancient dragon coming back after a long slumber to tear sh*t up, so cool and the easter egg was wicked, so wish I was the heir in the game, I recommend this for everyone" — dragon_lover 
