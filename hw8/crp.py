import numpy as np

def crp(customers,a):
    K = 1
    tables = [1]

    for n in range(2,customers+1):
        probs = [0]*K
        for k in range(len(probs)):
            probs[k]=tables[k]/(n-1+a)
        p_new = a/(n-1+a)
        probs.append(p_new)
        probs = probs/np.sum(probs)
        seat = np.random.multinomial(1, probs)
        table = seat.argmax()
        if table == K:
            K+=1
            tables.append(1)
        else:
            tables[table]+=1

def crp_dpmm(points,a,o):
    K = 1
    tables = [1]
    X = np.random.random_sample(1)[0]
    Y = np.random.random_sample(1)[0]
    G = [(X,Y)]
    s = [np.random.normal(G[0],(o,o))]
    samples = [s]

    for n in range(2,points+1):
        probs = [0]*K
        for k in range(len(probs)):
            probs[k]=tables[k]/(n-1+a)
        p_new = a/(n-1+a)
        probs.append(p_new)
        probs = probs/np.sum(probs)
        seat = np.random.multinomial(1, probs)
        table = seat.argmax()
        if table == K:
            K+=1
            tables.append(1)
            X = np.random.random_sample(1)[0]
            Y = np.random.random_sample(1)[0]
            G.append((X,Y))
            s = [np.random.normal((X,Y),(o,o))]
            samples.append(s)
        else:
            tables[table]+=1
            s = np.random.normal(G[table],(o,o))
            samples[table].append(s)

    print(samples)
    print(tables)
    print(G)

if __name__ == '__main__':
    #crp(500, .5)
    crp_dpmm(5000, .5, .1)
