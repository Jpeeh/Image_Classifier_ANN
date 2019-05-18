function alinea_d()

close all;
%CARREGAR A REDE NEURONAL USADA NA FUNÇÃO FORMAS_3.M

%% CARREGAR AS IMAGENS DA PASTA FORMAS_4
location = 'TemaRN_Imagens/Formas_4/*.png';
datastore = imageDatastore(location); % Creates a datastore for all images in your folder
M = zeros(400,20); % 400 linhas (matriz de 20x20, cada imagem) por 4 colunas/imagens na pasta Formas_1
i = 1;
while hasdata(datastore)
    MB = imbinarize(read(datastore));   % lê a image do datastore criado em cima e "binariza" a imagem lida
    R = imresize(MB , 0.1); % redimensionamento da imagem binária, com 0.1 de escala, (a imagem fica 20x20)
    vector = R(:);
    M(:, i) = vector;       % cada coluna da matriz M fica com uma imagem .png
    i = i + 1;
    %figure, imshow(img);     figure and imshow -> creates a new window for each image
    %disp(R);               apresenta as matrizes binárias redimensionadas
end

target = zeros(4,20); % criar matriz de zeros 4x20 (4 classes por cada imagem, neste caso são só 20 imagens)
for k = 1:5
    target(:,k) = [1 0 0 0]';
end
for k = 6:10
    target(:,k) = [0 1 0 0]';
end
for k = 11:15
    target(:,k) = [0 0 1 0]';
end
for k = 16:20
    target(:,k) = [0 0 0 1]';
end

end

