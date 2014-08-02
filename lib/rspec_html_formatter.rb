require 'rspec/core/formatters/base_formatter'
require 'active_support'
require 'active_support/core_ext/numeric'
require 'active_support/inflector'
require 'fileutils'
require 'rouge'
require 'erb'

I18n.enforce_available_locales = false

class Oopsy
  attr_reader :klass, :message, :backtrace, :highlighted_source, :explanation, :backtrace_message

  def initialize(exception, file_path)
    @exception = exception
    @file_path = file_path
    unless @exception.nil?
      @klass = @exception.class
      @message = @exception.message
      @backtrace = @exception.backtrace
      @backtrace_message = @backtrace.select { |r| r.match(@file_path) }.join('')
      @highlighted_source = process_source
      @explanation = process_message
    end
  end

  private

  def process_source
    data = @backtrace_message.split(':')
    file_path = data.first
    line_number = data[1].to_i
    lines = File.readlines(file_path)
    start_line = line_number-2
    end_line = line_number+3
    source = lines[start_line..end_line].join("").sub(lines[line_number-1].chomp, "--->#{lines[line_number-1].chomp}")

    formatter = Rouge::Formatters::HTML.new(css_class: 'highlight', line_numbers: true, start_line: start_line+1)
    lexer = Rouge::Lexers::Ruby.new
    formatter.format(lexer.lex(source))

  end

  def process_message
    formatter = Rouge::Formatters::HTML.new(css_class: 'highlight')
    lexer = Rouge::Lexers::Ruby.new
    formatter.format(lexer.lex(@message))
  end

end

# class Specify
#
#   attr_reader :detail
#
#   def initialize(example)
#     @example = example
#     @detail = process_detail
#     has_specification?
#   end
#
#   private
#
#   def has_specification?
#      start_line = @example.metadata[:line_number]
#      lines = File.readlines(@example.file_path)
#      code_lines = []
#      lines.each_with_index do |l,i|
#        code_lines << l if i >= start_line.to_i
#        break if l.match(/end\n/)
#      end
#      p code_lines
#   end
#
#   def process_detail
#     source = "Given some stuff\nWhen I do it\nThen all is great"
#     formatter = Rouge::Formatters::HTML.new(css_class: 'highlight')
#        lexer = Rouge::Lexers::Gherkin.new
#        formatter.format(lexer.lex(source))
#   end
#
# end

class Example

  attr_reader :description, :full_description, :run_time, :duration, :status, :exception, :file_path, :metadata, :spec

  def initialize(example)
    @description = example.description
    @full_description = example.full_description
    @execution_result = example.execution_result
    @run_time = (@execution_result[:run_time]).round(5)
    @duration = @execution_result[:run_time].to_s(:rounded, precision: 5)
    @status = @execution_result[:status].to_s
    @metadata = example.metadata
    @file_path = @metadata[:file_path]
    @exception = Oopsy.new(example.exception, @file_path)
    @spec = nil
  end

  def has_exception?
    !@exception.klass.nil?
  end

  def has_spec?
    !@spec.nil?
  end

  def set_spec(spec)
    @spec = spec
  end

  def klass(prefix='label-')
    class_map = {passed: "#{prefix}success", failed: "#{prefix}danger", pending: "#{prefix}warning"}
    class_map[@status.to_sym]
  end

end

class Specify

  def initialize(examples)
    @examples = examples
  end

  def process
    lines = File.readlines(@examples.first.file_path)
    @examples.each_with_index do |e, i|
      start_line = e.metadata[:line_number]
      end_line = @examples[i+1].nil? ? lines.size : @examples[i+1].metadata[:line_number] - 1
      code_block = lines[start_line..end_line]
      spec = code_block.select { |l| l.match(/#->/) }.join('')
      if !spec.split.empty?
        formatter = Rouge::Formatters::HTML.new(css_class: 'highlight')
        lexer = Rouge::Lexers::Gherkin.new
        formatted_spec = formatter.format(lexer.lex(spec.gsub('#->', '')))
        e.set_spec(formatted_spec)
      end
    end
    @examples
  end
end

class RspecHtmlFormatter < RSpec::Core::Formatters::BaseFormatter

  REPORT_PATH = './rspec_html_reports'

  def initialize(io_standard_out)
    create_reports_dir
    create_resources_dir
    copy_resources
    @all_groups = {}
  end

  def example_group_started(example_group)
    @example_group = {}
    @group_examples = []
    @group_example_count = 0
    @group_example_success_count = 0
    @group_example_failure_count = 0
    @group_example_pending_count = 0
  end

  def example_started(example)
    @group_example_count += 1
  end

  def example_passed(example)
    @group_example_success_count += 1
    @group_examples << Example.new(example)
  end

  def example_failed(example)
    @group_example_failure_count += 1
    @group_examples << Example.new(example)
  end

  def example_pending(example)
    @group_example_pending_count += 1
    @group_examples << Example.new(example)
  end

  def dump_summary(duration, example_count, failure_count, pending_count)
    # All examples total summary
    # p @duration = duration
    # p @example_count = example_count
    # p @failure_count = failure_count
    # p @pending_count = pending_count
  end

  def example_group_finished(example_group)
    File.open("#{REPORT_PATH}/#{example_group.description.parameterize}.html", 'w') do |f|

      @passed = @group_example_success_count
      @failed = @group_example_failure_count
      @pending = @group_example_pending_count

      duration_values = @group_examples.map { |e| e.run_time }

      duration_keys = duration_values.size.times.to_a
      if duration_values.size < 2
        duration_values.unshift(duration_values.first)
        duration_keys = duration_keys << 1
      end

      @title = example_group.description
      @durations = duration_keys.zip(duration_values)
      @summary_duration = duration_values.inject(0) { |sum, i| sum + i }.to_s(:rounded, precision: 5)
      @examples = Specify.new(@group_examples).process

      class_map = {passed: 'success', failed: 'danger', pending: 'warning'}
      statuses = @examples.map { |e| e.status }
      status = statuses.include?('failed') ? 'failed' : (statuses.include?('passed') ? 'passed' : 'pending')
      @all_groups[example_group.description.parameterize] = {
          group: example_group.description,
          examples: @examples.size,
          status: status,
          klass: class_map[status.to_sym],
          passed: statuses.select { |s| s == 'passed' },
          failed: statuses.select { |s| s == 'failed' },
          pending: statuses.select { |s| s == 'pending' },
          duration: @summary_duration
      }

      template_file = File.read(File.dirname(__FILE__) + '/../templates/report.erb')

      f.puts ERB.new(template_file).result(binding)

    end

  end

  def close
    File.open("#{REPORT_PATH}/overview.html", 'w') do |f|
      @overview = @all_groups

      @passed = @overview.values.map { |g| g[:passed].size }.inject(0) { |sum, i| sum + i }
      @failed = @overview.values.map { |g| g[:failed].size }.inject(0) { |sum, i| sum + i }
      @pending = @overview.values.map { |g| g[:pending].size }.inject(0) { |sum, i| sum + i }

      duration_values = @overview.values.map { |e| e[:duration] }

      duration_keys = duration_values.size.times.to_a
      if duration_values.size < 2
        duration_values.unshift(duration_values.first)
        duration_keys = duration_keys << 1
      end

      @durations = duration_keys.zip(duration_values.map{|d| d.to_f.round(5)})
      @summary_duration = duration_values.map{|d| d.to_f.round(5)}.inject(0) { |sum, i| sum + i }.to_s(:rounded, precision: 5)
      @total_examples = @passed + @failed + @pending
      template_file = File.read(File.dirname(__FILE__) + '/../templates/overview.erb')
      f.puts ERB.new(template_file).result(binding)
    end
  end


  private
  def create_reports_dir
    FileUtils.rm_rf(REPORT_PATH) if File.exists?(REPORT_PATH)
    FileUtils.mkpath(REPORT_PATH)
  end

  def create_resources_dir
    file_path = REPORT_PATH + '/resources'
    FileUtils.mkdir_p file_path unless File.exists?(file_path)
  end

  def copy_resources
    FileUtils.cp_r(File.dirname(__FILE__) + '/../resources', REPORT_PATH)
  end

end
