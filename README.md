[![Build Status](https://travis-ci.org/albab/sf-food-truck-finder.svg?branch=master)](https://travis-ci.org/albab/sf-food-truck-finder)
# SF Food Trucks
This app was built for Uber’s [coding challenge](https://github.com/uber/coding-challenge-tools). The app features a map of San Francisco’s Food Trucks, using data from [DataSF:Food Trucks](https://data.sfgov.org/Permitting/Mobile-Food-Facility-Permit/rqzj-sfat). 

## Demo
There's a live version at http://sf-food-truck-findr.herokuapp.com/

## Software
* Ruby on Rails
* PostgreSQL
* Haml
* Sass
* jQuery
* RSpec 

## Usage
Users can pick a category from a list of food types and find food trucks in the SF area with that category to display on the map. Clicking a marker on the map will open up an info window with details on that food truck. Users can autogeolocate by clicking pin icon in top right corner. 

## Assumptions
I'm assuming the end user is using a modern web browser, preferably Chrome. The user presumably lives in San Francisco.

## Decisions
I initially wrote out the action of finding trucks by categories the "Rails way" through formal ajax responses on the link_to's, but for whatever reason it wouldn't interpolate/render the array of nearest locations in the js.erb file when deployed to Heroku. I ended up going with a straight up $.ajax call to the route to grab the JSON and then built the map around that instead to get it working. 

I decided to seed the database by fetching the locations from DataSF which could just be done by hitting the '/populate_trucks' route. This made it easy to debug quickly and allowed me to be able to filter out a lot of unnecesssary data without having to fetch and filter on every category request. If I were to put this on a production environment I'd write a rake task to update the trucks by doing this on a daily basis instead.

## Improvements
* For someone reason you have to click twice to get the map to refresh on the right category even though the JSON request was successful and the map content is re-rendered. When I'm not totally dying from my kidney stones I'll figure it out 😱
* There could definitely be more error checking
* Could refactor the JS on index a bit
* Could make categories dynamic (w/ admin page or something)
* Could render the list of location names in place of categories on click (having to double click makes this a predicament at the moment)
* Spinner on Autogeolocate would be nice

