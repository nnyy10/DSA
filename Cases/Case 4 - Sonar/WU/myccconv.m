function y = myccconv(x1,x2)

n1=length(x1);
n2=length(x2);

x2=fliplr(x2);

yy=zeros(1,n1+n2);

for n=1:n1+n2
   for m=1:n1
       if n-m < 1 || n-m > n2
            yy(n)=yy(n)+0;
       else
            yy(n)=yy(n)+(x1(m).*x2(n-m));
       end
        
   end
end
y=yy;
end

