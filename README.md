# FSG-Quiz App

`fsg-quiz` is an app developed by the munichmotorsport software engineering division for the purpose of being able to practice for the event registration quizzes. It was named after FSG because this was the registration quiz it was originally intended and hence first used for; for the same reason, its current specification (pre alpha sumthing) implements *most* of the features of the FSG quiz, namely:

* 30sec timeout after every submit
* shuffling questions and answers after every failed submit
* more than one person at a time can solve a quiz (or, to be more specific: all three team captains)
* it's also visually imitating the dimensions of the original quiz (60% of viewport in use, font sizes etc.)

`fsg-quiz` is a Ruby on Rails application. Our version uses a PostgreSQL database, since it's being deployed via heroku (it's reachable [here](http://fsg-quiz.herokuapp.com, "FSG-Quiz by munichmotorsport")), but you can at anytime use it with any other database that is supported by Active::Record. We're not using any database specific stuff right now and are not planning on it in the future; if that ever changes, it will be announced in this README.

## How to get it up and running

If you don't want to use [our version](http://fsg-quiz.herokuapp.com, "FSG-Quiz by munichmotorsport"), you can set up the app yourself whereever you want. It's a pretty standard Rails app, so you should be good with cloning the repository to the machine to want to run from, creating and migrating the database (with postgre, you will need to `createuser -dlrs --replication fsg-quiz` in a terminal first - see postgre documentation for explanation - and then run `rake db:create` and `rake
db:migrate` in the application directory) and then starting the app via `rails server` (again, in the application directory). This will start a WEBrick webserver that serves the app. If you want to run the app differently, please see the documentation of you webserver etc to find out how to deploy a Ruby on Rails app there. You can also find everything on how to deploy with production settings in the Rails documentation etc. 

## Technicalities

*a description of the classes (models, controllers, database attributes etc) will be here soonish*

## Current TODOs

* atm, a quiz can be taken by more than 3 users at the same time; this needs to be changed
* a bunch of other changes in respect to the user/quiz access have to happen as well (e.g. users should not be able to create new quiz sessions at all if they have an active one - this is currently possible by simply using the *Back* function of the browser)
* the user profile and access attributes need to be extended and the "team" attribute, that users currently have, needs to be used (preferably in such a way that there can only be one quizzing session per team)
* all views need to be checked for accessibility; atm, pretty much anyone can do anything if they know the link
* the possibilities of devise need to be exploited better; everything that's not automagically done by devise is pretty crude right now, that needs to change (and we want to grant omniauth access via facebook etc. as well)
* there's MUCH to do still in terms of making everything more beautiful and/or more like the original FSG quiz

### To Do Checklist

* 3 users max per quiztory: **IN PROGRESS**
* no users selection when no users present: **IN PROGRESS**
* list other users if session is in progress: **NEW**
* show when session has been started if in progress: **NEW**
* user can't create quiztory if already in progress, even if using the browser's back function: **NEW**
* team variable used: **NEW**
* quiztories only for members of same team: **NEW**
* tidy all views' accessibility: **NEW**
* delete button needs to be red: **NEW**
* *All Quizzes* view wants to be more beautiful: **NEW**
* only one new entry per click in new or edit view: **NEW**
* create *My Quiz Sessions* view for users: **NEW**
* create a nice statistics page for that view (*My Quiz Sessions*): **NEW**
* use other web server (nginx?): **NEW**                                                                      
