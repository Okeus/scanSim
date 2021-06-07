close all; clear all;

fp1=load('1_fp.mat');
fp2=load('2_fp.mat');
fp3=load('3_fp.mat');
fp4=load('4_fp.mat');
fp5=load('5_fp.mat');
fp6=load('6_fp.mat');

Tint1=load('1_intTemp.mat');
Tint2=load('2_intTemp.mat');
Tint3=load('3_intTemp.mat');
Tint4=load('4_intTemp.mat');
Tint5=load('5_intTemp.mat');
Tint6=load('6_intTemp.mat');

dt=.01;
x=dt*(1:length(fp1.Tfp));

figure
hold on
plot(x,fp1.Tfp,'LineWidth',1)
plot(x,fp2.Tfp,'LineWidth',1)
plot(x,fp3.Tfp,'LineWidth',1)
plot(x,fp4.Tfp,'LineWidth',1)
plot(x,fp5.Tfp,'LineWidth',1)
plot(x,fp6.Tfp,'LineWidth',1)
xlabel('time, s')
ylabel('T, °C')
title('Focal Temp Vs. Perfusion Rate (1/s)')
legend('0.1','0.2','0.3','0.4','0.5','0.6')
grid on
grid minor
hold off

figure
hold on
plot(x,Tint1.Tint,'LineWidth',1)
plot(x,Tint2.Tint,'LineWidth',1)
plot(x,Tint3.Tint,'LineWidth',1)
plot(x,Tint4.Tint,'LineWidth',1)
plot(x,Tint5.Tint,'LineWidth',1)
plot(x,Tint6.Tint,'LineWidth',1)
xlabel('time, s')
ylabel('Tint, °C*mm2')
title('Integral Temp Vs. Perfusion Rate (1/s)')
legend('0.1','0.2','0.3','0.4','0.5','0.6')
grid on
grid minor
hold off
