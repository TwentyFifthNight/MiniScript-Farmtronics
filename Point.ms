Point = {"x":0, "y":0, "f":0, "g":0, "parent": {}}

Point.calculateF = function(parent, goal)
  h = abs(self.x - goal.x) + abs(self.y - goal.y)
  self.g = parent.g + 1
  self.f = h + self.g
end function

Point.getNeighbours = function
  left = new Point
  left.x = self.x - 1
  left.y = self.y
  
  down = new Point
  down.x = self.x
  down.y = self.y - 1
  
  right = new Point
  right.x = self.x + 1
  right.y = self.y
  
  up = new Point
  up.x = self.x
  up.y = self.y + 1
  return [left, up, right, down]
end function

return Point