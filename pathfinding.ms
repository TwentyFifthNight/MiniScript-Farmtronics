
import "coreUtils"
import "reverseList"
ensureImport "Point"

isEqual = function(point, goal)
  return (point.x == goal.x and point.y == goal.y)
end function

findPointInList = function(arr, point)
  if not point isa Point then
    print "FindPoint invalid argument"
    return null
  end if
  
  if not arr isa list then
    print "FindPoint invalid argument"
    return null
  end if
  
  for el in arr
    if isEqual(el, point) then
      return el
    end if
  end for
  return null
end function

isPassable = function(x, y)
  tile = farm.tile(x, y)
  if tile == null then
    return true
  end if
  //if animal or player is on path add tile and wait for it to move
  bool = (tile.passable == 1 or 
  tile.type == "Character" or
  tile.type == "BotObject") and 
  tile.type != "Building"
  return bool
end function


findMinFIndex = function(array)
  //search in reverse!!!
  index = array.len - 1
  for i in range(array.len - 2, 0)
    if array[i].f < array[index].f then
      index = i
    end if
  end for
  return index
end function

globals.findPath = function(origin, goal)
  if not (origin isa Point and goal isa Point) then
    print "Argument must be Point"
    return []
  end if
  
  if goal.x < 0 or goal.x > farm.width then
    print "Invalid goal x"
    return []
  end if
  
  if goal.y < 0 or goal.y > farm.height then
    print "Invalid goal y"
    return []
  end if
  
  if not isPassable(goal.x, goal.y) then
    print "can't reach goal"
    return []
  end if
  
  if isEqual(origin, goal) then
    return []
  end if
  
  closedList = []
  openList = [origin]
  
  while openList
    yield
    index = findMinFIndex(openList)
    currentPoint = openList[index]
    openList.remove(index)
    closedList.push(currentPoint)
    
    neighbours = currentPoint.getNeighbours
    for neighbour in neighbours
      if not isPassable(neighbour.x, neighbour.y) then
        closedList.push(neighbour)
        continue
      end if
      
      if findPointInList(closedList, neighbour) != null then
        continue
      end if
      
      neighbour.calculateF(currentPoint, goal)
      
      element = findPointInList(openList, neighbour)
      if element != null then
        if element.f < neighbour.f then
          continue
        end if
      end if
      
      neighbour.parent = currentPoint
      
      if isEqual(neighbour, goal) then
        return createPath(origin, neighbour) 
      end if
      
      openList.push(neighbour)
    end for
  end while
  return []
end function

createPath = function(origin, goal)
  if not (origin isa Point and goal isa Point) then
    print "createPath invalid argument"
    return []
  end if
  
  path = []
  currentPoint = goal
  while not isEqual(currentPoint, origin)
    path.push(currentPoint)
    currentPoint = currentPoint.parent
    if currentPoint == null then
      return []
    end if
  end while
  
  path.push(origin)
  return path.reverse
end function
