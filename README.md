# RSpec HTML Formatter2

Publish pretty [rspec](http://rspec.info/) reports

This is a ruby RSpec custom formatter which generates pretty html reports showing the results of rspec tests. It has features to embed images and videos into report providing better debugging information in case test is failed. Check this [Sample Report](https://vbanthia.github.io/rspec_html_formatter2/index.html).

## Setup

Add this in your Gemfile:

```rb
gem 'rspec_html_formatter2', git: 'https://github.com/vbanthia/rspec_html_formatter2'
```
**Note:** Will publish it soon.

## Running

Either add below in your `.rspec` file

```rb
--format RspecHtmlFormatter
```

or run RSpec with `--format RspecHtmlFormatter` like below:

```bash
REPORT_PATH=reports/$(date +%s) bundle exec rspec --format RspecHtmlFormatter spec
```

Above will create reports in `reports` directory.

## Usage
Images and videos can be embed by adding their path into example's metadata. Check this [Sample Test](./spec/embed_graphics_spec.rb).


## Credits
This library is forked from [kingsleyh/rspec_reports_formatter](https://github.com/kingsleyh/rspec_reports_formatter). Original Credits goes to *[kingsleyh](https://github.com/kingsleyh)*
