def beautiful_array(n)
  if n == 1
    [1]
  else
    left = beautiful_array((n+1)/2)
    right = beautiful_array(n/2)
    left.map! { |i| 2*i - 1 } + right.map! { |i| 2*i }
    left + right
  end
end


res = beautiful_array(8)
p res
