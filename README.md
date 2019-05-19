# Image_Classifier_ANN

### Artificial Neural Network for classifying images of 4 shapes (triangle, star, circle and square), implemented in Matlab with GUIDE   (Matlab's GUI).

The images are splitted by 4 folders.
 - The first folder (Formas_1) has 4 images of each shape;
 - The second folder (Formas_2) has 201 images of each shape;
 - The third folder (Formas_3) has 50 images of each shape;
 - And the last folder (Formas_4) has 5 images of each shape;


### GUI explanation:
  - **_Nº de Neurónio_** - how many neuros by layer do you want to be in your Neural Network (it's splitted by blank spaces or commas);
  - **_Funções de activação_** - write the activation functions for your neural network, you have to write the number of layers plus one activation functions;
  - **_Função de transferência_** - choose your training function, only one can be written.
  
  - **_Treinar Rede_ Button** - a push button to start training the neural network with the options above described;
  - **_Carregar Rede_ Button** - a push button that can load a previously trained neural network;
  - **_Guardar Rede_ Button** - a push button that saves the neural network.
  
  After you train your network it will take some time to deploy the training plot, the perfomance plot and finally the confusion matrix plot where you can see the results of the training.
