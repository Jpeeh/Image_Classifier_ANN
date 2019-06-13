function classifica_imagem( input , net)
%recebe a directoria da imagem carregada pelo utilizador e a rede neuronal 

MB = imbinarize(imread(input));  % l�-se a imagem e binaria-a para uma matriz
R = imresize(MB, 0.1);
vector = R(:);

target = zeros(4,1028);
for k = 1 : 260
   x = zeros(1,4)';
   x(1,1) = 1;
   target(:, k) = x;
end
for k = 261 : 516
    x = zeros(1,4)';
    x(2,1) = 1;
   target(:, k) = x;
end
for k = 517 : 772
   x = zeros(1,4)';
   x(3,1) = 1;
   target(:, k) = x;
end
for k = 773 : 1028
   x = zeros(1,4)';
   x(4,1) = 1;
   target(:, k) = x;
end

%% CONFIGURA��O DA REDE NEURONAL DE 1 CAMADA COM 10 NEUR�NIOS
if (isempty(net))
net = feedforwardnet(10); 
net.layers{1}.transferFcn = 'tansig'; 
net.layers{2}.transferFcn = 'purelin'; 
net.trainFcn = 'trainlm';
net.divideFcn = ''; %CONFIGURA��O DEFAULT
end
net.inputs{1}.size = 400; 

% SIMULAR
out = sim(net, vector);

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
end

