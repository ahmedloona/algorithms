=begin
Merge sort pseudocode
1. input: unsorted array length n, output: sorted array length n
2. example: [9, 8, 7, 6, 5, 4, 3, 2, 1] ->
                                       [1, 2, 3, 4, 5, 6, 7, 8, 9]
A. if array length > 1,
     divide array into 2 equal length subarrays, left and right
   else
     return the input array, as is
B. pass left and right subarrays (recursively) to sort(subarray)
C. merge the returned (sorted) subarrays using merge subroutine
=end

input = File.read("IntegerArray.txt")
input = input.split("\r\n").map {|string| string.to_i}

input = (1..1000000).to_a.reverse
#puts "input length is: #{input}"

def subarray(array, left_right)
  middle = array.length / 2
  left, right = array[0...middle], array[middle..-1]
  (left_right == "left") ? left : right
end

def merge(left, right)
  inv_count = 0
  merged = [nil] * (left.length + right.length)
  i, j = 0, 0
  merged.each_index do |index|
    if i == left.length
      merged = merged[0...index] + right[j..-1]
      break
    elsif j == right.length
      merged = merged[0...index] + left[i..-1]
      break
    elsif left[i] <= right[j]
      merged[index] = left[i]
      i += 1
    elsif right[j] < left[i]
      merged[index] = right[j]
      inv_count += left[i..-1].length
      j += 1
    end
  end
    [merged, inv_count]
end

def sort(input)
  inversions = 0
  if input.length < 2
    return [input, 0]
  end
  left, right = subarray(input, "left"), subarray(input, "right")
  #puts "A new level #{left} #{right}"
  sorted_left, sorted_right = sort(left), sort(right)
  #puts " #{sorted_left} #{sorted_right}"
  output, split_inv = merge(sorted_left.first, sorted_right.first)
  inversions = sorted_left.last + sorted_right.last + split_inv
  #puts "previous level.. inverson_total #{inversions}"
  [output, inversions]
end

#p sort([2, 1])
#p sort([6, 5, 4, 3, 2, 1])
#p sort([1, 3, 5, 2, 4, 6])

puts sort(input).last
