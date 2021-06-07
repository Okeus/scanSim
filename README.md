# scanSim
Simulates high intensity focused ultrasound heating with adjustable sonication parameters, using k-wave.

![Tfp_X_1EM7_6EM7](https://user-images.githubusercontent.com/53169576/121063612-d8390680-c7c6-11eb-9320-47be8dd3aaf1.png)

![intensity_to_temp_fp](https://user-images.githubusercontent.com/53169576/121063652-e2f39b80-c7c6-11eb-8c0b-402c05db7921.png)

![intensity_to_temp_fp_corrected_legend](https://user-images.githubusercontent.com/53169576/121063705-f272e480-c7c6-11eb-90c3-0bbcac380410.png)


# Dependencies

[Matlab](https://fr.mathworks.com/products/matlab.html)

[k-Wave Toolbox](http://www.k-wave.org/)

# Usage
intensity_to_temp.m
Ryan Holman
Department of Radiology
Centre for Biomedical Imaging
Image-Guided Interventions Laboratory.
University of Geneva

Uses input intensity field and sonication parameters used in our experiments to estimate the temperature distribution
sonication parameters must be adjusted in code:
    time on, time off, executions, number of sonication points, pause
    time, applied power.
Shorter Sonication times may need higher time resolution.
    
To Do:
List all input variables as default values in a file.
    Accept command line arguments to modify each default value.
    Then values can be changed in parameter file or from command line.
Add GPU array processing.
    gpuArray for HP Z400
graphics acceleration for making videos
    opengl hardware
Improve perfusion rate formula.
vary powers, perfusion rates, and duty cycles to compare results.
    Plot maximum focal point temperature as a function of these
    parameters.
use intput variables as a string to distingish each output file.
combine with attenuation theory mechanisms such as particle concentration,
    viscous attenuation, cavitation attenuation parameters.
%Need to implement a change in focal point position.  ie. a xyz coordinate
with each time point.


IInn=intensity_to_tempM(absorptionCoefficient,PerfusionRate,ThermalDiffusivity,NumberOfShots,AppliedPower,OutputFileIndex);
IInn=intensity_to_temp(1.0425,0,3.8506E-7,6,20,'pa20');

Example:  analyze multiple powers simultaneously:
ppaa=[15,20,25,30,35,40];
for ww=1:6; IInn=intensity_to_temp(1.0425,0,3.8506E-7,3,ppaa(ww),ppaa(ww));end

Example:  analyze multiple Thermal Diffusivity simultaneously:
ppaa=[1E-7,2E-7,3E-7,4E-7,5E-7,6E-7];
for ww=1:6;IInn=intensity_to_temp(1.0425,0,ppaa(ww),3,25,round(ppaa(ww)/ppaa(1)));end

Example:  analyze multiple Perfusion Rates simultaneously:
ppaa=[0,0.1,0.2,0.3,0.4,0.5];
for ww=1:6;
    IInn=intensity_to_temp(1.0425,ppaa(ww),3.8506E-7,3,25,round((ppaa(ww)+.1)*10));
end

IInn=intensity_to_temp(1.308,0.01,3.5E-7,1,20,1); 

same as convolution simulation
IInn=intensity_to_temp(1.308,0.00001,3.85E-7,3,20,1); 

same as convolution simulation
IInn=intensity_to_temp(1.61,0.00001,3.85E-7,3,48,1); 

