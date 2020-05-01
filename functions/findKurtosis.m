function data=findKurtosis(data)
totalwindow=length(data);
for windowindex=1:totalwindow
    tempwindow=data(windowindex);
    data(windowindex).kurtosis=kurtosis(tempwindow.winSound);    
end
end

