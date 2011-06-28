#
# abs.rb
#

module Puppet::Parser::Functions
  newfunction(:abs, :type => :rvalue, :doc => <<-EOS) do |arguments|
    Converts to int or float and return the absolute value

    Example:

      $num = "-1.2"
      $abs_num = abs($num)
    EOS
    raise(Puppet::ParseError, "abs(): Wrong number of arguments " +
      "given (#{arguments.size} for 1)") if arguments.size < 1

    value = arguments[0]

    # Numbers in Puppet are often string-encoded which is troublesome ...
    if value.is_a?(String)
      if value.match(/^-?(?:\d+)(?:\.\d+){1}$/)
        value = value.to_f
      elsif value.match(/^-?\d+$/)
        value = value.to_i
      else
        raise(Puppet::ParseError, 'abs(): Requires float or ' +
          'integer to work with')
      end
    end

    # We have numeric value to handle ...
    result = value.abs

    return result
  end
end
