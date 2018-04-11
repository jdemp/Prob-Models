import numpy as np


def generate_docs(alpha,beta,num_docs,num_words,num_topics,doc_length):
    a = np.full((1,num_topics), alpha)[0]
    theta = []
    for i in range(num_docs):
        t = np.random.dirichlet(a)
        theta.append(t/np.sum(t))

    b = np.full((1,num_words), beta)[0]
    phi = []
    for k in range(num_topics):
        p = np.random.dirichlet(b)
        phi.append(p/np.sum(p))

    docs = [[]]*num_docs
    for d in range(num_docs):
        doc = [0]*doc_length
        for n in range(doc_length):
            topic_draw = np.random.multinomial(1, theta[d],1)[0]
            topic = topic_draw.argmax()
            word_draw = np.random.multinomial(1, phi[topic],1)[0]
            doc[n] = word_draw.argmax()
        docs[d]=doc

    return docs


if __name__ == '__main__':
    docs = generate_docs(.1, .01, 200, 20, 3,50)
    
