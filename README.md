# README

Lets make the world be better

## Ruby version
- 2.6.3

## Database creation
- `rake db:setup`

## How to run the test suite
### Unit test
- rspec
### Integration test
- cucumber

## Services
- api

## Deployment instructions
- `rm -rf .`

## When using Docker
- Build the image
  - `docker-compose build`
- Start-up
  - `docker-compose up`
- Migration
  - docker will do it for you
- When updating Gemfile
  - `docker-compose run api bundle install`
  - `docker-compose build`

## Generate serializer
- `rails g serializer <model>`

# Requests:
- All request with header: `Accept: application/json`

## Authentication
### New session
- `POST /users/sign_in`
- Request:
```
{
  user: {
    email: 'test@gmail.com',
    password: 'password'
  }
}
```
- Response: `Authorization` header will contain JWT token

### Delete session
- `DELETE /users/sign_out`
- Request: `Authorization` header contains JWT token. This JWT token will
  put in blacklist

### Create new user
- `POST /users`
- Request:
```
{
  user: {
    email: 'test@gmail.com',
    password: 'password'
  }
}
