# encoding: utf-8

require 'text2048/monkey_patch/hash/converter'

# Monkey-patched standard Hash class.
class Hash
  include Text2048::MonkeyPatch::Hash::Converter
end
