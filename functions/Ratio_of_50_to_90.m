function data=Ratio_of_50_to_90(data)
window_size = 128;
totalwindow=length(data);
for windowindex=1:totalwindow    
    tempwindow=data(windowindex).winSound;
    [Pxx,w] = pwelch(tempwindow,window_size);
    Pxx=Pxx/sum(Pxx);
    total_sum=0;
    index_90=0;
    while (total_sum < 0.90)
        index_90=index_90+1;
        total_sum=total_sum+Pxx(index_90);
    end
    index_50=0;
    total_sum=0;
    while (total_sum < 0.50)
        index_50=index_50+1;
        total_sum=total_sum+Pxx(index_50);
    end
    f_90=w(index_90);
    f_50=w(index_50);
    data(windowindex).f50_90=f_50/f_90;
end    
end

