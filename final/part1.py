import numpy as np


from bayes_opt import BayesianOptimization
from scipy.stats import multivariate_normal
import matplotlib.pyplot as plt
from sklearn.gaussian_process.kernels import RationalQuadratic, Matern

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

def posterior(bo, x):
    bo.gp.fit(bo.X, bo.Y)
    mu, sigma = bo.gp.predict(x, return_std=True)
    return mu, sigma

def loss(real_mu,predicted_mu):
    return real_mu-predicted_mu



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
    predicted_max={'ucb_matern':[],'poi_matern':[],'ucb_rq':[],'poi_rq':[]}
    sigmas={'ucb_matern':[],'poi_matern':[],'ucb_rq':[],'poi_rq':[]}
    dist_to_best={'ucb_matern':[],'poi_matern':[],'ucb_rq':[],'poi_rq':[]}

    boundaries=[-.8,0,.8,.7]
    ucb_matern = BayesianOptimization(noisy_placement, {'x':(boundaries[0],boundaries[2]),'y':(boundaries[1],boundaries[3])})
    poi_matern = BayesianOptimization(noisy_placement, {'x':(boundaries[0],boundaries[2]),'y':(boundaries[1],boundaries[3])})
    ucb_rq = BayesianOptimization(noisy_placement, {'x':(boundaries[0],boundaries[2]),'y':(boundaries[1],boundaries[3])})
    poi_rq = BayesianOptimization(noisy_placement, {'x':(boundaries[0],boundaries[2]),'y':(boundaries[1],boundaries[3])})
    ucb = {'kernel':RationalQuadratic()}
    poi = {'kernel':RationalQuadratic()}


    ucb_matern.maximize(init_points=5,n_iter=0,acq='ucb')
    poi_matern.maximize(init_points=5,n_iter=0,acq='poi')
    ucb_rq.maximize(init_points=5,n_iter=0,acq='ucb',**ucb)
    poi_rq.maximize(init_points=5,n_iter=0,acq='poi',**poi)
    opt_point = [.7437,.3025]
    opt_value = -13.1036

    for i in range(25):
        ucb_matern.maximize(init_points=0,n_iter=1,acq='ucb')
        poi_matern.maximize(init_points=0,n_iter=1,acq='poi')
        ucb_rq.maximize(init_points=0,n_iter=1,acq='ucb',**ucb)
        poi_rq.maximize(init_points=0,n_iter=1,acq='poi',**poi)

        best = ucb_matern.res['max']
        d = dist(opt_point,[best['max_params']['x'],best['max_params']['y']])
        point = np.array([[best['max_params']['x']],[best['max_params']['y']]]).reshape(1,2)
        predicted_max['ucb_matern'].append(-1*best['max_val'])
        dist_to_best['ucb_matern'].append(d)

        best = poi_matern.res['max']
        d = dist(opt_point,[best['max_params']['x'],best['max_params']['y']])
        point = np.array([[best['max_params']['x']],[best['max_params']['y']]]).reshape(1,2)
        predicted_max['poi_matern'].append(-1*best['max_val'])
        dist_to_best['poi_matern'].append(d)
        #
        best = ucb_rq.res['max']
        d = dist(opt_point,[best['max_params']['x'],best['max_params']['y']])
        point = np.array([[best['max_params']['x']],[best['max_params']['y']]]).reshape(1,2)
        predicted_max['ucb_rq'].append(-1*best['max_val'])
        dist_to_best['ucb_rq'].append(d)
        #
        best = poi_rq.res['max']
        d = dist(opt_point,[best['max_params']['x'],best['max_params']['y']])
        point = np.array([[best['max_params']['x']],[best['max_params']['y']]]).reshape(1,2)
        predicted_max['poi_rq'].append(-1*best['max_val'])
        dist_to_best['poi_rq'].append(d)

    t = list(range(1,26))
    plt.figure(1)
    plt.plot(t,predicted_max['ucb_matern'],'r',t,predicted_max['poi_matern'],'g',t,predicted_max['ucb_rq'],'b',t,predicted_max['poi_rq'],'y')
    plt.axhline(y=-1*opt_value, color='m', linestyle='-')
    plt.figure(2)
    plt.plot(t,dist_to_best['ucb_matern'],'r',t,dist_to_best['poi_matern'],'g',t,dist_to_best['ucb_rq'],'b',t,dist_to_best['poi_rq'],'y')
    plt.show()

    # plot the final model


if __name__ == '__main__':
    main()
