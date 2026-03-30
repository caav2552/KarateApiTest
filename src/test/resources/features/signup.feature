Feature: Signup API

Background:
  * url baseUrl
  * header Content-Type = 'application/json'
  * def helpers = call read('classpath:utils/helpers.js')

@smoke @signup
Scenario: Create new user successfully

  * def user = helpers.generateUser('12345')

  Given path '/signup'
  And request user
  When method POST
  Then status 200

@signup @negative
Scenario: Validate duplicate user registration

  * def user = helpers.generateUser('12345')

  Given path '/signup'
  And request user
  When method POST
  Then status 200

  Given path '/signup'
  And request user
  When method POST
  Then status 200
  And match response == { errorMessage: 'This user already exist.' }