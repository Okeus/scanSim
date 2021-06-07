close all; clear all;

fp1=load('15_fp.mat');
fp2=load('20_fp.mat');
fp3=load('25_fp.mat');
fp4=load('30_fp.mat');
fp5=load('35_fp.mat');
fp6=load('40_fp.mat');

Tint1=load('15_fp.png_intTemp.mat');
Tint2=load('20_fp.png_intTemp.mat');
Tint3=load('25_fp.png_intTemp.mat');
Tint4=load('30_fp.png_intTemp.mat');
Tint5=load('35_fp.png_intTemp.mat');
Tint6=load('40_fp.png_intTemp.mat');

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
title('Focal Temp Vs. Applied Power (W)')
legend('15','20','25','30','35','40')
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
title('Integral Temp Vs. Applied Power (W)')
legend('15','20','25','30','35','40')
grid on
grid minor
hold off
% 
% for i=1:6
%     hold on
%     plot(x,fp1.Tfp,'LineWidth',1)
%     plot(x,fp2.Tfp,'LineWidth',1)
%     plot(x,fp3.Tfp,'LineWidth',1)
%     plot(x,fp4.Tfp,'LineWidth',1)
%     plot(x,fp5.Tfp,'LineWidth',1)
%     plot(x,fp6.Tfp,'LineWidth',1)
%     xlabel('time, s')
%     ylabel('T, Â°C')
%     title('Integral Temp Vs. Applied Power (W)')
%     legend('15','20','25','30','35','40')
%     grid on
%     grid minor
%     hold off
% end
% 
% for i=1:6
%     hold on
%     plot(x,Tint1.Tint,'LineWidth',1)
%     plot(x,Tint2.Tint,'LineWidth',1)
%     plot(x,Tint3.Tint,'LineWidth',1)
%     plot(x,Tint4.Tint,'LineWidth',1)
%     plot(x,Tint5.Tint,'LineWidth',1)
%     plot(x,Tint6.Tint,'LineWidth',1)
%     xlabel('time, s')
%     ylabel('Tint, Â°C*mm2')
%     title('Integral Temp Vs. Applied Power (W)')
%     legend('15','20','25','30','35','40')
%     grid on
%     grid minor
%     hold off
% end