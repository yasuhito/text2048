# encoding: utf-8

# This module smells of :reek:UncommunicativeModuleName
module Text2048
  module MonkeyPatch
    module Hash
      # For 1.9 backword compatibility
      module Converter
        def hashinize
          self
        end
      end
    end
  end
end
