function formas_1()

close all;

%% CARREGAR AS IMAGENS DA PASTA FORMAS_1
location = 'TemaRN_Imagens/Formas_1/*.png';
datastore = imageDatastore(location); % Creates a datastore for all images in your folder
M = zeros(400,4); % 400 linhas (matriz de 20x20, cada imagem) por 4 colunas/imagens na pasta Formas_1
i = 1;
while hasdata(datastore)
    BW = imbinarize(read(datastore));   % lê a image do datastore criado em cima e "binariza" a imagem lida
    R = imresize(BW , 0.1); % redimensionamento da imagem binária, com 0.1 de escala, (a imagem fica 20x20)
    vector = R(:);
    M(:, i) = vector;       % cada coluna da matriz M fica com uma imagem .png
    i = i + 1;
    %figure, imshow(img);     figure and imshow -> creates a new window for each image
    %disp(R);               apresenta as matrizes binárias redimensionadas
end

target = zeros(4); % criar matriz de zeros 4x4 (4 classes por cada imagem, neste caso são só 4 imagens)
target(:,1) = [1 0 0 0]';
target(:,2) = [0 1 0 0]';
target(:,3) = [0 0 1 0]';
target(:,4) = [0 0 0 1]';

%% CRIAÇÃO E CONFIGURAÇÃO DA REDE NEURONAL DE 1 CAMADA COM 10 NEURÓNIOS
net = feedforwardnet(10); % 1 camada escondida com 10 neurónios
net.layers{1}.transferFcn = 'tansig';   %INDICAR: Funções de ativação das camadas escondidas e de saida: {'purelin', 'logsig', 'tansig'}
net.layers{2}.transferFcn = 'purelin';   %INDICAR: Funções de ativação das camadas escondidas e de saida: {'purelin', 'logsig', 'tansig'}
net.trainFcn = 'trainlm';               %INDICAR: Função de treino: {'trainlm', 'trainbfg', traingd'}
%A FUNÇÃO 'traingd' PARECE SER A MELHOR FUNÇÃO DE ACTIVAÇÃO DAS 3 DE CIMA!

% COMPLETAR A RESTANTE CONFIGURACAO -   Divisão dos exemplos pelos conjuntos de treino, validação e teste
net.divideFcn = ''; %CONFIGURAÇÃO DEFAULT

%TREINAR REDE NEURONAL
[net, tr] = train(net, M, target);
disp(tr);

% SIMULAR
out = sim(net, M);

%VISUALIZAR DESEMPENHO
plotconfusion(target, out) % Matriz de confusao
plotperf(tr)         % Grafico com o desempenho da rede nos 3 conjuntos 

%Calcula e mostra a percentagem de classificacoes corretas no total dos exemplos
r=0;
for i=1:size(out,2)               % Para cada classificacao  
  [a b] = max(out(:,i));          %b guarda a linha onde encontrou valor mais alto da saida obtida
  [c d] = max(target(:,i));  %d guarda a linha onde encontrou valor mais alto da saida desejada
  if b == d                       % se estao na mesma linha, a classificacao foi correta (incrementa 1)
      r = r+1;
  end
end

accuracy = r/size(out,2)*100;
fprintf('Precisao total %f\n', accuracy)


% SIMULAR A REDE APENAS NO CONJUNTO DE TESTE
TInput = M(:, tr.testInd);
TTargets = target(:, tr.testInd);

out = sim(net, TInput);

%Calcula e mostra a percentagem de classificacoes corretas no conjunto de teste
r=0;
for i = 1:size(tr.testInd, 2)               % Para cada classificacao  
  [a b] = max(out(:, i));          %b guarda a linha onde encontrou valor mais alto da saida obtida
  [c d] = max(TTargets(:, i));  %d guarda a linha onde encontrou valor mais alto da saida desejada
  if b == d                       % se estao na mesma linha, a classificacao foi correta (incrementa 1)
      r = r+1;
  end
end
accuracy = r/size(tr.testInd,2)*100;
fprintf('Precisao teste %f\n', accuracy)
end

