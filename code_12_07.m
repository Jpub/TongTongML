n=100; x=randn(n,1); y=randn(n,1); y(n)=5;
hhs=2*[1 5 10].^2; m=5;
x2=x.^2; xx=repmat(x2,1,n)+repmat(x2',n,1)-2*x*x';
y2=y.^2; yx=repmat(y2,1,n)+repmat(x2',n,1)-2*y*x';
u=floor(m*[0:n-1]/n)+1; u=u(randperm(n));

for hk=1:length(hhs)
	hh=hhs(hk); k=exp(-xx/hh); r=exp(-yx/hh);
  for i=1:m
		g(hk,i)=mean(k(u==i,:)*KLIEP(k(u~=i,:),r));
end, end
[gh,ggh]=max(mean(g,2)); HH=hhs(ggh);
k=exp(-xx/HH); r=exp(-yx/HH); s=r*KLIEP(k,r);

figure(1); clf; hold on; plot(y,s,'rx');


function a=KLIEP(k,r)

si = size(k,2)
a0 = rand(si,1);
b=mean(r)'; 
c=sum(b .^ 2);
for o=1:1000
	a=a0+0.01*k'*(1./k*a0); a=a+b*(1-sum(b.*a))/c;
	a=max(0,a); a=a/sum(b.*a);
	if norm(a-a0)<0.001, break, end
	a0=a;
end
end
