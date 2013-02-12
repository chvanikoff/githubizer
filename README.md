githubizer
==========
-
automatic deploy from github to server
-

ENGLISH

How to use:

`> ssh user@server.com`

`> cd path/for/app`

`> git clone git://github.com/chvanikoff/githubizer.git`

`> cd githubizer`

`> vi priv/application.config`

`> make`

`> make run`

What will happen: 

`• add deploy key for the server at Github`

`• add webhook at Github that will notify the server about push action`

`• clone repo with your project into specified path`

`• tiny web server that will listen for notifications from Github on specified port with specified URL will be started`

That's it
