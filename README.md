# KarateApiTest

API tests for DemoBlaze (Karate)

## Requirements

- Java 11+
- Maven 3.6+

## Run

Run all tests:
```bash
mvn clean test
```

Run specific feature:
```bash
mvn test -Dkarate.options="classpath:featurers/login.feature"
mvn test -Dkarate.options="classpath:featurers/signup.feature"
```

Reports: `target/karate-reports/karate-summary.html`

## Scenarios

**login.feature**
- Login with valid credentials (validates auth token)
- Login with wrong password

**signup.feature**
- Create new user
- Duplicate user validation

## Endpoints

`https://api.demoblaze.com`
- `POST /signup`
- `POST /login`