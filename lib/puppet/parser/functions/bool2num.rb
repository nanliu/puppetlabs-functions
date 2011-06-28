#
# bool2num.rb
#

module Puppet::Parser::Functions
  newfunction(:bool2num, :type => :rvalue, :doc => <<-EOS) do |arguments|
    Converts boolean to number 1 true, or 0 false. This function is
    different from standard Puppet behavior:
      Puppet:
        undef, false, '': false
        true, 'false', Any valid string: true

      bool2num:
        undef, '', '0', 'f', 'n', 'false', 'no': false
        true, '1', 't', 'y', 'true', 'yes': true
        default: Raise Puppet::ParseError.

    Example:

      $bool = true
      $num  = bool2num($bool)
    EOS
    raise(Puppet::ParseError, "bool2num(): Wrong number of arguments " +
      "given (#{arguments.size} for 1)") if arguments.size < 1

    value = arguments[0]
    klass = value.class

    # We can have either true or false, or string which resembles boolean ...
    unless [FalseClass, TrueClass, String].include?(klass)
      raise(Puppet::ParseError, 'bool2num(): Requires either ' +
        'boolean or string to work with')
    end

    if value.is_a?(String)
      # We consider all the yes, no, y, n and so on too ...
      value = case value
        #
        # This is how undef looks like in Puppet ...
        # We yield 0 (or false if you wish) in this case.
        #
        when /^$/, '' then false # Empty string will be false ...
        when /^(1|t|y|true|yes)$/  then true
        when /^(0|f|n|false|no)$/  then false
        when /^(undef|undefined)$/ then false # This is not likely to happen ...
        else
          raise(Puppet::ParseError, 'bool2num(): Unknown type of boolean given')
      end
    end

    # We have real boolean values as well ...
    result = value ? 1 : 0

    return result
  end
end
