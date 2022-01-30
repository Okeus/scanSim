function [pr,mpr,pr3]=hifu_oneil_pressure()
    Pb=101325;

    Nx = 128;           % number of grid points in the x (row) direction
    Ny = 128;           % number of grid points in the y (column) direction
    Nz = 250;           % number of grid points in the z (column) direction
    dx = 1e-3;        % grid point spacing in the x direction [m]
    dy = 1e-3;        % grid point spacing in the y direction [m]
    dz = 1e-3;

    % define transducer parameters
    radius      = 130e-3;   % [m]
    diameter    = 120e-3;   % [m]
    velocity    = 100e-3;   % [m/s]
    frequency   = 1.031e6;      % [Hz]
    sound_speed = 1500;     % [m/s]
    density     = 1000;     % [kg/m^3]

    % define position vectors
    axial_position   = 0:1e-3:Nz*dz;       % [m]
    lateral_position = -Nx/2*dx:1e-3:Nx/2*dx;   % [m]

    % evaluate pressure
    [p_axial, p_lateral] = focusedBowlONeil(radius, diameter, velocity, ...
        frequency, sound_speed, density, axial_position, lateral_position);
    lat_norm=p_lateral/max(p_lateral);
    % plot
    figure;
    subplot(2, 1, 1);
    plot(axial_position .* 1e3, p_axial .* 1e-6, 'k-');
    xlabel('Axial Position [mm]');
    ylabel('Pressure [MPa]');
    subplot(2, 1, 2);
    plot(lateral_position .* 1e3, p_lateral .* 1e-6, 'k-');
    xlabel('Lateral Position [mm]');
    ylabel('Pressure [MPa]');

    pr=zeros(Nx,Ny,Nz);
    pr(Nx/2,Ny/2,:)=lat_norm(Nx/2+1);
    for r=1:round(Nx/2)
        for th=.0001:pi/300:2*pi
            xx=round(Nx/2+r*cos(th));
            yy=round(Ny/2+r*sin(th));
            try
                pr(xx,yy,:)=lat_norm(Nx/2+r);
            catch 
                %disp('Error');
            end
        end
    end
    for k=1:Nz
        pr(:,:,k)=p_axial(k)*pr(:,:,k);
    end
    pr=pr+Pb;

    fp_idx=find(p_axial==max(p_axial,[],'all'));
    mpr=max(p_axial,[],'all');
    pr3=pr(:,:,fp_idx-5:5:fp_idx+5);

    % figure
    % T=pr;
    % vmax=max(T,[],'all');
    % vmin=min(T,[],'all');
    % hold on
    % for e=1:tt
    %     h = pcolor(T(:,:,e));
    %     set(h, 'EdgeColor', 'none');
    %     hc=colorbar; 
    %     title(hc,'T,°C');
    %     caxis([vmin vmax]); 
    %     title('Pressure, MPa');
    %     fprintf("%i\n",e)
    %     hold off;
    %     pause
    % end
end
