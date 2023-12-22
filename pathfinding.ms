import "coreUtils"
import "reverseList"
ensureImport "Point"
import "heapSort"

isEqual = function(point, goal)
  return point.x == goal.x and point.y == goal.y
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
  return tile.passable == 1 or 
  tile.type == "Character" and tile.type != "Building"
end function

globals.findPath = function(origin, goal)
  if not (origin isa Point and goal isa Point) then
    print "Argument must be Point"
    return
  end if
  if goal.x < 0 or goal.x > farm.width then
    print "Invalid goal x"
    return
  end if
  if goal.y < 0 or goal.y > farm.height then
    print "Invalid goal y"
    return
  end if
  if not isPassable(goal.x, goal.y) then
    print "can't reach goal"
    return
  end if
  
  closedList = []
  openList = [origin]
  
  while openList
    heapsort(openList)
    currentPoint = openList.pop
    closedList.push(currentPoint)
    
    if(isEqual(currentPoint, goal)) then
      return createPath(origin, currentPoint)
    end if
    
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
      openList.push(neighbour)
    end for
  end while
  return null
end function

createPath = function(origin, goal)
  if not (origin isa Point and goal isa Point) then
    print "createPath invalid argument"
    return null
  end if
  path = []
  currentPoint = goal
  while not isEqual(currentPoint, origin)
    path.push(currentPoint)
    currentPoint = currentPoint.parent
    if currentPoint == null then
      return null
    end if
  end while
  path.push(origin)
  return path.reverse
end function

origin = new Point
origin.x = 20
origin.y = 10
goal = new Point
goal.x = 60
goal.y = 20

start = time
path = findPath(origin,goal)
tend = time

if path isa list then
  for el in path
    print el.x + " " + el.y
  end for
else
  print "no path"
end if

print "duration: " + (tend - start)