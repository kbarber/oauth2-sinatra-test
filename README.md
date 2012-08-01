This is a set of test sinatra apps for testing the functinality of the library
'rack-oauth2-server'.

I've specifically not include the gem for this, so you'll need to ensure the
library is in your Ruby path. This is because the existing version does have
bugs in relation to recent versions of OAuth2.

The best thing is to grab my version of the source code:

    git clone git://github.com/kbarber/rack-oauth2-server -b work_in_progress

Now you can start both applications by using their 'app.rb' files:

    cd consumer
    ./app.rb

And:

    cd provider
    ./app.rb

Then navigate to: http://localhost:9494/auth/test to begin the process.
