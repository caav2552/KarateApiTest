Feature: Signup API

Background:
  * url 'https://api.demoblaze.com'
  * header Content-Type = 'application/json'
  * def helpers = call read('classpath:utils/helpers.js')

Scenario: Create a new user successfully

  * def user = helpers.generateUser('12345')
  * print 'signup payload ->', user

  Given path '/signup'
  And request user
  When method POST
  Then status 200

  * print 'signup response ->', response

Scenario: Validate error when user already exists

  * def user = helpers.generateUser('12345')
  * print 'signup payload ->', user

  # first creation
  Given path '/signup'
  And request user
  When method POST
  Then status 200

  # duplicate attempt
  Given path '/signup'
  And request user
  When method POST
  Then status 200

  * print 'duplicate signup response ->', response
  And match response.errorMessage == 'This user already exist.'