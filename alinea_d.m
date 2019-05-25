function alinea_d()

close all;
%CARREGAR A REDE NEURONAL USADA NA FUNÇÃO FORMAS_3.M

%% CARREGAR AS IMAGENS DA PASTA FORMAS_4
[file, path] = uigetfile('C:\Users\Asus\Desktop\ISEC\CR\TP\TemaRN_Imagens\Formas_4\*.png');

M = zeros(400,1); % 400 linhas (matriz de 20x20, cada imagem) por 4 colunas/imagens na pasta Formas_1

MB = imbinarize(imread(strcat(path,file)));   % lê a image do datastore criado em cima e "binariza" a imagem lida
R = imresize(MB , 0.1); % redimensionamento da imagem binária, com 0.1 de escala, (a imagem fica 20x20)
vector = R(:);
M(:, 1) = vector;       % cada coluna da matriz M fica com uma imagem .png

target = zeros(4); % criar matriz de zeros 4x4 (4 classes por cada imagem, neste caso são só 4 imagens)
target(:,1) = [1 0 0 0]';
target(:,2) = [0 1 0 0]';
target(:,3) = [0 0 1 0]';
target(:,4) = [0 0 0 1]';

aux = load ('NN_FORMAS2.mat');
net = feedforwardnet;

net.numInputs = aux.net.numInputs;
net.numLayers = aux.net.numLayers;
net.trainFcn = aux.net.trainFcn;

net.divideFcn = aux.net.divideFcn;

out = sim(net, M);
plotconfusion(target, out);
end

