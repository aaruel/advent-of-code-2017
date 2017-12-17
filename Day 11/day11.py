# Help from here
# https://www.redblobgames.com/grids/hexagons/#coordinates
import functools
path = input().split(",")
distance = lambda x, y: (abs(x) + abs(y) + abs(x+y))/2
move = {
  "n": lambda p: {"x": p["x"], "y": p["y"]+1},
  "ne": lambda p: {"x": p["x"]+1, "y": p["y"]},
  "se": lambda p: {"x": p["x"]+1, "y": p["y"]-1},
  "s": lambda p: {"x": p["x"], "y": p["y"]-1},
  "sw": lambda p: {"x": p["x"]-1, "y": p["y"]},
  "nw": lambda p: {"x": p["x"]-1, "y": p["y"]+1},
}
def part2(key, value):
  newpos = move[key](value)
  x = value["x"]
  y = value["y"]
  nx = newpos["x"]
  ny = newpos["y"]
  ndist = distance(nx, ny)
  odist = value["hdist"]
  if ndist > odist:
    return {"x": nx, "y": ny, "hdist": ndist}
  else:
    return {"x": nx, "y": ny, "hdist": odist}
  
xy = functools.reduce(lambda x, y: part2(y, x), path, {"x": 0, "y": 0, "hdist": 0})

print(distance(xy["x"], xy["y"]))
print(xy)