# README

## Assumptions

- Only American Dollars
- Deal stage name always corresponds to the same deal stage percent
  - e.g. a deal in stage "Proposal" is always 50% percent complete
- All deals can be returned with single request
  - In testing, only 100 deals came in the response. If this were production, we would need to handle pagination, and if the numbers got big enough, most likely render the page and then render the chart async.

## Setup and installation

* Ruby version
2.4.1

* System dependencies

* Configuration
```
bundle install
```

* Database creation
```
rails db:create
```

* Database initialization
```
rails db:migrate
```

* How to run the test suite
```
rspec
```

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
