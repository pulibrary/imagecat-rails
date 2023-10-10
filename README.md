# imagecat-rails

A rewrite of a imagecat.princeton.edu 
---
This catalog contains records for items cataloged before 1980.
Records are arranged alphabetically with authors, titles, and subjects interfiled.

[![CircleCI](https://dl.circleci.com/status-badge/img/gh/pulibrary/imagecat-rails/tree/main.svg?style=svg)](https://dl.circleci.com/status-badge/redirect/gh/pulibrary/imagecat-rails/tree/main)

[![Rails Style Guide](https://img.shields.io/badge/code_style-rubocop-brightgreen.svg)](https://github.com/rubocop/rubocop-rails)

[![Coverage Status](https://coveralls.io/repos/github/pulibrary/imagecat-rails/badge.svg?branch=main)](https://coveralls.io/github/pulibrary/imagecat-rails?branch=main)

## System dependencies

This project uses [asdf](https://asdf-vm.com/) (see .tool-versions for the current ruby version)

`bundle install` will install the dependencies for this project. Use `bundle install` also when updating ruby gems for this project.

## Database Setup

We use Postgres and run it via Lando in development.

Lando installation: [[https://github.com/lando/lando/releases]]

Startup: `rake servers:start`

## How to start application locally 

Run the `bin/rails server` or `rails s` command, then in a browser connect to [localhost:3000](http://localhost:3000/)

## How to run the test suite

`bundle exec rspec <spec/**/*>`

## Deploying 

You may use Capistrano on the command line. 

`BRANCH=branch_name bundle exec cap staging deploy`

`BRANCH=branch_name bundle exec cap production deploy`

Alternatively, you may deploy from [ansible-tower](https://ansible-tower.princeton.edu/).

## How to load data 

We want to load in CSV files that contain GuideCard and SubGuideCard data, which was exported from the legacy version of this application. The data lives in the `data` folder of this project. 

To list all import services for the application: `rake -T | grep import`

To import the GuideCard records (takes about 3 minutes): `rake import:import_guide_cards`
To import the SubGuideCard records (takes about 2 minutes): `rake import:import_sub_guide_cards`

The CardImage records are the images that are included in the GuideCard and SubGuideCard records. There are 5,786,727 images. These are estimated to take about 1 day to import.

To import the CardImage records: `rake import:import_card_images`

*Note*: AWS configuration will be required for your local machine to access the images on AWS (puliiif-production s3 bucket where the images are stored).

### 1. Set up AWS account

1. Go to [https://princeton.edu/aws](https://princeton.edu/aws) and log in with Princeton credentials.
1. From the "Services" menu, select "IAM". (You might need to search for IAM in the search bar.) Under the "User" menu, create a new user. Use any user name you prefer, as long as it would be clear to your team mates that this name is associated with you.
1. Add the user to the `iiifcloud` group.
1. Create the user, and click on it in the user list.
1. click "Create access key"
1. Select use case: Local code; give it a name
1. Record the Access Key ID and the Secret access key you'll get on the `Success` screen. You will need to add these to your local user profile when you set up AWS command line access.

### 2. Install and configure aws cli

1. Install the aws cli: https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html

2. Configure it using the Access key ID and Secret Access key attached to your account. Do this by running `aws configure` or following instructions [here](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-quickstart.html).

- Use default region `us-east-1`

- If you added the key to a new config stanza in your ~/.aws/credentials, you'll
    need to run aws commands with the --profile command line option

## Install lux 

The following steps will help to set up lux for this application. 

Step 1: We followed the [lux documentation](https://vite-ruby.netlify.app/guide/#installation-%F0%9F%92%BF) to install vite-ruby. 

Step 2: 

Then run the following commands:

`yarn add lux-design-system`

`yarn add sass`

Step 3:

We want to make sure that our package.json file matches step 6 in the [lux install guide](https://pulibrary.github.io/lux/docs/#/Installing%20LUX): 

```
"dependencies": {
  "lux-design-system": "^2.0.4",
  "vue": "^2.6.10",
  "vue-loader": "^15.7.0",
  "vue-template-compiler": "^2.6.10"
},
```

Step 4:
We will then add the following to ensure that the view renders successfully (tested using localhost). The package.json file now looks like this: 

```
{
  "devDependencies": {
    "vite": "^4.2.1",
    "vite-plugin-ruby": "^3.2.1"
  },
  "dependencies": {
    "lux-design-system": "^4.3.0",
    "sass": "^1.62.0",
    "vue": "^2.6.10",
    "vue-loader": "^15.7.0",
    "vue-template-compiler": "^2.6.10"
  }
}
```
Step 5:
Paste in code block from step 8 into app/javascript/entrypoints/application.js

```
import Vue from "vue/dist/vue.esm"
import system from "lux-design-system"
import "lux-design-system/dist/system/system.css"
import "lux-design-system/dist/system/tokens/tokens.scss"
import store from "../store" // this is only if you are using vuex

Vue.use(system)

// create the LUX app and mount it to wrappers with class="lux"
document.addEventListener("DOMContentLoaded", () => {
  var elements = document.getElementsByClassName("lux")
  for (var i = 0; i < elements.length; i++) {
    new Vue({
      el: elements[i],
      store, // this is only if you're using vuex
    })
  }
})
```

Step 6:
Add the following code block (retrieved from https://pulibrary.github.io/lux/docs/#/Patterns/LibraryHeader):

```
<library-header app-name="Leave and Travel Requests" abbr-name="LTR" app-url="https://catalog.princeton.edu" theme="dark">
    <menu-bar type="main-menu" :menu-items="[
        {name: 'Help', component: 'Help', href: '/help/'},
        {name: 'Feedback', component: 'Feedback', href: '/feedback/'},
        {name: 'Your Account', component: 'Account', href: '/account/', children: [
          {name: 'Logout', component: 'Logout', href: '/account/'}
        ]}
      ]"
    ></menu-bar>
  </library-header>
  ```

If things have successfully installed, when running your local server you should see this [header](https://pulibrary.github.io/lux/docs/#/Patterns/LibraryHeader).

## Use Cases for Imagecat

* When cards were converted to OCLC records, there were quality assurance issues. These scanned cards allow us to correct these errors when they come up. 

* If we don’t correct the errors then people will be misled, e.g. notes about items held in another library, not at Princeton

* There may be accession ids on the cards (used between 1900 and 1942 or 43) that match with entries in accession books, which have info about where we got the book and how much we paid for it. This is pertinent for rare books.

* Call numbers may exist on the current site that weren’t transferred and that may need to be updated.

* Law enforcement sometimes wants to know provenance -- proof of ownership and when we acquired an item.

* Provides a historical view of library to a certain point in time, e.g. wrote an article about 3 millionth acquisition.

* Grants the ability to print a single card and carry it into the stacks

## How to access legacy RDP code for ImageCat

To better understand how the SubGuide and GuideCard data relates to each other, we are able to use RDP to access the legacy code within a Windows virtual environment. 

To access the code, you will need to have the Microsoft Remote Desktop application installed on your machine.

Click the 'add workspace or desktop' icon and add the following:
- `lib-dbserver.princeton.edu` will be the hostname
- the user account will most likely be your CAS login (xxxxxx@princeton.edu) 
  - will need to request access to the server from a System Administrator in the Operations team
- click  the 'Display' tab on the screen, and select the best resolution for your monitor, if desired

Once this is set up, right-click on `lib-dbserver.princeton.edu` to connect
- press continue on the pop-up of the certificate warning to proceed
- Duo-enabled support required to access the server

During the initial launch, it may take longer for the server to boot up due to the configs being created. 

Navigate to `Computer` then `C:/inetpub/wwwroot/ImageCat` to access the legacy files.
