clc;
clear all;
tol=1.0d-6;
er=1;
u=[0 0.25 0.5 0.75 1;0 0 0 0 0.75;
    0 0 0 0 0.5;0 0 0 0 .25;0 0 0 0 0]
u;
u1=u;
h=0.25;
n=5;
%i=2:5;
%u(i,1)=i;
%u(1,i)=i;
%u(4,1:4)=0;
%u(1:4,4)=0;

k=0;
while er>tol
   k=k+1;
for i=2:n-1
        for j=2:n-1
        u1(i,j)=(1/4)*(u(i-1,j)+u(i+1,j)+u(i,j-1)+u(i,j+1));
        %u(i,j)=(1/4)*(u(i-1,j)+u(i+1,j)+u(i,j-1)+u(i,j+1));
        end
        %siddle
        u(i,j)=u1(i,j);
end
er=sqrt(sum(sum(u1-u).^2));
u=u1;
u
end
