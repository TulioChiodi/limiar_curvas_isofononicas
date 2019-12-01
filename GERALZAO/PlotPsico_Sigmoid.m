%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Rotina para fazer plotar a fun��o Sigmoid com a fun��o psicom�trica
%
% Desenvolvido pelo professor da Engenharia Ac�stica da UFSM:
%    William D'Andrea Fonseca, Dr. Eng.
%
% Atualiza��o: 19/11/2017
% Compatible with itaToolbox and Matlab R2016b
%
%%%% O que FAZER?
% 1. Carregar resultados de avalia��o de cada indiv�duo
% 2. Configurar o plot e plotar junto
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Cleaning service
clear all; close all; clc;
imprime = 1;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Importando Dados
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Sennheiser
Guto.senn = load('dados_Guto_HD600.mat');
Fred.senn = load('dados_Fred_HD600.mat');
Jonas.senn = load('dados_Jonas_HD600.mat');
for n = 1:7
   Amplitudes.senn(n).up = sort([Guto.senn.Banda(n).tempo.up(1)...
       Fred.senn.Banda(n).tempo.up(1) Jonas.senn.Banda(n).tempo.up(1)]);
end
for n = 1:7
   Amplitudes.senn(n).down = sort([Guto.senn.Banda(n).tempo.down(2,1)...
       Fred.senn.Banda(n).tempo.down(2,1)...
       Jonas.senn.Banda(n).tempo.down(2,1)]);
end

% %% JBL
% Guto.jbl = load('dados_Guto_JBL.mat');
% Fred.jbl = load('dados_joaodavi_JBL.mat');
% Jonas.jbl = load('dados_joaov_JBL.mat');
% Laux.jbl = load('dados_laux_JBL.mat');
% for n = 1:7
%    Amplitudes.jbl(n).up = sort([Guto.jbl.Banda(n).tempo.up(1)...
%        Fred.jbl.Banda(n).tempo.up(1) Jonas.jbl.Banda(n).tempo.up(1)...
%        Laux.jbl.Banda(n).tempo.up(1)]);
% end
% for n = 1:7
%    Amplitudes.jbl(n).down = sort([Guto.jbl.Banda(n).tempo.down(2,1)...
%        Fred.jbl.Banda(n).tempo.down(2,1)...
%        Jonas.jbl.Banda(n).tempo.down(2,1)...
%        Laux.jbl.Banda(n).tempo.down(2,1)]);
% end
% 
% %% PC
% Guto.pc = load('dados_Guto_PC.mat');
% Fred.pc = load('dados_joaodavi_PC.mat');
% Jonas.pc = load('dados_joaov_PC.mat');
% Laux.pc = load('dados_laux_PC.mat');
% for n = 1:7
%    Amplitudes.pc(n).up = sort([Guto.pc.Banda(n).tempo.up(1)...
%        Fred.pc.Banda(n).tempo.up(1) Jonas.pc.Banda(n).tempo.up(1)...
%        Laux.pc.Banda(n).tempo.up(1)]);
% end
% for n = 1:7
%    Amplitudes.pc(n).down = sort([Guto.pc.Banda(n).tempo.down(2,1)...
%        Fred.pc.Banda(n).tempo.down(2,1)...
%        Jonas.pc.Banda(n).tempo.down(2,1)...
%        Laux.pc.Banda(n).tempo.down(2,1)]);
% end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
x=1:3; % Sujeitos testados 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Gr�ficos
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Sennheiser up
for n = 1:7
x1 = min(Amplitudes.senn(n).up):0.05:max(Amplitudes.senn(n).up);
c = 125*2^(n-1);
    figure('name',[num2str(c), ' Hz Sennheiser up'])
y1 = sigmf(x1,[2.5/mean(diff(Amplitudes.senn(n).up))...
    median(Amplitudes.senn(n).up)]).*4; %[a b] "b" � o centro e "a" a inclina��o
plot(x1,y1,'linewidth',2); hold on

scatter(Amplitudes.senn(n).up,x,'filled'); hold on
legend('Curva de Ajuste','M�dia dos dados obtidos','location','best')
title(['Sennheiser @ ',num2str(c),' Hz crescente + Fun��o de Sigmoid']);
xlabel('Tempo decorrido at� haver sensa��o auditiva');
ylabel('Resposta "sim, estou ouvindo" de cada indiv�duo');
%arruma_fig('% 2.1f','% 3.2f');

if imprime==1
% Descomentar para gerar um PDF do gr�fico
%     Position plot at left hand corner with width 5 and height 5.
    set(gcf, 'PaperPosition', [0 0 6 5]);
%     Set the paper to have width 5 and height 5.
    set(gcf, 'PaperSize', [6 5]); 
    saveas(gcf, ['Senn_up_',num2str(c)], 'pdf') %Save figure    
end
end

%% Sennheiser down
cc = [1.8, 2,2,2,2,2,2]
for n = 1:7
x1 = min(Amplitudes.senn(n).down):0.05:max(Amplitudes.senn(n).down);
c = 125*2^(n-1);
    figure('name',[num2str(c), ' Hz Sennheiser down'])
y1 = sigmf(x1,[cc(n)/mean(diff(Amplitudes.senn(n).down)) median(Amplitudes.senn(n).down)]).*4;  % [a b] "b" � o centro e "a" a inclina��o
plot(x1,y1,'linewidth',2); hold on

scatter(Amplitudes.senn(n).down,x,'filled'); hold on
legend('Curva de Ajuste','M�dia dos dados obtidos','location','best')

title(['Sennheiser @ ',num2str(c),' Hz decrescente + Fun��o de Sigmoid']);
xlabel('Tempo decorrido at� cessar a sensa��o auditiva');
ylabel('Resposta "sim, estou ouvindo" de cada indiv�duo');
arruma_fig('% 2.1f','% 3.2f');
if imprime ==1
% Descomentar para gerar um PDF do gr�fico
%     Position plot at left hand corner with width 5 and height 5.
    set(gcf, 'PaperPosition', [0 0 6 5]);
%     Set the paper to have width 5 and height 5.
    set(gcf, 'PaperSize', [6 5]); 
    saveas(gcf, ['Senn_down_',num2str(c)], 'pdf') %Save figure    
end
end

%% JBL up
% for n = 1:7
% x1 = min(Amplitudes.jbl(n).up):0.05:max(Amplitudes.jbl(n).up);
% c = 125*2^(n-1);
%     figure('name',[num2str(c), ' Hz JBL up'])
% y1 = sigmf(x1,[2.5/mean(diff(Amplitudes.jbl(n).up))...
%     median(Amplitudes.jbl(n).up)]).*4;  % [a b] "b" � o centro e "a" a inclina��o
% plot(x1,y1,'linewidth',2); hold on
% 
% scatter(Amplitudes.jbl(n).up,x,'filled'); hold on
% legend('Curva de Ajuste','M�dia dos dados obtidos','location','best')
% 
% title(['JBL @ ',num2str(c),' Hz crescente + Fun��o de Sigmoid']);
% xlabel('Tempo decorrido at� haver sensa��o auditiva');
% ylabel('Resposta "sim, estou ouvindo" de cada indiv�duo');
% arruma_fig('% 2.1f','% 3.2f');
% if imprime ==1
% % Descomentar para gerar um PDF do gr�fico
% %     Position plot at left hand corner with width 5 and height 5.
%     set(gcf, 'PaperPosition', [0 0 6 5]);
% %     Set the paper to have width 5 and height 5.
%     set(gcf, 'PaperSize', [6 5]); 
%     saveas(gcf, ['JBL_up_',num2str(c)], 'pdf') %Save figure    
% end
% end
% 
% %% JBL down
% for n = 1:7
% x1 = min(Amplitudes.jbl(n).down):0.05:max(Amplitudes.jbl(n).down);
% c = 125*2^(n-1);
%     figure('name',[num2str(c), ' Hz JBL down'])
% y1 = sigmf(x1,[2.5/mean(diff(Amplitudes.jbl(n).down))...
%     median(Amplitudes.jbl(n).down)]).*4;  % [a b] "b" � o centro e "a" a inclina��o
% plot(x1,y1,'linewidth',2); hold on
% 
% scatter(Amplitudes.jbl(n).down,x,'filled'); hold on
% legend('Curva de Ajuste','M�dia dos dados obtidos','location','best')
% 
% title(['JBL @ ',num2str(c),' Hz decrescente + Fun��o de Sigmoid']);
% xlabel('Tempo decorrido at� cessar a sensa��o auditiva');
% ylabel('Resposta "n�o, parei de ouvir" de cada indiv�duo');
% arruma_fig('% 2.1f','% 3.2f');
% if imprime==1
% % Descomentar para gerar um PDF do gr�fico
% %     Position plot at left hand corner with width 5 and height 5.
%     set(gcf, 'PaperPosition', [0 0 6 5]);
% %     Set the paper to have width 5 and height 5.
%     set(gcf, 'PaperSize', [6 5]); 
%     saveas(gcf, ['JBL_down_',num2str(c)], 'pdf') %Save figure    
% end
% end
% 
% %% PC up
% for n = 1:7
% x1 = min(Amplitudes.pc(n).up):0.05:max(Amplitudes.pc(n).up);
% c = 125*2^(n-1);
%     figure('name',[num2str(c), 'Hz PC up'])
% y1 = sigmf(x1,[2.5/mean(diff(Amplitudes.pc(n).up))...
%     median(Amplitudes.pc(n).up)]).*4;  % [a b] "b" � o centro e "a" a inclina��o
% plot(x1,y1,'linewidth',2); hold on
% 
% scatter(Amplitudes.pc(n).up,x,'filled'); hold on
% legend('Curva de Ajuste','M�dia dos dados obtidos','location','best')
% 
% title(['PC @ ',num2str(c),' Hz crescente + Fun��o de Sigmoid']);
% xlabel('Tempo decorrido at� haver sensa��o auditiva');
% ylabel('Resposta "sim, estou ouvindo" de cada indiv�duo');
% arruma_fig('% 2.1f','% 3.2f');
% if imprime==1
% % Descomentar para gerar um PDF do gr�fico
% %     Position plot at left hand corner with width 5 and height 5.
%     set(gcf, 'PaperPosition', [0 0 6 5]);
% %     Set the paper to have width 5 and height 5.
%     set(gcf, 'PaperSize', [6 5]); 
%     saveas(gcf, ['PC_up_',num2str(c)], 'pdf') %Save figure    
% end
% end
% 
% %% PC down
% for n = 1:7
% x1 = min(Amplitudes.pc(n).down):0.05:max(Amplitudes.pc(n).down);
% c = 125*2^(n-1);
%     figure('name',[num2str(c), 'Hz PC down'])
%     y1 = sigmf(x1,[2.5/mean(diff(Amplitudes.pc(n).down))...
%         median(Amplitudes.pc(n).down)]).*4;  % [a b] "b" � o centro e "a" a inclina��o
% plot(x1,y1,'linewidth',2); hold on
% 
% scatter(Amplitudes.pc(n).down,x,'filled'); hold on
% legend('Curva de Ajuste','M�dia dos dados obtidos','location','best')
% 
% title(['PC @ ',num2str(c),' Hz decrescente + Fun��o de Sigmoid']);
% xlabel('Tempo decorrido at� cessar a sensa��o auditiva');
% ylabel('Resposta "n�o, parei de ouvir" de cada indiv�duo');
% arruma_fig('% 2.1f','% 3.2f');
% if imprime==1
% % Descomentar para gerar um PDF do gr�fico
% %     Position plot at left hand corner with width 5 and height 5.
%     set(gcf, 'PaperPosition', [0 0 6 5]);
% %     Set the paper to have width 5 and height 5.
%     set(gcf, 'PaperSize', [6 5]); 
%     saveas(gcf, ['PC_down_',num2str(c)], 'pdf') %Save figure    
% end
% end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%