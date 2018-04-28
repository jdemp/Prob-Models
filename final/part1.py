import numpy as np


def grid(x,y):
    obj_positions = [(1,1),(-2,5),(10,-10),(-7,-3)]
    for x1,y1 in obj_positions:
        print(x1,y1)


if __name__ == '__main__':
    grid(1,1)
