function data = FFTPolyFit(data)
totalwindow=length(data);
for windowindex=1:totalwindow
    tempwindow=data(windowindex).winSound;    
    % FFT calculation and FFT fit
    fftLength=2^nextpow2(length(tempwindow)); 
    freq = 9600*(1:(fftLength/2))/fftLength;
    windowFft = 20*log10(abs(fft(tempwindow/max(abs(tempwindow)),fftLength))); 
    windowFft = windowFft(1:fftLength/2);    
    if(windowindex==6318)
    windowFft(129) = (windowFft(128)+windowFft(130))/2;
    end 
    fftFit = polyval(polyfit(freq,windowFft,10),freq);            
    [~,MI] = max(windowFft);    
    maxFreq = freq(MI);    
%    
 
    if maxFreq>60
        intervalIndex = find(freq<maxFreq+60 & freq>maxFreq-60); 
    else
        intervalIndex = find(freq<maxFreq+60 & freq>1); 
    end
    data(windowindex).differenceDB = max(windowFft(intervalIndex)-fftFit(intervalIndex));
    
%     clf
%     plot(freq,fftFit);
%     hold on
%     plot(freq,windowFft);
%     plot(maxFreq,windowFft(MI),'*');
%     disp(data(windowindex).differenceDB)
%     disp("--")
       
end    
end

