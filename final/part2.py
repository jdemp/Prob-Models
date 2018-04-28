import numpy as np

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

def kalman_filter(measurements):
    states = [(0,0)]
    
    for m in measurements:
        pass


def particle_filter(measurements):
    pass


if __name__ == '__main__':
    Z,Y = system(100,-.1,.1,.1)
    # plot point
    Z,Y = switched_system(100, [[.1,-.2], [-.2,.1], [.5,-.3]], .1, .1)
    print(Z)
