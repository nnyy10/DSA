function y = mycc(x1,x2)

n1=length(x1);
n2=length(x2);

x2=fliplr(x2);

y=conv(x1,x2);
end