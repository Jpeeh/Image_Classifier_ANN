function formas_3()

%%GUARDAR A REDE NEURONAL PARA SE USAR NA FUNÇÃO ALÍNEA_D.M
close all;
load NN_FORMAS2.mat; %%CARREGA A REDE NEURONAL DA FORMAS_2 COM MELHOR RESULTADO 

d = dir(['C:\Users\Asus\Desktop\ISEC\CR\TP\TemaRN_Imagens\Formas_3' '\' '\**\' '*.png']); %% ->RETORNA TODAS AS IMAGENS PNG DENTRO DA PASTA FORMAS_3
M = zeros(400,200);
i = 1;
for aux = 1 : size(d)
    folder = getfield(d, {aux}, 'folder');  % vai buscar a directoria da pasta
    name = getfield(d, {aux}, 'name');      % dentro da directoria da pasta vai buscar o nome de cada imagem .png
    image = strcat(folder, '\', name);      % Cria/concatena a string relativa à directoria completa de cada imagem
    MW = imbinarize(imread(image));
    R = imresize(MW, 0.1);
    vector = R(:);
    M(:, i) = vector;
    i = i + 1;
end

target = zeros(4,200);
for k = 1:47
   x = zeros(1,4)';
   x(1,1) = 1;
   target(:, k) = x;
end
for k = 48:98
   x = zeros(1,4)';
   x(2,1) = 1;
   target(:, k) = x;
end
for k = 99:149
   x = zeros(1,4)';
   x(3,1) = 1;
   target(:, k) = x;
end
for k = 150:200
   x = zeros(1,4)';
   x(4,1) = 1;
   target(:, k) = x;
end

%{
%% CRIAÇÃO E CONFIGURAÇÃO DA REDE NEURONAL DE 1 CAMADA COM 10 NEURÓNIOS
net = feedforwardnet(10);               %1 camada escondida com 10 neurónios
net.layers{1}.transferFcn = 'tansig';   %INDICAR: Funções de ativação das camadas escondidas e de saida: {'purelin', 'logsig', 'tansig'}
net.layers{2}.transferFcn = 'purelin'; 
net.trainFcn = 'traincgb';               %INDICAR: Função de treino: {'trainlm', 'trainbfg', traingd'}

%% Divisão dos exemplos pelos conjuntos de treino, validação e teste
net.divideFcn = 'dividerand';

%% TREINAR REDE NEURONAL
[net, tr] = train(net, M, target);

%% SIMULAR
out = sim(net, M);

%% VISUALIZAR DESEMPENHO
plotconfusion(target, out)          % Matriz de confusao (não está a conseguir processar a matriz de confusão!)
plotperf(tr)                      % Grafico com o desempenho da rede nos 3 conjuntos 
%}

%% Calcula e mostra a percentagem de classificacoes corretas no total dos exemplos
r=0;
for i=1:size(out,2)                 % Para cada classificacao  
  [a b] = max(out(:,i));            % b guarda a linha onde encontrou valor mais alto da saida obtida
  [c d] = max(target(:,i));         % d guarda a linha onde encontrou valor mais alto da saida desejada
  if b == d                         % se estao na mesma linha, a classificacao foi correta (incrementa 1)
      r = r+1;
  end
end

accuracy = r/size(out,2)*100;
fprintf('Precisao total %f\n', accuracy)


%% SIMULAR A REDE APENAS NO CONJUNTO DE TESTE
TInput = M(:, tr.testInd);
TTargets = target(:, tr.testInd);

out = sim(net, TInput);

%% Calcula e mostra a percentagem de classificacoes corretas no conjunto de teste
r=0;
for i = 1:size(tr.testInd, 2)       % Para cada classificacao  
  [a b] = max(out(:, i));           % b guarda a linha onde encontrou valor mais alto da saida obtida
  [c d] = max(TTargets(:, i));      % d guarda a linha onde encontrou valor mais alto da saida desejada
  if b == d                         % se estao na mesma linha, a classificacao foi correta (incrementa 1)
      r = r+1;
  end
end
accuracy = r/size(tr.testInd,2)*100;
fprintf('Precisao teste %f\n', accuracy)

save NN_FORMAS3;
end

