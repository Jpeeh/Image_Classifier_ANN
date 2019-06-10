function classifica_imagem( input , net)
%recebe a directoria da imagem carregada pelo utilizador

MB = imread(input);  % lê-se a imagem e binaria-a para uma matriz
R = imresize(MB, 0.1);
vector = R(:);



%% CONFIGURAÇÃO DA REDE NEURONAL DE 1 CAMADA COM 10 NEURÓNIOS
if (isempty(net))
net = feedforwardnet(10); 
net.layers{1}.transferFcn = 'tansig'; 
net.layers{2}.transferFcn = 'purelin'; 
net.trainFcn = 'trainlm';
net.divideFcn = ''; %CONFIGURAÇÃO DEFAULT
end

%TREINAR REDE NEURONAL
[net, tr] = train(net, vector, target);
disp(tr)

% SIMULAR
out = sim(net, vector);

%VISUALIZAR DESEMPENHO
%plotconfusion(target, out) % Matriz de confusao
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
TInput = vector(:, tr.testInd);
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

