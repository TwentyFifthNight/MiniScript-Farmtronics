import "coreUtils"
ensureImport "Point"

globals.count = 0

heapify = function(array, length, rootIndex)
  globals.count = globals.count + 1
  smallest = rootIndex; 
  l = 2 * rootIndex + 1; 
  r = 2 * rootIndex + 2;
  
  if l < length and array[l].f < array[smallest].f then
    smallest = l;
  end if
  if r < length and array[r].f < array[smallest].f then
    smallest = r;
  end if
  if smallest != rootIndex then
    swap = array[rootIndex];
    array[rootIndex] = array[smallest];
    array[smallest] = swap;
    
    heapify(array, length, smallest);
  end if
end function

globals.heapsort = function(array)
  if not array isa list then
    print "Sort argument must be a list"
    return
  end if
  length = array.len;
  
  globals.count = 0
  
  i = floor(length / 2 - 1)
  while i >= 0 
    heapify(array, length, i)
    i = i - 1
  end while
  
  i = length - 1
  while i > 0 
    temp = array[0]
    array[0] = array[i]
    array[i] = temp
    
    heapify(array, i, 0)
    i = i - 1
  end while
  return globals.count
end function