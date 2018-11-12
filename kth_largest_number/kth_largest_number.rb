def choose_pivot(array, first, last)
  puts "array unpartitioned: #{array}"
  res = (first..last).to_a.shuffle[0]
  puts "pivot  index is: #{res}"
  res
end

def partition(array, first, last, pivot_index)
  puts "pre partition array: #{array}"
  array[first], array[pivot_index] = array[pivot_index], array[first]
  pivot = array[first]
  puts "pivot: #{pivot} index: #{pivot_index}"
  i = first + 1
  j = first + 1
  puts "j : #{j}"
  while j <= last
          puts "running this"
    if array[j] < pivot
      array[j], array[i] = array[i], array[j]
      i += 1
    end
    j += 1
  end
  array[first], array[i - 1] = array[i - 1], array[first]
  puts "post partition array: #{array}"
  i - 1
end

def random_select(array, first, last, i)
    if first == last
      array[last]
    else
      # For a sorted array, finding the kth largest element is equivalent to finding the element at index = array.length - k
      #i = last - first - k
      i = i - 1
      pivot_index_pre = choose_pivot(array, first, last)
      #puts "pivot_pre_idx: #{pivot_index_pre} pivot: #{array[pivot_index_pre]} "
      pivot_index = partition(array, pivot_index_pre, first, last)
      #puts "array partitioned: #{array}"
      #puts "pivot_post_idx: #{pivot_index}"
      if pivot_index == i
        puts "case1"
        return array[pivot_index]
      elsif i < pivot_index
        puts "case2"
        random_select(array, first, pivot_index - 1, i)
      elsif i > pivot_index
        puts "case3"
        random_select(array, pivot_index + 1, last, pivot_index - i)
      end
    end
end

#puts choose_pivot([1,2,3,4,5,6], 0, 5)

#partition([6, 5, 4, 3, 2, 1], 0, 5, 2)

puts random_select([6, 5, 4, 3, 2, 1], 0, 5, 1)
