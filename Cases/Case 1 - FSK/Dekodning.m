function z = Dekodning(x,fstart,fend,fs)

N = length(x);

ASCII60 = (60*(fend-fstart)/2^8)+fstart;    %Frequency for ASCII char 60
ASCII127 = (127*(fend-fstart)/2^8)+fstart;  %Frequency for ASCII char 127

f60=ASCII60*N/fs;
f127=ASCII127*N/fs;

z = zeros(1, N);

sig = 0; 
for k = round([f60:f127 N-f127:N-f60]);
    for n = 1:N    
    sig = sig + x(n)*exp((-2*pi*1i*k*n)/N);  %From definition.
    end
    z(k) = sig;   %Makes the bin number match with the FFT.
    sig = 0;
end

% %Plot used for debugging.
% figure(1)
% plot(abs(z));
% title('')
% xlabel('Frequency bins')
% ylabel('Amplitude')
return

