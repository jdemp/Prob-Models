import tensorflow as tf
import edward as ed
import numpy as np

G1 = ed.models.Bernoulli(probs=.5)

p_nextg2 = tf.where(tf.cast(G1,tf.bool),0.9,0.1)
p_nextg3 = tf.where(tf.cast(G1,tf.bool),0.9,0.1)

G2 = ed.models.Bernoulli(probs=p_nextg2)
G3 = ed.models.Bernoulli(probs=p_nextg3)

mean_x2 = tf.where(tf.cast(G2,tf.bool),60.,50.)
mean_x3 = tf.where(tf.cast(G3,tf.bool),60.,50.)
sig = np.float32(np.sqrt(10))
X2 = ed.models.Normal(loc=mean_x2,scale=sig)
X3 = ed.models.Normal(loc=mean_x3,scale=sig)


### run for prob(g1=2|x2=50)
# I treaat 2==1 and 1==0
#part1 = ed.models.Bernoulli(probs=tf.nn.sigmoid(tf.Variable(tf.random_normal([]))))
#ed.get_session()
#inf = ed.KLpq({G1:part1},data={X2:tf.constant(50,dtype=tf.float32)})

#inf.run(n_samples=200)
#print(part1.probs.eval())


### run for prob(x3=50|x2=50)
ed.get_session()
cond = ed.complete_conditional(X3,{X2:tf.constant(50,dtype=tf.float32)})
probs = 0
for _ in range(100000):
    s = round(cond.eval())
    if s==50:
        probs += 1
probs = probs/100000
print(probs)
