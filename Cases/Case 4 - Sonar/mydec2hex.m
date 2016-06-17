% function cellarr_hextal = mydec2hex( dectal )
%   N er bitformat - der arbejdes i two's complement format
function cellarr_hextal = mydec2hex( dectal )


if any(dectal < -1)  || any(dectal > 1 - 2^(-15)) ,
    disp('OBS: dectal skal være indenfor -1 <= dectal <= 1 - 2^(-15)');
    return
end

% N-bit format
N = 16;

% finde ud af hvad signbit'en er..
bNminus1 = dectal < 0; % signbit tændt når negative tal i dectal


% konverter til heltal
heltal = 2^(N-1) * (2*bNminus1 + dectal);

% rund til nærmest 16-bit heltal.. vigtigt hvis der ændres på N !
if N==8,
    heltal = uint8(heltal);
elseif N==16,
    heltal = uint16(heltal);
elseif N==32,
    heltal = uint32(heltal);
else
        disp('vælg N til 8,16 eller 32..')
        return
end


% konverter til hextal
for i=1:length(heltal),
    cellarr_hextal{i} = dec2hex(heltal(i));
end

% Tilsæt '0x' foran hver element.. (til VisualDSP)
for i=1:length(heltal),
    cellarr_hextal{i} = ['0x' cellarr_hextal{i}];
end
