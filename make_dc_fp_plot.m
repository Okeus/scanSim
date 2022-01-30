close all; clear all;

Tfp_files=dir('./*_simulator_fp.mat')
[r,c]=size(Tfp_files);
for u=1:r
    f{u}=Tfp_files(u).name
    v=load(Tfp_files(u).name);
    Temp_fp(u,:)=v.Tfp;
end

figure
hold on
grid on
grid minor
dt=.01;
legg={'5%','10%','30%','50%','70%','90%',}
for j=1:r
    y=Temp_fp(j,:);
    e=length(y);
    x=1:e;
    x=dt*x;
    plot(x,y,'DisplayName',legg{j})
end
title('$\mathit{Duty \, Cycle}$','Interpreter','Latex')
xlabel('$\mathit{time,\,s}$','Interpreter','Latex')
ylabel('$\mathit{^{\circ} C}$','Interpreter','Latex')  
legend();
dim = [0.2 0.5 0.3 0.3];
% str = {'$\alpha$: 1.3 m^{-1}','perfusion: 0 m/s'};
% annotation('textbox',dim,'String',str,'FitBoxToText','on');