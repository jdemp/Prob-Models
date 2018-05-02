import numpy as np


from bayes_opt import BayesianOptimization
from scipy.stats import multivariate_normal
import matplotlib.pyplot as plt

var1 = multivariate_normal(mean=[0,0], cov=[[1,0],[0,1]])
var2 = multivariate_normal(mean=[2,3], cov=[[2,0],[0,1.5]])
var3 = multivariate_normal(mean=[-5,-3], cov=[[5,0],[0,5]])
var4 = multivariate_normal(mean=[4,4], cov=[[3,0],[0,1]])
var5 = multivariate_normal(mean=[1,-1], cov=[[1.5,0],[0,4]])

def fun(x,y):
    return 10*(var1.pdf([x,y])+var2.pdf([x,y])+var3.pdf([x,y])+var4.pdf([x,y])+var5.pdf([x,y]))

def noisy_fun(x,y):
    f = fun(x, y)
    return f + np.random.normal(0,.1)

def main():
    """Run the demo."""
    # grab a test function
    bo = BayesianOptimization(fun, {'x':(-10,10),'y':(-10,10)})
    bo.maximize(init_points=5,n_iter=25,kappa=2.576)
    print(bo.res['max'])

    # plot the final model


if __name__ == '__main__':
    X = np.linspace(-10,10,num=100)
    Y = np.linspace(-10,10,num=100)
    F = np.zeros((100,100))
    for x in range(len(X)):
        for y in range(len(Y)):
            F[x][y] = fun(X[x],Y[y])

    main()
    plt.contourf(X,Y,F)
    plt.show()
