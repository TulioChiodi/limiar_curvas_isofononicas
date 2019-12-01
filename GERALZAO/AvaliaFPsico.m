%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Rotina para fazer a avaliação de função psicométrica
%
% Desenvolvido pelo professor da Engenharia Acústica da UFSM:
%    William D'Andrea Fonseca, Dr. Eng.
%
% Atualização: 19/11/2017
% Compatible with itaToolbox and Matlab R2016b
%
%%%% O que FAZER?
% 0. Inicie o ITAToolbox.
% 1. Carregar sinal.
% 2. Configurar a constante de amplificação "CteAmp".
% 2.1 AJUSTE O VALOR DO VOLUME DO SISTEMA PARA ESCUTAR NA BANDA DE 1 kHz EM
% CERCA DE 30 SEGUNDOS.
% 3. Configurar coeficiente de subida P.NPS se necessário.
% 4. Calibrar "timePause" e "timeDummy" se necessário.
% 5. Calibrar o valor de referência com a cabeça artificial (preferível com 2 kHz).
% 6. Fazer o ensaio.
% 7. Pegar tempos e amplitudes e montar of gráficos de função psicométrica.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Observações
% a. Se na subida o voluntário não apertar o botão, haverá um silêncio
% adicional de duração "timeDummy" em eu ele ainda pode apertar.
% b. Se na descida o voluntário não apertar:
%    b.1. Haverá um tempo extra de "timeDummy" em que ele ainda pode
%    apertar.
%    b.2. Se não apertar depois de "timeDummy" o sistema aperta
%    automaticamente e passa para outra banda.
% c. O contador "for m=1:7" controla as bandas.
% d. O voulntário NÃO DEVE ver o número do contador.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Cleaning service
clear all; close all; clc; 

%% Carrega sinal preparado anteriormente
load('Sinal.mat');
%% Ajustar esses valores
CteAmp = 1E-2  ;    % Coeficiente de amplificação
P.NPS = -70:1:80;  % Vetor com passos para amplificação do sinal
%%% Ajustes avançados
timePause = 0.393; % Tempo de 400 ms descontando o tempo de processamento
timeDummy = 4;     % Tempo de silencio de segurança
%% Coeficientes para blocos
P.Pa  = 10.^(P.NPS./20).*20E-6; P.cte = 0.05/P.Pa(1);
P.up   = P.Pa.*P.cte ; 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Mr. Robot 
import java.awt.Robot 
import java.awt.event.*
keys = Robot;
%% Processamento
fclose('all'); delete('out.txt');
%%%% Função que "escuta" as teclas
h = time_keypress; 
pause(1); fprintf('\n Teste começando... aperte a barra quando escutar e novamente quando parar de escutar.'); pause(1);
%%% Inicia teste 
keys.keyPress(java.awt.event.KeyEvent.VK_SPACE) 
keys.keyRelease(java.awt.event.KeyEvent.VK_SPACE)
for m=1:7  % Bandas { 125,250,500,1 k,2 k,4 k,8 k }
b = 1;     % Contador barra apertada    
set(h.ui,'str',sprintf(['Banda: ' num2str(m)]));
fprintf(['\nBanda: ' num2str(m) ' - Ite. =   ']);    
    %%%%%%%%%%%% Subida %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    for n=1:+1:length(P.up)
     sound(Yt.time(:,m)*CteAmp*P.up(n),Yt.samplingRate); 
%%%%%%%%%%%%%%%%%%%%%%%%%%% Para o avaliador %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%     
% Atualiza Command Window para o experimentador, quando for utilizar no teste, não apresente os número de andamento
 if n>1; for d=0:log10(n-1); fprintf('\b'); end; end; fprintf('%d',n); 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%       
% Atualiza Command Window, utilize esse para o teste. Use este ou o outro
% acima (comentando e descomentando)
%   if rem(n,2); fprintf('rodando...'); else fprintf('\b\b\b\b\b\b\b\b\b\b'); end   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%            
     if exist('out.txt','file') == 2 
         pause(timePause); fprintf('\n saiu up\n');
         fileID = fopen('out.txt','r'); Time.up(b,1) = fscanf(fileID,'%f'); fclose('all');
         Time.up(b,2) = P.up(n); Time.up(b,3) = n; b = b + 1; 
         delete('out.txt');
         break;
     end
     pause(timePause);
     if n==length(P.NPS); pause(timeDummy); fprintf('\n Too late!    \n'); end 
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    fprintf(['Banda: ' num2str(m) ' - Ite. =   ']);
    %%%%%%%%%%%% Descida %%%%%%%%%%%%%%%%%%%%%%%%%%%
    for q=n-1:-1:1
     sound(Yt.time(:,m)*CteAmp*P.up(q),Yt.samplingRate);
%%%%%%%%%%%%%%%%%%%%%%%%%%% Para o avaliador %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
     if q==9; fprintf('\b\b');
     elseif q==99; fprintf('\b\b\b');
     elseif q~=9 && q~=99 && size(num2str(q),2)>=3; fprintf('\b\b\b');          
     elseif q~=9 && q~=99 && size(num2str(q),2)>=2 && size(num2str(q),2)<3; fprintf('\b\b'); 
     elseif q<9; fprintf('\b');
     end
     fprintf('%d',q); % Atualiza Command Window     
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%       
% Atualiza Command Window, utilize esse para o teste. Use este ou o outro
% acima (comentando e descomentando)
%   if rem(n-1,2); l=0; else l=1; end;
%   if rem(q+l,2); fprintf('rodando...'); else fprintf('\b\b\b\b\b\b\b\b\b\b'); end   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
     if exist('out.txt','file') == 2
         pause(timePause); fprintf('\n saiu down\n');
         fileID = fopen('out.txt','r'); Time.down(b,1) = fscanf(fileID,'%f'); fclose('all');
         Time.down(b,2) = P.up(q); Time.down(b,3) = q; b = b + 1;
         delete('out.txt');
         if exist('Time','var') == 1 && m>0
           eval('Banda(m).tempo = Time;'); %% Guarda valor por banda
         end
         break;
     end  
     pause(timePause);
     if q==1; fprintf('\b %d',q); pause(timeDummy); fprintf('\n Too late!  \n'); 
        if exist('out.txt','file') == 2
         fileID = fopen('out.txt','r'); Time.down(b,1) = fscanf(fileID,'%f'); fclose('all');
         Time.down(b,2) = P.up(q); Time.down(b,3) = q; b = b + 1;
         delete('out.txt'); 
         if exist('Time','var') == 1 && m>0
           eval('Banda(m).tempo = Time;'); %% Guarda valor por banda
         end
         break;
        else
          keys.keyPress(java.awt.event.KeyEvent.VK_SPACE);
          keys.keyRelease(java.awt.event.KeyEvent.VK_SPACE); pause(0.05);
         if exist('out.txt','file') == 2
         fileID = fopen('out.txt','r'); Time.down(b,1) = fscanf(fileID,'%f'); fclose('all');
         Time.down(b,2) = P.up(q); Time.down(b,3) = q; b = b + 1;
         delete('out.txt'); 
         if exist('Time','var') == 1 && m>0
           eval('Banda(m).tempo = Time;'); %% Guarda valor por banda
         end
         break;
         end
        end
     end
   end
end; set(h.ui,'str',sprintf('Test e terminado. Obrigado!'));
%% Pega tempos para conferir
   Tempos = h.fig.UserData; 
 save dados_viviane_HD600.mat Banda