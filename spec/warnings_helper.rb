# frozen_string_literal: true

begin
  require 'warning'
rescue LoadError
  # ignore
else
  $VERBOSE = true
  Warning.ignore([:missing_ivar, :method_redefined], File.dirname(__dir__))
  Gem.path.each do |path|
    Warning.ignore([:missing_ivar, :method_redefined, :not_reached], path)
  end
end

