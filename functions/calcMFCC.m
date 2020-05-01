function data=calcMFCC(data)
totalwindow=length(data);
for windowindex=1:totalwindow
    tempwindow=data(windowindex).winSound;
    tempwindow = tempwindow - mean(tempwindow);
    coeffs = mfcc(tempwindow',9600);
    data(windowindex).MFCCParams=mean(coeffs);    
end    
end