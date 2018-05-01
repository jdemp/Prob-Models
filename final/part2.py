import numpy as np
import matplotlib.pyplot as plt

def system(steps,a1,a2,sigma):
    y1 = 0
    y2 = 0
    Y = [(y1,y2)]

    for i in range(steps):
        y2 = Y[i][0] + np.random.normal(0,sigma)
        y1 = a1*Y[i][0] + a2*Y[i][1] + np.random.normal(0,sigma)
        Y.append((y1,y2))
    Z = []
    for y,_ in Y:
        z = y + np.random.normal(0,sigma)
        Z.append(z)
    return Z,Y

def switched_system(steps,m,b,sigma):
    y1 = 0
    y2 = 0
    Y = [(y1,y2)]
    mode = np.random.choice(3)
    for i in range(steps):
        switch = np.random.binomial(1, b)
        if switch:
            mode = np.random.choice(3)
        a1 = m[mode][0]
        a2 = m[mode][1]
        y2 = Y[i][0] + np.random.normal(0,sigma)
        y1 = a1*Y[i][0] + a2*Y[i][1] + np.random.normal(0,sigma)
        Y.append((y1,y2))
    Z = []
    for y,_ in Y:
        z = y + np.random.normal(0,sigma)
        Z.append(z)
    return Z,Y

def kalman_filter(measurements,a1,a2):
    X = []
    F = np.matrix([[a1,a2],[1,0]])
    F_t = np.transpose(F)
    x = np.matrix([[0],[0]])
    X.append(x)
    P = np.matrix([[.2,0],[0,.2]])
    P_hist = []
    P_hist.append(P)
    H = np.matrix([1,0])
    H_t = np.transpose(H)
    R = np.matrix([.2])
    I = np.matrix([[1 ,0],[0 ,1]])
    Q = np.matrix([[10 0],[0 10]])
    for m in measurements[1:]:
        y = np.matrix([m])
        #predict
        x_pred = np.matmul(F, x)
        P_pred = np.matmul(np.matmul(F,P), F_t) + Q

        #update
        K = P_pred*H_t*np.linalg.inv(H*P_pred*H_t+R)
        x = x_pred + K*(y-H*x_pred)
        X.append(x)
        P = (I-K*H)*P_pred
        P_hist.append(P)
        #print(P)
    return X,P


if __name__ == '__main__':
    Z,Y = system(100,-.5,.5,.1)
    X,P = kalman_filter(Z, -.9, .5)
    # plot point
    #Z,Y = switched_system(100, [[.1,-.2], [-.2,.1], [.5,-.3]], .1, .1)
    for y in Y:
        print(y)
    for x in X:
        print(x)
