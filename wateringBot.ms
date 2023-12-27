// Watering Bot
import "pathfinding"

directions = {"North": 0, "East": 1, "South": 2, "West": 3}

endPositionX = 69
endPositionY = 28

waterSourceX = 69
waterSourceY = 28
directionToWater = directions["East"]

me.refill = function
  origin = new Point
  origin.x = me.position.x
  origin.y = me.position.y
  facing = me.facing
  goal = new Point
  goal.x = waterSourceX
  goal.y = waterSourceY
  
  path = findPath(origin, goal)
  for point in path
    me.moveTo(point.x, point.y)
  end for
  me.turn(directionToWater)
  me.select "Watering Can"
  me.useTool
  
  if path.len > 0 then
    for i in range(-1, (path.len * -1))
      point = path[i]
      me.moveTo(point.x, point.y)
    end for
  end if
  me.turn(facing)
end function

me.checkEmptyCan = function
  if me.inventory[me.currentToolIndex].type != "WateringCan" then
    me.select "Watering Can"
  end if
  if me.inventory[me.currentToolIndex].waterLeft < 1 then
    me.refill
  end if
end function

me.water = function
  me.checkEmptyCan
  me.select "Watering Can"
  me.useTool
end function

isDryCropAtTile = function(tile)
  if tile == null then return false
  bool = tile.hasIndex("crop")
  bool = bool and tile.hasIndex("dry")
  if bool then
    bool = bool and tile.crop
    bool = bool and tile.dry
  end if
  return bool
end function

isDryCropAhead = function
  tile = me.ahead
  return isDryCropAtTile(tile)
end function

me.turn = function(direction)
  if direction < 0 or direction > 3 then
    return
  end if
  if me.facing == direction then
    return
  else if (me.facing - direction) % 2 == 0 then
    me.right
    me.right
  else if (me.facing - 1) == direction or 
    (me.facing) == (direction - 3) then
    me.left
  else
    me.right
  end if
end function

isAheadOccupied = function
  if me.ahead == null then return false
  return me.ahead.type == "Character"
end function

me.moveForward = function
  if isAheadOccupied then
    print "Waiting for obstacle to move"
    wait 1
  else
    me.forward
  end if
end function

me.moveTo = function(x, y)
  if me.position.y > y then
    me.turn(directions["North"])
  else if me.position.y < y then
    me.turn(directions["South"])
  end if
  
  while me.position.y != y
    me.moveForward
  end while
  
  if me.position.x < x then
    me.turn(directions["East"])
  else if me.position.x > x then
    me.turn(directions["West"])
  end if
  
  while me.position.x != x
    me.moveForward
  end while
end function

me.moveToAndWater = function(x, y)
  if me.position.y > y then
    me.turn(directions["North"])
  else if me.position.y < y then
    me.turn(directions["South"])
  end if
  
  if isDryCropAhead then
    me.water
  end if
  
  while me.position.y != y
    me.moveForward
  end while
  
  if me.position.x < x then
    me.turn(directions["East"])
  else if me.position.x > x then
    me.turn(directions["West"])
  end if
  
  if isDryCropAhead then
    me.water
  end if
  
  while me.position.x != x
    me.moveForward
  end while
end function

moveThroughPath = function(path)
  if not path isa list then
    return
  end if
  
  for point in path
    if not point isa Point then
      print "Path element wasnt a Point"
      return
    end if
    me.moveToAndWater(point.x, point.y)
  end for
end function

distance = function(point1, point2)
  if not point1 isa Point then
    print "Argument must be Point(Distance)"
    return -1
  end if
  if not point1 isa Point then
    print "Argument must be Point(Distance)"
    return -1
  end if
  return abs(point1.x - point2.x) + 
  abs(point1.y - point2.y)
end function

waterField = function
  //startup combined with this script
  //might create a little freeze so
  //script will wait 2 seconds before starting
  wait 2
  
  previousPoint = new Point
  previousPoint.x = me.position.x
  previousPoint.y = me.position.y
  
  xStart = farm.width
  xEnd = 0
  isFieldInRow = false
  
  for y in range (0, farm.height)
    if isFieldInRow then
      swap = xStart
      xStart = xEnd
      xEnd = swap
    end if
    isFieldInRow = false
    
    for x in range (xStart, xEnd)
      tile = farm.tile(x, y)
      if not isDryCropAtTile(tile) then
        continue
      end if
      
      isFieldInRow = true
      goal = new Point
      goal.x = x
      goal.y = y
      
      if distance(goal, previousPoint) == 1 then
        me.moveToAndWater(x, y)
      else
        path = findPath(previousPoint, goal)
        moveThroughPath(path)
      end if
      
      previousPoint = new Point
      previousPoint = goal
      yield
    end for
    yield
  end for
  
  origin = new Point
  origin.x = me.position.x
  origin.y = me.position.y
  goal = new Point
  goal.x = endPositionX
  goal.y = endPositionY
  path = findPath(origin, goal)
  moveThroughPath(path)
  me.refill
end function

text.clear

main = function
  if me.isBot != 0 then
    print "Bot is starting"
    waterField
  end if
end function

return main