function [IInn]=pulse2intensity(on_idx,off_idx,dt,p_off_frame,execs,tt)
    IInn=ones([1 tt]);
    for n=1:p_off_frame
        for vv=1:execs
             if n*dt*1000>off_idx(vv) && n*dt*1000<on_idx(vv+1)
                 IInn(:,n)=0;
             end
        end
    end
    for n=1:tt
        if n*dt*1000>off_idx(end)
            IInn(:,n)=0;
        end
    end
end