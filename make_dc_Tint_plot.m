close all; clear all;

Tint_files=dir('./*_simulator_intTemp.mat')
[r,c]=size(Tint_files);
for u=1:r
    f{u}=Tint_files(u).name
    v=load(Tint_files(u).name);
    Temp_int(u,:)=v.Tint;
end

figure
hold on
grid on
grid minor
dt=.01;
legg={'5%','10%','30%','50%','70%','90%',}
for j=1:r
    y=Temp_int(j,:);
    e=length(y);
    x=1:e;
    x=dt*x;
    plot(x,y,'DisplayName',legg{j})
end
title('$\mathit{Duty \, Cycle}$','Interpreter','Latex')
xlabel('$\mathit{time,\,s}$','Interpreter','Latex')
ylabel('$\mathit{^{\circ} C.mm^{2}}$','Interpreter','Latex')    
legend();