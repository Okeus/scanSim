function [on_idx,off_idx]=makePulse(time_on, time_off, time_pause, execs)
    on_idx = zeros(1,execs+1);
    off_idx = zeros(1,execs);
    on_idx(1) = 0;
    for uu=2:execs+1
        on_idx(uu) = on_idx(uu - 1) + time_on + time_off + time_pause;
    end
    for uu=1:execs
        off_idx(uu) = on_idx(uu) + time_on;
    end
end