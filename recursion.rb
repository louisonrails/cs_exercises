# frozen_string_literal: true

def fibs(num)
  return [0] if num == 1
  return [0, 1] if num == 2

  arr = fibs(num - 1)
  arr << arr[-1] + arr[-2]
end

array = fibs(15)
puts array
