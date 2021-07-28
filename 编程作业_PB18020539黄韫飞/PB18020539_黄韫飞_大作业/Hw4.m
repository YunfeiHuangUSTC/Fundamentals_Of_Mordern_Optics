% 4f system in fourier optics to detect the edge of a picture
clear,clc,clf
Figure=im2double(imread('USTC.jpg'));
Input(:,:)=sqrt(Figure(:,:,1));
Input=Input/max(max(Input));
nfig=length(Input);
lambda=1;f=1500;stepxy=1;k=2*pi/lambda;nscreen=nfig;
A=[1,1,1;1,-8,1;1,1,1];
H=fftshift(fft2(A,nscreen,nscreen));
x=-(nscreen/2):stepxy:(nscreen/2-stepxy);y=x';
[XX,YY]=meshgrid(x,y);
r=sqrt(XX.^2+YY.^2);
Screen=zeros(nscreen,nscreen);
Screen((nscreen-nfig)/2+1:(nscreen+nfig)/2,(nscreen-nfig)/2+1:(nscreen+nfig)/2)=Input;
U1=RSDiff(f,x,k,Screen);
Phi=exp(-1i*k*r.^2/(2*f));
imshow(abs(U1).^2)
U11=U1.*Phi;
U2=RSDiff(f,x,k,U11);
figure;
imshow(abs(U2).^2);
U22=U2.*H;
figure;
imshow(abs(U22).^2)
U23=RSDiff(f,x,k,U22);
U24=U23.*Phi;
U3=RSDiff(f,x,k,U24);
figure;
imshow(abs(U3).^2);
figure;
imshow(abs(conv2(Input,A,'same')).^2);