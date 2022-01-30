close all; clear all;

Tfp_files=dir('./*_simulator_fp.mat')
[r,c]=size(Tfp_files);
for u=1:r
    f{u}=Tfp_files(u).name
    v=load(Tfp_files(u).name);
    Temp_fp(u,:)=v.Tfp;
end

figure
subplot(1,2,1)
hold on
grid on
grid minor
dt=.01;
%15%,19.2 W
%20%,32.3 W
%25,48.1 W
%30,67.4 W (~2.7 MPa Ppk-pk)
%35,88.7 W
%40,110 W
%alpha=[1.4000    2.0379    2.4257    2.7846    3.2042];
%C=[0 0.07 0.13 0.21 0.39];
legg={'$0.0\,\%v:v$','$0.07\,\%v:v$','$0.13\,\%v:v$','$0.21\,\%v:v$','$0.39\,\%v:v$'}
for j=1:r
    y=Temp_fp(j,:);
    e=length(y);
    x=1:e;
    x=dt*x;
    plot(x,y,'DisplayName',legg{j})
end
title('$\mathit{Focal \, Temperature}$','Interpreter','Latex')
xlabel('$\mathit{time,\,s}$','Interpreter','Latex')
ylabel('$\mathit{^{\circ} C}$','Interpreter','Latex')  
%legend();
%dim = [0.2 0.5 0.3 0.3];
% str = {'$\alpha$: 1.3 m^{-1}','perfusion: 0 m/s'};
% annotation('textbox',dim,'String',str,'FitBoxToText','on');

Tint_files=dir('./*_simulator_intTemp.mat')
[r,c]=size(Tint_files);
for u=1:r
    f{u}=Tint_files(u).name
    v=load(Tint_files(u).name);
    Temp_int(u,:)=v.Tint;
end

subplot(1,2,2)
hold on
grid on
grid minor
dt=.01;
%legg={'0 ,\,\frac{1}{s}','0.1 ,\,\frac{1}{s}','0.2 ,\,\frac{1}{s}','0.3 ,\,\frac{1}{s}','0.4 ,\,\frac{1}{s}','0.5 ,\,\frac{1}{s}',}
for j=1:r
    y=Temp_int(j,:);
    e=length(y);
    x=1:e;
    x=dt*x;
    plot(x,y,'DisplayName',legg{j})
end
title('$\mathit{Integral \, Temperature}$','Interpreter','Latex')
xlabel('$\mathit{time,\,s}$','Interpreter','Latex')
ylabel('$\mathit{^{\circ} C.mm^{2}}$','Interpreter','Latex')    
legend('Interpreter','latex');