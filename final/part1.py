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
block7 = multivariate_normal([0.4,0.2], uncertainty)

robot_position = [0,0]
robot_reach = 1
position_of_agent = [5,3]

blocks = [block1,block2,block3,block4,block5,block6,block7]

table_x_edges = [-.8,.8]
table_y_edges = [.0,.7]
edge_buffer = .05
edge_penalty = 20
edge_weight = -5
pdf_weight = -10
agent_distance_weight = -0.5

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
    distance_to_agent = dist([x,y],position_of_agent)
    return edge_weight*edge + pdf_weight*pdf + agent_distance_weight*(distance_to_agent**2)

def noisy_placement(x,y):
    return placement(x, y) + np.random.normal(0,scale=2)
def main():
    """Run the demo."""
    # grab a test function
    #
    # table_corners=[-.8,0,.8,.7]
    # #
    # X = np.linspace(table_corners[0],table_corners[2],num=200)
    # Y = np.linspace(table_corners[1],table_corners[3],num=200)
    # max_value = (-100,10,10)
    # for x in range(len(X)):
    #     for y in range(len(Y)):
    #         value = placement(X[x], Y[y])
    #         if value>max_value[0]:
    #             max_value = (value,X[x],Y[y])
    # print(max_value)
    # plt.contourf(X,Y,F)
    # plt.colorbar()
    # plt.show()


    boundaries=[-.8,0,.8,.7]
    bo = BayesianOptimization(noisy_placement, {'x':(boundaries[0],boundaries[2]),'y':(boundaries[1],boundaries[3])})
    bo.maximize(init_points=5,n_iter=1,kappa=5)
    print(bo.res['max'])
    best = bo.res['max']
    true_opt = (-13.1036,.7437,.3025)
    while  dist([best['max_params']['x'],best['max_params']['y']],[true_opt[1],true_opt[2]])>.1:
        bo.maximize(init_points=0,n_iter=1,kappa=5)
        best = bo.res['max']
        if best['max_val']>true_opt[0]:
            print('found a value higher than true opt')

    # plot the final model


if __name__ == '__main__':
    main()
