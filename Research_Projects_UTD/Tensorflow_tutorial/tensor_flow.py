gpu_options = tf.GPUOptions(per_process_gpu_memory_fraction=0.333)

sess = tf.InteractiveSession(gpu_options=gpu_options)

import tensorflow as tf
import numpy as np

import edward as ed
import numpy as np
import tensorflow as tf

from edward.models import Normal
from edward.util import rbf


from edward.models import Bernoulli

gpu_options = tf.GPUOptions(per_process_gpu_memory_fraction=0.333)

sess = tf.InteractiveSession(gpu_options=gpu_options)

x = Bernoulli(p=[0.495, 0.490])

N = 10000
observed = x.sample(N).eval(session=sess)


mu = tf.Variable(tf.random_normal((2,),0.,1.))
sigma = tf.Variable(tf.ones((2,)))

theta = Normal(mu=[0.,0.], sigma=[1. , 1.])
q_theta = Normal(mu=mu, sigma=tf.exp(sigma))

x_hat = Bernoulli(p=tf.ones((N,2))*tf.nn.sigmoid(theta))
inference = ed.KLqp({theta:q_theta}, data={x_hat:observed})



inference.run()

%matplotlib inline
from matplotlib import pyplot as pl
smpls = tf.nn.sigmoid(q_theta.sample(10000)).eval()
d = pl.hist(smpls[:,0], bins=100, color='r', alpha=0.2)
d = pl.hist(smpls[:,1], bins=100, color='g', alpha=0.2)

