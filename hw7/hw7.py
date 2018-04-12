import numpy as np
import sklearn.decomposition as sk

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

    docs_readable = ['']*num_docs
    docs_lda = [[]]*num_docs
    for d in range(num_docs):
        doc_lda = [0]*num_words
        doc = ''
        for n in range(doc_length):
            topic_draw = np.random.multinomial(1, theta[d],1)[0]
            topic = topic_draw.argmax()
            word_draw = np.random.multinomial(1, phi[topic],1)[0]
            word = word_draw.argmax()
            doc_lda[word] +=1
            c = word+65
            doc += chr(c)

        docs_readable[d] = doc
        docs_lda[d] = doc_lda

    return theta, phi, docs_readable, docs_lda

def modeling(docs, alpha, beta,num_words,num_topics):
    learning = sk.LatentDirichletAllocation(num_topics,alpha,beta,learning_method='batch',max_iter=5000)
    learning.fit(docs)
    return (learning.transform(docs), learning.components_)


def compute_entropy_topics(docs_topics):
    entropy = 0
    for d in range(len(docs_topics)):
        for t in range(len(docs_topics[d])):
            entropy += docs_topics[d][t]*np.log(docs_topics[d][t])
    entropy /= (-1 *len(docs_topics))
    return entropy

def compute_entropy_words(words_topics):
    entropy = 0
    for t in range(len(words_topics)):
        for w in range(len(words_topics[t])):
            entropy += words_topics[t][w] * np.log(words_topics[t][w])
    entropy /= (-1*len(words_topics))
    return entropy


if __name__ == '__main__':
    theta,phi,docs, docs_matrix = generate_docs(.1, .01, 200, 20, 3,50)
    #print(phi)
    docs_topics, components =modeling(docs_matrix,.1,.01,20,3)
    word_probs = []
    for i in range(len(components)):
        word_probs.append(components[i]/np.sum(components[i]))

    print('Doc Examples')
    for d in docs:
        print(d)

    print('Actual Topic Probs')
    for t in range(3):
        print('Topic '+str(t)+' probs')
        for w in range(20):
            print (chr(w+65)+' \t'+str(phi[t][w]))
        print('\n')
    print('--------------------------------------------------')
    print('LDA Topic Probs')
    for t in range(3):
        print('Topic '+str(t)+' probs')
        for w in range(20):
            print (chr(w+65)+' \t'+str(word_probs[t][w]))
        print('\n')
    print('--------------------------------------------------')


    alphas = [.1,.2,.5,1]
    betas = [.01,.02,.05,.1]

    topic_entropy = []
    for a in alphas:
        docs_topics, components =modeling(docs_matrix,a,.01,20,3)
        topic_entropy.append(compute_entropy_topics(docs_topics))

    word_entropy = []
    for b in betas:
        docs_topics, components =modeling(docs_matrix,.1,b,20,3)
        word_probs = []
        for i in range(len(components)):
            word_probs.append(components[i]/np.sum(components[i]))
        word_entropy.append(compute_entropy_words(word_probs))

    print('Here are the topic entropys')
    print(topic_entropy)
    print('Here are the world entropys')
    print(word_entropy)
