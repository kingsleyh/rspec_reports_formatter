# Publish pretty [rspec](http://rspec.info/) reports

This is a ruby Rspec custom formatter which generates pretty html reports showing the results of rspec tests.

## Install

```
  gem install rspec_reports_formatter
```

## Use
When running your rspec tests just use the custom formatter:

```
 rspec --require rspec_html_formatter.rb --format RspecHtmlFormatter spec
```


![example overview report]
(https://raw.githubusercontent.com/kingsleyh/rspec_reports_formatter/master/.README/rspec_reports_overview.png)

![example report]
(https://github.com/kingsleyh/rspec_html_formatter/raw/master/.README/rspec_reports_report.png)

If you want to provide some generated documentation for the tests you can put comments in the rspec tests like this:

```ruby
  #-> Given I have ordered a vegetarian pizza
  #-> When I eat the pizza
  #-> Then my tummy is full

```

The #-> notation is picked up and passed through a Gherkin syntax highlighter. So it was designed to use with Given,When,Then. But in theory you can put other text there too.
