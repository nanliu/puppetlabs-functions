# bool2num function evaluates bool differently from standard puppet
# behavior. See function documentation for details

$num1  = bool2num($bool1)

$bool2 = false
$num2  = bool2num($bool2)

$bool3 = '0'
$num3  = bool2num($bool3)

$bool4 = 'f'
$num4  = bool2num($bool4)

$bool5 = 'n'
$num5  = bool2num($bool5)

$bool6 = 'false'
$num6  = bool2num($bool6)

$bool7 = 'no'
$num7  = bool2num($bool7)

$bool8 = true
$num8  = bool2num($bool8)

notice($num1, $num2, $num3, $num4, $num5, $num6, $num7, $num8)

$bool9 = 'any'
$num9  = bool2num($bool9)
