# Welcome to the PAID Member Point Tracker!

## Code Execution

* To run server locally start your server by running this command 
```
rails s
```
* Open localhost:3000 in a browser, and you should be able to view the webpate
## Deploy the code in Heroku

* Automatic deploy is configured using the master branch on Heroku. You may alter these configurations by adjusting the deploy settings on the Heroku account. 
* Any push to master will deploy a new build
* You may set up CD on the Heroku account very easily using pipleines.

## CI

Continuous Integration is set up on this github repo using Github Actions. All code is for these actions is checked in on the master branch. 

## Security Analysis/Tests
* This command will run the rspec tests for the admin functionalities. All other rspec tests are located in files under the ```spec``` directory.
```
rspec admin_spec
```