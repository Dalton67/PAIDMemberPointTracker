# Welcome to the PAID Member Point Tracker!

https://tamu-paid-points.herokuapp.com

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
* To manually test for SQL injection vulnerabilities, enter similar commands below within submission forms on the application.
```
" or ""="
1; DROP TABLE members;
' UNION SELECT username, password FROM admin_users--
```
