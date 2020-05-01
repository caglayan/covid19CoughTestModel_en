function data=calcLPC(data)
totalwindow=length(data);
for windowindex=1:totalwindow
    tempwindow=data(windowindex).winSound;
    tempwindow = tempwindow - mean(tempwindow);
    coeffs = lpc(tempwindow,6); % 6'th order linear coeff.        
    data(windowindex).LPCParams = coeffs(2:7);
end
end