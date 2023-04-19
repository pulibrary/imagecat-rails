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

`bundle install` will install the dependencies for this project. 

## Database Setup

We use Postgres and run it via Lando in development.

Lando installation: [[https://github.com/lando/lando/releases]]

Startup: `rake servers:start`

## How to start application locally 

Run the `bin/rails server` command, then in a browser connect to [localhost:3000](http://localhost:3000/)

## How to run the test suite

`bundle exec rspec spec`

## Deploying 

Currently, this application can not be deployed with pulbot. You must use Capistrano on the command line. 

`BRANCH=branch_name bundle exec cap staging deploy`

## How to load data 

We want to load in CSV files that contain GuideCards and SubGuides data, which was exported from the legacy version of this application. The data lives in the `data` folder of this project. 

To import the GuideCards records: `rake import:import_guide_cards`

## Install vite and lux 

Since we are using vite in the application, the following steps will help to set up the lux-integration library. 

Step 1: We followed the [lux documentation](https://vite-ruby.netlify.app/guide/#installation-%F0%9F%92%BF) to install vite-ruby. 

Step 2: 

Then run the following commands:

`yarn add lux-design-system`

`yarn add sass`

Step 3:

We want to make sure that our package.json file matches step 6 in the [lux install guide](https://pulibrary.github.io/lux/docs/#/Installing%20LUX): 

```
"dependencies": {
  "@rails/webpacker": "^3.3.1",
  "lux-design-system": "^2.0.4",
  "vuex": "^2.4.1",
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