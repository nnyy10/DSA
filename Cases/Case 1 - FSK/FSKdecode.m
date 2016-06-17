

function string = FSKdecode(fstart, fend, Tsymbol, fs, x)

    string = []; freqArray=[];
    
    Nsymbol = round((length(x)/fs)/Tsymbol);    % calculate number of symbols received
    
    
for count=0:Nsymbol-1,
    
    xCurrent = x(round((count*Tsymbol*fs+1):((count*Tsymbol*fs)+Tsymbol*fs)));     % deterines which part of signal x we anaylize

    %y = Dekodning(xCurrent,fstart,fend,fs);      % Our DFT function
    
    y = fft(xCurrent);
    
    y = abs(y);
    
    y = y(1:length(y)/2);
    
    max_y = max(y);     % finding a peak-value where a frequency is located 
    
    freq = find(y == max_y,1);     % finding the corresponding x-value which is the frequency-value
    
    freq = freq/Tsymbol;
    
    ascii = ceil(((freq-fstart)/((fend-fstart)/256)));      % converts from frequency to ascii
    
    string = [string char(ascii)];
end
return



