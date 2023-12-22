list.reverse = function()
  if not self then return self
  
  for i in range(0, self.len/2 - 1)
    negi = -1 - i
    temp = self[negi]
    self[negi] = self[i]
    self[i] = temp
  end for
  return self
end function

return list