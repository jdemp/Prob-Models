import tensorflow as tf
import edward as ed
import numpy as np

G1 = ed.models.Categorical(probs=[0.5,0.5])

p_next = tf.where(tf.cast(G1,tf.bool),[0.9,0.1],[.1,.9])

G2 = ed.models.Categorical(probs=p_next)
G3 = ed.models.Categorical(probs=p_next)

mean_x2 = tf.where(tf.cast(G2,tf.bool),50.,60.)
mean_x3 = tf.where(tf.cast(G3,tf.bool),50.,60.)
sig = np.float32(np.sqrt(10))
X2 = ed.models.Normal(loc=mean_x2,scale=sig)
X3 = ed.models.Normal(loc=mean_x3,scale=sig)

g1_2 = ed.complete_conditional(G1)

sess = tf.Session()

sess.run(g1_2,{X2:np.array([50],dtype=np.float64)})
