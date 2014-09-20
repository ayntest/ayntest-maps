#!/usr/bin/env python3
import sys
from shutil import move

# parse command-line arguments
image_size = int(sys.argv[1])
tile_size = int(sys.argv[2])
path = str(sys.argv[3])

max_columns = int(image_size/tile_size)
total_tiles = int(max_columns**2)

column = 0
row = 0
for i in range(total_tiles):
    filename = "{}/tiles_{}.png".format(path, i)
    target = "{}/map_{}_{}.png".format(path, column, row)

#    print("copying " + filename + " to " + target)
    move(filename, target)

    column += 1
    if column >= max_columns:
        column = 0
        row +=1
