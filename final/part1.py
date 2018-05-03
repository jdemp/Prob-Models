import numpy as np


from bayes_opt import BayesianOptimization
from scipy.stats import multivariate_normal
import matplotlib.pyplot as plt

uncertainty = [[0.01,0],[0,0.01]]

block1 = multivariate_normal([0.1,0.5], uncertainty)
block2 = multivariate_normal([-0.6,0.3], uncertainty)
block3 = multivariate_normal([0.5,0.6], uncertainty)
block4 = multivariate_normal([-0.2,0.1], uncertainty)
block5 = multivariate_normal([0.7,0.7], uncertainty)
block6 = multivariate_normal([-0.4,0.6], uncertainty)

robot_position = [0,0]
robot_reach = 1

blocks = [block1,block2,block3,block4,block5,block6]

table_x_edges = [-.8,.8]
table_y_edges = [.0,.7]
edge_buffer = .05
edge_penalty = 20
edge_weight = -5
pdf_weight = -10

def dist(x1,x2):
    return np.sqrt((x1[0]-x2[0])**2 + (x1[1]-x2[1])**2)

def total_edge_penalty(x,y):
    edge = 0
    for e_x in table_x_edges:
        d = np.abs(e_x-x)
        if d<edge_buffer:
            edge+=edge_penalty
    for e_y in table_y_edges:
        d = np.abs(e_y-y)
        if d<edge_buffer:
            edge+=edge_penalty
    return edge

def placement(x,y):
    #check if reachable
    if dist([x,y], robot_position)>robot_reach:
        return -100
    #build pdf of objects
    pdf = 0
    for block in blocks:
        #in the actual program this is repalced by weights for objects
        pdf+=block.pdf([x,y])
    #penalty for nearness to edges
    edge = total_edge_penalty(x,y)
    return edge_weight*edge+pdf_weight*pdf

def noisy_placement(x,y):
    return placement(x, y) + np.random.normal(0,scale=1.0)
def main():
    """Run the demo."""
    # grab a test function

    table_corners=[-1,-1,1,1]

    X = np.linspace(table_corners[2],table_corners[0],num=100)
    Y = np.linspace(table_corners[1],table_corners[3],num=100)
    F = np.zeros((100,100))
    max_placement = (-100,3,3)
    for x in range(len(X)):
        for y in range(len(Y)):
            F[y][x] = placement(X[x],Y[y])
            if F[x][y]>max_placement[0]:
                max_placement = (F[x][y],x,y)
    plt.contourf(X,Y,F)
    plt.show()


    boundaries=[-.8,0,.8,.7]
    bo = BayesianOptimization(noisy_placement, {'x':(boundaries[0],boundaries[2]),'y':(boundaries[1],boundaries[3])})
    bo.maximize(init_points=10,n_iter=25,kappa=2.576)
    print(bo.res['max'])

    # plot the final model


if __name__ == '__main__':
    main()
