function data=tonalityCalc(data)
orderTimeAverage = 7;
totalwindow=length(data);
for windowindex=1:totalwindow
    tempwindow=data(windowindex).winSound;    
    % TI calculation
    % complex FFT    
    fft_interval = fft(tempwindow, 256); % long FFT 
    % sadece 4 ile 38 arasına düşne frekans magnitude ve faz bizim için
    % önemli
    for k = 6:38        
        data(windowindex).tonalMag(k) = abs(fft_interval(k));        
        data(windowindex).phi_sav(k) = angle(fft_interval(k));
        if windowindex>2
            r_prime = 2.0 * data(windowindex-1).tonalMag(k) - data(windowindex-2).tonalMag(k);
            phi_prime = 2.0 * data(windowindex-1).phi_sav(k) - data(windowindex-2).phi_sav(k);

            temp1 = data(windowindex).tonalMag(k) * cos(data(windowindex).phi_sav(k)) - r_prime * cos(phi_prime); 
            temp2 = data(windowindex).tonalMag(k) * sin(data(windowindex).phi_sav(k)) - r_prime * sin(phi_prime); 
            temp3 = data(windowindex).tonalMag(k) + abs(r_prime);

            if temp3 ~= 0.0
                data(windowindex).cm(k) = sqrt( temp1*temp1+temp2*temp2 ) / temp3;
            else
                data(windowindex).cm(k) = 0;
            end                           
        end               
    end

    if windowindex>2
        data(windowindex).energy = sum(abs(data(windowindex).tonalMag).^2); % energy
        data(windowindex).spectUnPred = sum((data(windowindex).cm).*abs(data(windowindex).tonalMag).^2); % weighted spectral unpredictability
        
        % energy time avarage
        if windowindex<orderTimeAverage
            energyTimeAvarage = sum([data(3:windowindex).energy])/(windowindex-2);
        else
            energyTimeAvarage = sum([data(windowindex-orderTimeAverage+1:windowindex).energy])/(orderTimeAverage);
        end
        
        % spectUnPred time avarage
        if windowindex<orderTimeAverage
            espectUnPredTimeAvarage = sum([data(3:windowindex).spectUnPred])/(windowindex-2);
        else
            spectUnPredTimeAvarage = sum([data(windowindex-orderTimeAverage+1:windowindex).spectUnPred])/(orderTimeAverage);
        end 
        
        % Tonal Index
        data(windowindex).TI=log(espectUnPredTimeAvarage/energyTimeAvarage);

    end
    end
    %data(windowindex).tonInd = mean(ti);    
end
