# test-client

* Ruby: 3.4.2
* Rails: 8.0.1

Ruby on Rails app as a GraphQL API client.

### Run locally

This app uses "lightspark" Ruby gem. See https://github.com/kangkyu/lightspark-ruby

```
LIGHTSPARK_API_TOKEN_CLIENT_ID='012345abc...' \
LIGHTSPARK_API_TOKEN_CLIENT_SECRET='FGApzlyQnZ...' \
rails s
```

To get the auth token for request, in rails console (Run `rails c`)

```rb
User.create(email: "example@example.com") # Need a user in the database to get its auth token

u = User.last
u.auth_token
# => "Cgfi27gkYBoDKxrYWigZvDJ5"
```

And then fetch info from the "current_account" endpoint (More to come).

```
curl localhost:3000 -H "Authorization: Token Cgfi27gkYBoDKxrYWigZvDJ5"
```
