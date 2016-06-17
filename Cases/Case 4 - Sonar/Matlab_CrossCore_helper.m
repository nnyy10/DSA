
% Eksempel på skrivning af array til fil, som kan læses ind i CrossCore
signal= [0.1 0.2 0.3 0.4 0.5];
signalhex = mydec2hex(signal);
fid=fopen('minFil.dat', 'w');
for i=1:length(signalhex)-1,
    fprintf(fid, '%s,\n', signalhex{i});
end
fprintf(fid, '%s\n', signalhex{end});   % Uden ","-tegn
fclose(fid)



