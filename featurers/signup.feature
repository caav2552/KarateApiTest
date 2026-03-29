Feature: Signup API

Background:
  * url 'https://api.demoblaze.com'
  * header Content-Type = 'application/json'

Scenario: Create new user successfully

  * def username = 'qa_user_' + new Date().getTime()
  * def rawPassword = '12345'
  * def encodedPassword = java.util.Base64.getEncoder().encodeToString(rawPassword.getBytes())

  * def user =
  """
  {
    "username": "#(username)",
    "password": "#(encodedPassword)"
  }
  """

  * print 'Creating user for signup test ->', user

  Given path '/signup'
  And request user
  When method POST
  Then status 200

  * print 'Signup response ->', response


Scenario: Fail when user already exists

  * def username = 'qa_user_' + new Date().getTime()
  * def rawPassword = '12345'
  * def encodedPassword = java.util.Base64.getEncoder().encodeToString(rawPassword.getBytes())

  * def user =
  """
  {
    "username": "#(username)",
    "password": "#(encodedPassword)"
  }
  """

  * print 'Preparing duplicate user scenario ->', user

  # Create User First Time
  Given path '/signup'
  And request user
  When method POST
  Then status 200

  * print 'First creation response ->', response

  # Verify User Already Exists
  Given path '/signup'
  And request user
  When method POST
  Then status 200

  * print 'Duplicate attempt response ->', response

  And match response.errorMessage == 'This user already exist.'