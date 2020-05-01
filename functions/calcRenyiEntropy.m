function data=calcRenyiEntropy(data)
totalwindow=length(data);
histparameter=128;
for windowindex=1:totalwindow
    tempwindow=data(windowindex).winSound;
    tempwindow = tempwindow - mean(tempwindow);
    temphist=hist(tempwindow,histparameter);
    for alpha = 1:3
        data(windowindex).renyi(alpha) = entropy_renyi(temphist,alpha);
    end
end
end
