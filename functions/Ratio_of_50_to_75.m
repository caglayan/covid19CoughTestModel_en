function data=Ratio_of_50_to_75(data)
window_size = 128;
totalwindow=length(data);
for windowindex=1:totalwindow    
    tempwindow=data(windowindex).winSound;
    [Pxx,w] = pwelch(tempwindow,window_size);
    Pxx=Pxx/sum(Pxx);
    total_sum=0;
    index_75=0;
    while (total_sum < 0.75)
        index_75=index_75+1;
        total_sum=total_sum+Pxx(index_75);
    end
    index_50=0;
    total_sum=0;
    while (total_sum < 0.50)
        index_50=index_50+1;
        total_sum=total_sum+Pxx(index_50);
    end
    f_75=w(index_75);
    f_50=w(index_50);
    data(windowindex).f50_75=f_50/f_75;
end    
end

