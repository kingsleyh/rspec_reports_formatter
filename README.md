# Publish pretty [rspec](http://rspec.info/) reports

This is a ruby Rspec custom formatter which generates pretty html reports showing the results of rspec tests. This gem was build to use Rspec 3.x.x If you want to use it with older
versions of Rspec then you should use the rspec_reports_formatter 0.2.x (2.8.0 branch)

* For Rspec 2.x.x please use rspec_reports_formatter version starting with 0.2.x
* For Rspec 3.x.x please use the rspec_reports_formatter version starting with 0.3.x


## Install

```
  gem install rspec_html_formatter -v 0.3.1
```

ideally just add it to your bundler Gemfile as follows:

```ruby
 gem 'rspec_html_formatter','~> 0.3.1'
```

## Use
When running your rspec tests with rspec 3.0.0 just use the custom formatter:

This should work:

```
 rspec -f RspecHtmlFormatter spec
```

If not you can explicitly add in a require as follows:

```
 rspec --require rspec_html_formatter.rb --format RspecHtmlFormatter spec
```

![example overview report]
(https://raw.githubusercontent.com/kingsleyh/rspec_reports_formatter/master/.README/rspec_reports_overview.png)

![example report]
(https://raw.githubusercontent.com/kingsleyh/rspec_reports_formatter/master/.README/rspec_reports_report.png)

If you want to provide some generated documentation for the tests you can put comments in the rspec tests like this:

```ruby
  #-> Given I have ordered a vegetarian pizza
  #-> When I eat the pizza
  #-> Then my tummy is full

```

The #-> notation is picked up and passed through a Gherkin syntax highlighter. So it was designed to use with Given,When,Then. But in theory you can put other text there too.
