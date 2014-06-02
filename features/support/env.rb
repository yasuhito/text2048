# encoding: utf-8

require 'coveralls'
Coveralls.wear_merged!

# Dummy output
class Output
  def messages
    @messages ||= ''
  end

  def puts(message)
    messages << message
  end
end

def dummy_output
  @output ||= Output.new
end
