#
# prefix.rb
#

module Puppet::Parser::Functions
  newfunction(:prefix, :type => :rvalue, :doc => <<-EOS
    EOS
  ) do |arguments|

    # Technically we support two arguments but only first is mandatory ...
    raise(Puppet::ParseError, "prefix(): Wrong number of arguments " +
      "given (#{arguments.size} for 1)") if arguments.size < 1

    array = arguments[0]

    unless array.is_a?(Array)
      raise(Puppet::ParseError, 'prefix(): Requires array to work with')
    end

    prefix = arguments[1] if arguments[1]

    if prefix
      unless prefix.is_a?(String)
        raise(Puppet::ParseError, 'prefix(): Requires string to work with')
      end
    end

    # Turn everything into string same as join would do ...
    result = array.collect do |i|
      i = i.to_s
      prefix ? prefix + i : i
    end

    return result
  end
end

# vim: set ts=2 sw=2 et :
