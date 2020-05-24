# Bookings API

Bookings api is a first class client api not intended as a public interface.
This api allows a client to create an account and create or associate it with customer identities, vehicles and bookings.

This api allows its client to capture all of the above information in a single step, using RESTful resources compliant with open json standards.

## Local Setup

* Ruby version 2.7.1

* PostgresDB

```sh
bundle install
``

```sh
bundle exec rails db:create db:migrate
```

## Testing

```sh
bundle exec rspec spec/
```

## API documentation

See doc/api.paw.sh for working examples of interacting with the api.
```sh
  /accounts
    /accounts/search
    /account/:account_id/vehicles
    /account/:account_id/vehicles/:id
    /account/:account_id/bookings
    /account/:account_id/bookings/:id
    /account/:account_id/identities
    /account/:account_id/identities/:id
  /vehicles
    /vehicles/:id
  /bookings
    /bookings/:id
  /identities
    /identities/:id
```
