function data=calcZeroCrIr(data)
totalwindow=length(data);
for windowindex=1:totalwindow
    tempwindow=data(windowindex).winSound;
    tempwindow = tempwindow - mean(tempwindow);
    data(windowindex).zeroCrIr = std(diff(find(diff(sign(tempwindow)))))/mean(diff(find(diff(sign(tempwindow)))));     
end    
end

