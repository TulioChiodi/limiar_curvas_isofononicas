%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Rotina para receber/escutar um acionamento do teclado
%
% Desenvolvido pelo professor da Engenharia Acústica da UFSM:
%    William D'Andrea Fonseca, Dr. Eng.
%
% Atualização: 07/11/2017
%
%%%% O que FAZER?
% 1. Usar com AvaliaFPsico.m
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function h = time_keypress
close all;
h.fig = figure('KeyReleaseFcn',@KeyUp,'KeyPressFcn',@KeyDown, ...
               'menu','none', 'pos',[350 350 420 100], ...
               'Name','Avaliação de função psicométrica');

h.ui = uicontrol('Style','text','Position',[65 40 300 30],...
                'String',' Teste começando... aperte a barra quando escutar e novamente quando parar de escutar.');

t1=0; t2=0;

function KeyUp(~,~)
    t1=rem(now,1);
end

n=1; 
function timeSecs = KeyDown(~,~) 
     days2sec = 24*60*60;      
     t2=rem(now,1); 
     h.timeSecs=(t2-t1)*days2sec; timeSecs= h.timeSecs;
%      h.fig.Name=num2str(h.timeSecs); 
%      h.fig.Name=num2str(['Banda ' num2str(n)]);
     if n==1
%       disp(timeSecs)
     else
      fileID = fopen('out.txt','w');   
      fprintf(fileID,'%10.8f',timeSecs);
      fclose(fileID);
      h.fig.UserData(n-1,1) = timeSecs;   
%       disp([' ''ok ' num2str(n-1) '''   '])
      disp('         ')
     end
     n=n+1;
end

end