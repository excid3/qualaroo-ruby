# Qualaroo

A ruby library to connect to Qualaroo's API. For more information on
their API, check out the documentation here: http://help.qualaroo.com/hc/en-us/sections/200469946-API-Documentation

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'qualaroo'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install qualaroo

## Usage

First, you'll need your API key which you can find here: https://app.qualaroo.com/account

### Set up your API keys

You can create an instance of the API client:

    qualaroo = Qualaroo::Client.new("your_api_key", "your_api_secret")

Alternatively, you can set this globally and use this in an initializer
in Rails like `config/initializers/qualaroo.rb`:

    Qualaroo::Client.api_key    = "your_api_key"
    Qualaroo::Client.api_secret = "your_api_secret"

You can also set the environment variables `QUALAROO_API_KEY` and
`QUALAROO_API_SECRET` in your `application.yml` and Qualaroo will
automatically detect this. That means, you can set up API access by just
specifying:

    qualaroo = Qualaroo::Client.new

### Responses

Once you've set your API keys, you can access responses to nudges:

    qualaroo = Qualaroo::Client.new
    qualaroo.responses("your_nudge_id")

    # or if you set the keys globally

    Qualaroo::Client.responses("your_nudge_id")

This returns the first 500 responses as a Ruby hash.

Their API also accepts various options:

    # Date Ranges
    You can request records for a particular date range. To do this, add start_date and/or end_date parameters to the URL. The value of these parameters must be a integer representing "UNIX time" in seconds. For example, the date/time "2013-07-15 17:47:24 -0700" must be represented as 1373935644.

    # Pagination
    offset -- a non-negative integer. For example, offset=1000 means that the API will return records that match your query starting with response number 1001. If offset is not provided, the API will start from the beginning, response number 1.
    limit -- the number of records you want to get in one response. The number must be between 0 and 500. If limit is not provided, the API will retrieve up to 500 responses.

You must pass in an integer version of a time to `start_date` or
`end_date` for it to be handled properly:

    qualaroo = Qualaroo::Client.new
    qualaroo.responses("your_nudge_id", {
      start_date: Time.zone.yesterday.to_i,
      end_date: Time.zone.now.to_i,
      offset: 500,
      limit: 30
    })

    # or if you set the keys globally

    Qualaroo::Client.responses("your_nudge_id", {
      start_date: Time.zone.yesterday.to_i,
      end_date: Time.zone.now.to_i,
      offset: 500,
      limit: 30
    })

### All Responses For A Nudge

If you want to access all the responses from a Nudge without dealing
with pagination, you can use the `all_responses` method to do this. It
will make a series of API requests and collect the results and return
them to you all together.

    qualaroo = Qualaroo::Client.new
    qualaroo.all_responses("your_nudge_id)

    # or if you set the keys globally

    Qualaroo::Client.all_responses("your_nudge_id")

You can also pass the `start_date` and `end_date` options into this
method to get all responses over a given time period.

## Contributing

1. Fork it ( https://github.com/[my-github-username]/qualaroo/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
