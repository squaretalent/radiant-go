# radiant-go

radiant-go is a script that creates radiant projects and automates setup tasks including:

* generating a project
* bootstrapping
* updating
* migrating
* installing required gems
* altering the config to require extensions
* updating extensions
* migrating extensions

## using the generator

to create a new project with the default settings simply run:
    
    radiant-go projectname
  
## customise your setup

**in short:**

    radiant-go --create-config projectfolder
    # modify the config and gemfiles
    radiant-go projectfolder

**slightly longer explaination:**

to customise the setup of radiant go, simply run the config generator:
  
    radiant-go --create-config projectname
this generates a folder with a Gemfile that you can alter and a config file located at config/radiant-go.rb. modify these files to your liking and then run the radiant-go generator on that project folder
    
    radiant-go projectname
  
## migration order

gems will be migrated in the order they appear in the Gemfile. if you have an extension that depends on another, put the dependency first in the Gemfile to have its migration run first.

## windows support

there is none unfortunately. radiant-go runs external generators and POSIX commands which won't work on windows it should work fine on OS X / Linux. If you want to build windows support, please feel free to fork the project.

## vendored extensions

currently radiant-go only supports extensions as gems. this is on purpose, all radiant extensions should be moved to gems, it's a much nicer and easier way to deal with them. See this screencast for more information on gem extensions http://radiantcms.org/blog/archives/2010/07/01/radiantcasts-episode-18-extensions-as-gems/

## license

radiant-go is licensed under the MIT standard license. see LICENSE for further information.