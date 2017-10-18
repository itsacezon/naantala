# naantala

[![Build Status](https://travis-ci.org/itsacezon/naantala.svg?branch=master)](https://travis-ci.org/itsacezon/naantala) [![Coverage Status](https://coveralls.io/repos/github/itsacezon/naantala/badge.svg?branch=master)](https://coveralls.io/github/itsacezon/naantala?branch=master)

Delivers SMS notifications whenever MRT Line 3 experiences technical problems.
This service works by pinging https://dotcmrt3.gov.ph/service-status for the most recent status. As a result, it's not real-time since it relies on the webpage being updated regularly.

Note that only issues with CAT3 & CAT4 statuses will be captured.
- **Category 1** - Fault Normalized / No effect on operation
- **Category 2** - Train is removed with replacement
- **Category 3** - Train is removed without replacement / Cancellation of loops and insertion
- **Category 4** - Service interruption / Cancellation of loops

## Requirements
- Ruby `2.4.2`
- MongoDB `3.4.9`

## Running the Sinatra app
1. Make sure to create `development` and `test` MongoDB databases (check `config/mongodb.yml` for databases, or name your own)
2. Install dependencies by running `bundle install`.
3. Run the app via `thin start`.

## Running the test
1. Just run `bundle exec rspec`.

## Running the service
The SMS notifier (located inside `app/service`) should be run via a scheduler (Heroku Scheduler, etc.)
1. Set up your [Semaphore](https://semaphore.co) account to configure the environment variables (save them on an `.env` file).
2. Add `./bin/check-line-status` to your scheduler and set it to run every 10-15 minutes (recommended).
