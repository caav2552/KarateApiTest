Feature: Login API

Background:
  * url 'https://api.demoblaze.com'
  * header Content-Type = 'application/json'
  * def helpers = call read('classpath:utils/helpers.js')

Scenario: Login with valid credentials

  * def user = helpers.generateUser('12345')
  * print 'signup payload ->', user

  # create user
  Given path '/signup'
  And request user
  When method POST
  Then status 200

  * print 'login with user ->', user.username

  # login
  Given path '/login'
  And request user
  When method POST
  Then status 200

  * print 'login response ->', response

  # optional but better validation
  And match response == '#notnull'


Scenario: Login with invalid password

  * def validUser = helpers.generateUser('12345')
  * def invalidUser = helpers.generateUser('wrong123')

  * set invalidUser.username = validUser.username

  * print 'signup payload ->', validUser

  # create user
  Given path '/signup'
  And request validUser
  When method POST
  Then status 200

  * print 'login with wrong password ->', invalidUser

  # login with wrong password
  Given path '/login'
  And request invalidUser
  When method POST
  Then status 200

  * print 'login response ->', response

  And match response.errorMessage == 'Wrong password.'