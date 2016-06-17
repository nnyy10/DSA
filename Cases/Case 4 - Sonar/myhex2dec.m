function dectal = myhex2dec( cellarr_hextal )
% OBS: hextal skal være indenfor 0x0000 til 0xffff
% - svarende til 0 <= heltal <= 2^(16)-1

for i=1:length(cellarr_hextal),
    if ischar(cellarr_hextal),
        hextal = cellarr_hextal;
        enkelt = 1;
    else
        hextal = cellarr_hextal{i};
        enkelt = 0;
    end
    
    hextal(1:2) = [];   % Fjerner '0x'

    % N-bit format
    N = 16;

    % konverter til heltal
    heltal = hex2dec(hextal);   % indbygget matlab

    % finde ud af hvad signbit'en er..
    if heltal >= 2^(N-1),
        bNminus1 = 1; % signbit tændt
    else
        bNminus1 = 0;
    end

    dectal(i) = heltal * 2^(1-N) - 2*bNminus1;
    if enkelt, return, end
end


