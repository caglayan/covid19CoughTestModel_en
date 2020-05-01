function data=ArCalc(data)
totalwindow=length(data);
for windowindex=1:totalwindow
    tempwindow=data(windowindex).winSound;
    tempwindow = tempwindow - mean(tempwindow);
    [coeffs, error] = aryule(tempwindow,6);
    data(windowindex).ArParams = [coeffs(2:7) error];
end
end

