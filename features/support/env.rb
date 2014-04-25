# encoding: utf-8

# Dummy output
class Output
  def messages
    @messages ||= ''
  end

  def puts(message)
    messages << message
  end
end

def output
  @output ||= Output.new
end
