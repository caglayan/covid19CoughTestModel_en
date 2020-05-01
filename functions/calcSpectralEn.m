function data=calcSpectralEn(data)
orderTimeAverage = 13;
totalwindow=length(data);

for windowindex=1:totalwindow
    tempwindow=data(windowindex).winSound;  
    % ASE calculation
    % complex FFT    
    fft_interval = fft(tempwindow, 256); % long FFT   
    % sadece 4 ile 38 arasına düşne frekans magnitude ve faz bizim için
    % önemli
    for k = 6:38
        data(windowindex).power(k) = abs(fft_interval(k)).^2;
        timePowerArr = [];
        for t = 1:windowindex
            timePowerArr = [timePowerArr data(t).power(k)];
        end    

        % mean
        if windowindex<orderTimeAverage                         
            data(windowindex).powerMean(k) = sum(timePowerArr)/(windowindex);
        else
            data(windowindex).powerMean(k) = sum(timePowerArr(end-orderTimeAverage+1:end))/(orderTimeAverage);
        end
    end        
end
% Normalize
for windowindex=1:totalwindow    
    for k = 6:38
         data(windowindex).powerNorm(k) = (data(windowindex).powerMean(k) - min(data(windowindex).powerMean))/ (max(data(windowindex).powerMean) - min(data(windowindex).powerMean));   
    end   
end

% Fluct
for windowindex=1:totalwindow 
    fluct = 0;
    for k = 6:38
        fluct = fluct + abs(data(windowindex).powerNorm(k)-data(windowindex).powerNorm(k-1)); 
    end
    data(windowindex).ASE=fluct;
end

end

