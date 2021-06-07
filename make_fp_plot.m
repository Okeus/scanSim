function make_fp_plot(XXX,T)
    figure;
    pathName=pwd;
    zz=fullfile(pathName,'fp_plot.png');
    plot(XXX,squeeze(T(64,64,:)));
    title('Focal Temperature, °C');
    xlabel('time, s')
    ylabel('°C')
    grid on;
    grid minor;
    hold off;
    saveas(gcf,zz)
end

