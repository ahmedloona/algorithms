=begin
1. INPUT: Array A size n, OUTPUT: ascending Sorted version of Array A
2. [3, 8, 2, 4, 1, 5, 6, 7] => [1, 2, 3, 4, 5, 6, 7]
3. QuickSort Pseudocode
   quick_sort(array)
     if array_length == 1
       return array
     else
       pivot = get_pivot(array, pivot_type)
       partition array around pivot
       partitioned = partition(array, pivot)
       recursively sort 1st part of partitioned
       recursively sort 2nd part of partitioned
   end
=end

def get_pivot(array, l, r, pivot_type)
  case pivot_type
    when "first"
      l
    when "last"
      r
    when "random"
      (l..r).to_a.shuffle.first
    when "median"
      length = r - l + 1
      if length.even?
        middle = l + length / 2 - 1
      else
        middle = l + length / 2
      end
      first_mid_last = [array[l], l], [array[middle], middle], [array[r], r]
      first_mid_last.sort()[1][1]
  end
end

def partition(array, l, r, pivot_index)
  array[l], array[pivot_index] = array[pivot_index], array[l]
  pivot = array[l]
  unseen = l + 1
  divider = l + 1
  while unseen <= r
    if array[unseen] < pivot
      array[divider], array[unseen] = array[unseen], array[divider]
      divider += 1
    end
    unseen += 1
  end
  array[divider - 1], array[l] = array[l], array[divider - 1]
  divider - 1
end

def quick_sort(array, l, r)
  if r <= l
    0
  else
    pivot_index_pre = get_pivot(array, l, r, "median")
    $comparisons += r - l
    pivot_index_post = partition(array, l, r, pivot_index_pre)
    quick_sort(array, l, pivot_index_post - 1)
    quick_sort(array, pivot_index_post + 1, r)
  end
end

input = File.read("./QuickSort.txt")
input = input.split("\r\n").map { |string| string.to_i }

$comparisons = 0
left, right = 0, input.length - 1
quick_sort(input, left, right)
puts "sorted : #{input}"
puts "comparisons : #{$comparisons}"
