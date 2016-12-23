# Congress Tracker

[Link to Github](https://github.com/luke-schleicher/congress-tracker.git)
[Link to Deployed App](https://ancient-everglades-28054.herokuapp.com/)

Completed by [Kenny Kottenstette](https://github.com/kotten1), [Luke Schleicher](https://github.com/luke-schleicher), [James Harris](https://github.com/DawnPaladin) and [Dexter Ford](https://github.com/dexterford77)

Find out who your representatives are and how they're voting

## Guided Tour

The Congress Tracker app helps you stay up-to-date on what your legislators in Washington are doing.

At the home page, you have the option to type in your address to locate your representatives. It accepts a variety of inputs including full address, zip, city, etc. Once you've entered your address and pressed "Search", the app will identify your senators and representative and display them on a legislators page. On the right you may enter your email to receive weekly updates on your legislators and their recent votes.

Clicking on a legislator brings you to an informational page which displays their basic information including contact details. It also displays a list of recent bills they've sponsored, bills they've recently voted on, and the main financial contributors to their campaign.

Clicking on a bill takes you to that bill's page. The bill displays the identifer, title, how members of Congress voted on the issue, and how your representatives voted.

## Technical Highlights

The Congress Tracker app relies on a wealth of data collected by various nonprofit groups including [Sunlight Labs](https://sunlightlabs.github.io/congress/), [VoteSmart](http://votesmart.org/), and [Open Secrets](https://www.opensecrets.org/api/admin/index.php). Using these sources, we seeded our database with data on all current members of Congress as well as bill and vote data going back a year.

Identifying a user's legislators relies on a straightforward Google Maps API to locate their location, as well as an API call to Sunlight Labs to determine legislator by location.

The core of the app centers around the legislator controller which allows us to display all legislators given a location as well as info for a particular legislator.

We made a technical decision to change the primary key on the legislators and bills tables, since most APIs identify them through what is called a "bioguide id" and a "bill id", respectively. This required a few modifications to Rails' conventions to make this work, including migrations, declaring the primary key in the model, and modifying the routes to pass in the new primary key ids as params to update the url.

Finally, the email updates are sent out through the Heroku add-on SendGrid. All emails are queued up as delayed jobs using the 'delayed job active record' gem. This keeps the main server free to accept requests, while a worker dyno fires up to send emails.

## How To Run The App

1. Clone the repo into a directory
2. [Download and run Postgresql](https://www.postgresql.org/download/)
3. Run "rake db:create"
4. Run "rake db:migrate"
5. Run "bundle install"
5. You'll need to pick up a few API keys...
  - [Google Maps API Key](https://developers.google.com/maps/documentation/geocoding/intro)
  - [VoteSmart API Key](http://votesmart.org/share/api#.WF1d47YrIRU)
  - [OpenSecrets API Key](https://www.opensecrets.org/api/admin/index.php?function=signup)
6. ...And after running "bundle exec figaro install"...
7. ...Add your API keys to the application.yml file in the config directory
8. Run "rake db:seed"
9. Fire up the server with "rails -s"
10. Navigate to 'localhost:3000'
