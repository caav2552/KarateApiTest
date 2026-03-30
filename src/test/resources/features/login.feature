Feature: Login API

Background:
  * url baseUrl
  * header Content-Type = 'application/json'
  * def helpers = call read('classpath:utils/helpers.js')

@smoke @login
Scenario: Login with valid credentials

  * def user = helpers.generateUser('12345')

  Given path '/signup'
  And request user
  When method POST
  Then status 200

  Given path '/login'
  And request user
  When method POST
  Then status 200
  And match response == '#notnull'
  And match response == '#string'
  And def authToken = response
  And assert authToken.length > 10
  And match authToken contains 'Auth_token:'
  And assert responseTime < 3000

@login @negative
Scenario: Login fails with incorrect password

  * def validUser = helpers.generateUser('12345')
  * def invalidUser = helpers.generateUser('wrong123')
  * set invalidUser.username = validUser.username

  Given path '/signup'
  And request validUser
  When method POST
  Then status 200

  Given path '/login'
  And request invalidUser
  When method POST
  Then status 200
  And match response == { errorMessage: 'Wrong password.' }