function myfunc22, input, FUNCTARGS=fcnargs
  result1 = fcnargs.scale1*total(input)
  result2 = fcnargs.scale2*(input[1]^input[0])
  return, [result1, result2]
end

