import pandas as pd
import numpy as np
from numpy.random import seed
from keras.callbacks import History 
from tqdm import tqdm
from keras.models import Sequential
from keras.layers import Dense, Dropout
from tensorflow.keras import regularizers
from sklearn.model_selection import train_test_split
import tensorflow as tf

import matplotlib.pyplot as plt
from sklearn.utils import shuffle
from sklearn.decomposition import PCA

tf.config.threading.set_intra_op_parallelism_threads(1)
tf.config.threading.set_inter_op_parallelism_threads(1)

data = pd.read_csv("Training_data_CCLE_GDSC.csv")

x = data.drop(['Z_SCORE'], axis = 1)
y = data['Z_SCORE']
x_train, x_test, y_train, y_test = train_test_split(x, y, test_size = 0.2, random_state = 123)


def model_train(x,y,model, i):
    history = History()
    model.fit(x, y, epochs = 500, verbose = 2, validation_split = 0.3, batch_size = 50, shuffle=True, callbacks=[history])
    model.save('Model{}.hdf5'.format(i+1))
    plt.plot(history.history['loss'])
    plt.plot(history.history['val_loss'])
    plt.title('model loss')
    plt.ylabel('loss')
    plt.xlabel('epoch')
    plt.legend(['train', 'test'], loc='upper left')
    plt.savefig('_All_Lossess_history_gsva_based{}.png'.format(i+1))

    
    
for i in range(10):
    model = Sequential()
    model.add(Dense(1429, input_dim = 1429, kernel_initializer = 'normal', activation = 'relu'))
    model.add(Dropout(0.2))
    model.add(Dense(512, kernel_initializer = 'normal', activation = 'relu'))
    model.add(Dropout(0.2))
    model.add(Dense(64, kernel_initializer = 'normal', activation = 'relu'))
    model.add(Dense(1, kernel_initializer = 'normal'))
    model.compile(loss='mean_squared_error', optimizer='adam')
    x_train, y_train = shuffle(x_train, y_train, random_state=i)
    model_train(x_train,y_train,model, i+1)
    
