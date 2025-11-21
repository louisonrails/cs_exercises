# frozen_string_literal: true

class MergeSort
  def sort(arr)
    num_elements = arr.length
    return arr if num_elements <= 1

    half_of_elements = (num_elements / 2).round

    left = arr.take(half_of_elements)
    right = arr.drop(half_of_elements)

    sorted_left = sort(left)
    sorted_right = sort(right)

    merge(sorted_left, sorted_right)
  end

  def merge(left_array, right_array)
    return left_array if right_array.empty?
    return right_array if left_array.empty?

    smallest_number = left_array.first <= right_array.first ? left_array.shift : right_array.shift

    recursive = merge(left_array, right_array)

    [smallest_number].concat(recursive)
  end
end

merge_sort = MergeSort.new
puts merge_sort.sort([73])
puts 'Second Test'
puts merge_sort.sort([1, 2, 3, 4, 5])
puts 'Third Test'
puts merge_sort.sort([3, 2, 1, 13, 8, 5, 0, 1])
puts 'Fourth Test'
puts merge_sort.sort([105, 79, 100, 110])
