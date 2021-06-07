%intensity_to_temp.m
%Ryan Holman
%Department of Radiology
%Centre for Biomedical Imaging
%Image-Guided Interventions Laboratory.
%University of Geneva

%Uses input intensity field and sonication parameters used in our experiments to estimate the temperature distribution
%sonication parameters must be adjusted in code:
    %time on, time off, executions, number of sonication points, pause
    %time, applied power.
%Shorter Sonication times may need higher time resolution.
    
%To Do:
%List all input variables as default values in a file.
    %Accept command line arguments to modify each default value.
    %Then values can be changed in parameter file or from command line.
%Add GPU array processing.
    %gpuArray for HP Z400
%graphics acceleration for making videos
    %opengl hardware
%Improve perfusion rate formula.
%vary powers, perfusion rates, and duty cycles to compare results.
    %Plot maximum focal point temperature as a function of these
    %parameters.
%use intput variables as a string to distingish each output file.
%combine with attenuation theory mechanisms such as particle concentration,
    %viscous attenuation, cavitation attenuation parameters.
%%Need to implement a change in focal point position.  ie. a xyz coordinate
%with each time point.


%IInn=intensity_to_tempM(absorptionCoefficient,PerfusionRate,ThermalDiffusivity,NumberOfShots,AppliedPower,OutputFileIndex);
%IInn=intensity_to_temp(1.0425,0,3.8506E-7,6,20,'pa20');

%Example:  analyze multiple powers simultaneously:
%ppaa=[15,20,25,30,35,40];
%for ww=1:6; IInn=intensity_to_temp(1.0425,0,3.8506E-7,3,ppaa(ww),ppaa(ww));end

%Example:  analyze multiple Thermal Diffusivity simultaneously:
%ppaa=[1E-7,2E-7,3E-7,4E-7,5E-7,6E-7];
%for ww=1:6;IInn=intensity_to_temp(1.0425,0,ppaa(ww),3,25,round(ppaa(ww)/ppaa(1)));end

%Example:  analyze multiple Perfusion Rates simultaneously:
% ppaa=[0,0.1,0.2,0.3,0.4,0.5];
% for ww=1:6;
%     IInn=intensity_to_temp(1.0425,ppaa(ww),3.8506E-7,3,25,round((ppaa(ww)+.1)*10));
% end

%IInn=intensity_to_temp(1.308,0.01,3.5E-7,1,20,1); 

%same as convolution simulation
%IInn=intensity_to_temp(1.308,0.00001,3.85E-7,3,20,1); 

%same as convolution simulation
%IInn=intensity_to_temp(1.61,0.00001,3.85E-7,3,48,1); 


function IInn=intensity_to_temp(alpha,perf,X,nsh,pa,outf)
    atitle=["alp:",num2str(alpha),"perf:",num2str(perf);"TD:",num2str(X),"Pa:",num2str(pa)];
    atitle=join(atitle);
    close all;
    tic
    opengl hardware
    outf=num2str(outf);
    
    %Sonication Parameters for Duty Cycle.
    execs=33;
    num_pts=1;
    time_on=900; %ms
    time_off=100; %ms
    time_pause=0;
    
    %https://itis.swiss/virtual-population/tissue-properties/database/heat-capacity/
    rho=1050; %density
    ct=3617	; %specific heat of blood
    ctt=3540; %specific heat of liver tissue
    ctw=4178; %specific heat of water
    co=1520; %speed of sound
    dt=.01; %units of seconds.  Used as interval between sonication transition from high to low.
    dx=.001; %units of meters. spatial resolution.
    
    tcool=180;
    
    p_off_time=((time_on+time_off)*num_pts+time_pause)*execs; %time at end of sonications, in milliseconds.
    tt=round(p_off_time/1000/dt)+tcool/dt;
    p_off_frame=round(p_off_time/dt);
    [on_idx,off_idx]=makePulse(time_on, time_off, time_pause, execs);
	[IInn]=pulse2intensity(on_idx,off_idx,dt,p_off_frame,execs,tt); 
    %load('matrice3D_intensity.mat');
    %int4d=intensity3d(40:end-40,40:end-40,211-5:5:211+5);  %ORIGINAL, too high
    %int4d=intensity3d(40:end-40,40:end-40,211-31:31:211+31); %MODIFIED, much better.  consider replacing with oneil method.
    %save('int4d.mat','int4d')
    load('int4d.mat');
    %size(int4d)
    %pause
    T0=21.*ones(128,128,3);
    Tfp=zeros([1 tt*nsh]);
    Tint=zeros([1 tt*nsh]);    
    rTemp=T0;
    
    for u=1:nsh
        disp(u);
        for nn=1:tt 
            %should this be 2alphaaI? makes values too high... bug
            Q=pa*alpha*int4d*IInn(nn)*10000; %W/m3, 
            S=Q./(rho*ct);
            T0=bioheatExact(T0,S,[X,perf,21],dx,dt);
            if(nn==1000)
                rTemp=T0(:,:,2)-21;
            end
            hh=T0(54:74,54:74,2);
            Tfp(1,(u-1)*tt+nn)=max(hh(:))-21;
            zmat=T0(54:74,54:74,2)-21;  %This should be all pixels above 0.5�C from ambient.
            Tint(1,(u-1)*tt+nn)=sum(zmat(:));
        end
    end
    disp('calculating temperature matrix end');
   
    rmax=max(rTemp(:));
    rmax5=0.5*rmax;
    rabs=abs(rTemp-rmax5);
    [rabsmin, Irabs]=min(rabs);
    arabs=rTemp(Irabs);
    zz=find(rTemp==arabs)
    figure
    imagesc(rTemp)
    hold on
        
    %make focal point temperature plot
    figure
    nn=1:nsh*tt;
    timeT=dt*nn;
    x=timeT;
    y=Tfp;
    plot(x,y);
    hold on
    plot(x(1000),y(1000),'bo');
    grid on;
    grid minor;
    xlabel('time,s');
    ylabel('Temp, °C');
    title(atitle);
    astr=strcat(outf,'_simulator_timeT.mat');
    bstr=strcat(outf,'_simulator_fp.png');
    dstr=strcat(outf,'_simulator_fp.mat');
    outg=fullfile(bstr);
    saveas(gcf,outg);
    save(astr,'timeT');
    save(dstr,'Tfp');
    
    %make integral temperature plot
    figure
    nn=1:tt*nsh;
    timeT=dt*nn;
    x=timeT;
    y=Tint;
    plot(x,y)
    grid on;
    grid minor;
    xlabel('time,s')
    ylabel('Int Temp, °C*mm2')
    title(atitle);
    bstr=strcat(outf,'_simulator_intTemp.png');
    dstr=strcat(outf,'_simulator_intTemp.mat');
    outg=fullfile(bstr);
    saveas(gcf,outg);
    save(dstr,'Tint');
    
    toc
end
