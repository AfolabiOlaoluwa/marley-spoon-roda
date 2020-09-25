# README

My solution is based on the response from the Headless API called Contentful. I have used the contentful_model SDK to render a solution. 
##### Framework...

My solution is based on RODA. You can read up on RODA on https://roda.jeremyevans.net/. I used RODA because it serves more request that Hanami, Sinatra, Grape, and because it is closer to Rack in performance. Its memory consumption is low compared to Hanami, Sinatra, Grape and it is lightweight.

##### Ruby Version 

* `ruby 2.7.1p83 (2020-03-31 revision a0c7c23c9c) [x86_64-darwin18]`

##### Rails Version 

* `Roda 3.36.0`

##### Configuration

I will advise you use `Chruby` to configure your environment handling. You can follow `https://medium.com/@hpux/using-chruby-as-the-default-ruby-version-manager-c11346e3cc` for that. When you are done, then you can proceed with the following steps:
1. Clone the repo.
2. Run `bundle install` from the root of the application.
2. Create `.env.rb` only by running the code below. This is used to setup your secret keys and environment variables:
    * `rake "setup[App]"`
3. Then, open your `.env.rb` file and paste the `SPACE_ID` and `ACCESS_TOKEN`
5. Start the application by running `rackup`

##### Running Test

Note: 

Provide SPACE_ID and ACCESS_TOKEN inside each `spec_helper.rb` before you run the test. 

To know the rake tasks available to you, you can run:
* `rake --tasks`

To run any of the test, you can pick any of the rake command available to you e.g.
* `rake model_spec`