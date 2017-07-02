# Here For Reentry

[![Build Status](https://travis-ci.org/rubyforgood/reentry.svg?branch=master)](https://travis-ci.org/rubyforgood/reentry)

### Social Services Aggregator and Distribution Hub

Collecting social services data is hard, time-consuming and expensive. Data comes from a variety of, often siloed, sources. Data falls out of date almost immediately, resulting in information about critical services that is often inaccurate or incomplete for those who need it the most. In many cases, updates are made by employees calling different organizations to get new information, taking away valuable time that could be spent helping people and making it harder for those who need the information to get it in a timely manner.

This project aims to create a more maintainable data aggregation and distribution system. Made up of several crawlers, it pulls information from publicly available social services websites, CSVs and PDFs. It aggregates the data, evaluating it for accuracy and relevancy, and generates standardized data dumps in hopes of making it easier for the social service organizations to maintain accurate information. This project is still in development. Ultimately this data will power a version of the [Ohana API](https://github.com/codeforamerica/ohana-api), a Ruby on Rails application that makes it easy for communities to publish and maintain a database of social services.

### About Here For Reentry
Here For Reentry is a community-based organization focused on creating a toolset to help returning citizens successfully reintegrate into society. Here For Reentry uses online tools to help these citizens interact socially with one another, learn about important social services available to them and organize politically to advocate for issues relevant to their lives and their communities. These are our neighbors, our friends and our family.

Here For Reentry's mission is to provide returning citizens everywhere with an all-in-one resource portal and to support an ecosystem of information sharing and connection to care. Learn more about Here For Reentry and view other tools on their website,[https://here4reentry.com].


### Development

This section will help you get setup to develop and run the project locally.  For information about contributing, please check out the [Contributing](#contributing) section.

You will need Git, Ruby 2.4.1 and PostgreSQL. The current Rails version is 5.1.1. This project also uses [Tabula](https://github.com/tabulapdf/tabula) to assist with parsing PDF files and is required by some of the tests. These tests are skipped if `ENV['TEST_FASTER']`.

If you are starting with a virgin machine, these guides will help you with the initial setup of your development environment.

* For Mac OSX, follow these [directions](https://gorails.com/setup/osx/10.12-sierra). This includes PostgreSQL.
* For Ubuntu Linux, follow these [directions](https://gorails.com/setup/ubuntu/17.04).
* For Windows, [RailsInstaller](http://railsinstaller.org/en) can help you get started quickly.

From the terminal:  
* Clone the repository  
* Run `bin/setup`

Running `bin/setup` will provide you with an admin and a regular user to login locally as. `bin/rails db:setup` will also provide these.

Email: `admin@example.com` or `user@example.com`
Password: `password`

To run tests:  
`bin/rails test`

### Contributing

We ♥ contributors! If you are interested in contributing, please checkout out our [guidelines for contributing](CONTRIBUTING.md) before submitting a pull request

Most of our development discussion happens in the [#reentry](https://rubyforgood.slack.com/messages/habitat_humanity) channel on the Ruby for Good Slack. [Get an invite](https://rubyforgood.herokuapp.com/).
