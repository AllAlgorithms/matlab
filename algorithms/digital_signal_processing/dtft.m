
w=0:0.01:4*pi;
n=0:8;
data=[0 0 1 1 1 1 0 0];
for i=1:length(w)
    X(i)=0;
    for k=1:length(data)
          X(i)=X(i)+data(k).*exp(-1i.*w(i).*n(k));
      end
end

magnitude= zeros(1,length(X));
for p= 1:length(X)
    magnitude(p)= sqrt(real(X(p))^2 + imag(X(p))^2);
    
end
phase= zeros(1,length(X));
for q= 1:length(X)
    phase(q)= angle(X(q));
    
end


subplot(2,1,1);
plot(w,magnitude);
xlabel('w')
ylabel('Amplitude')


subplot(2,1,2); 
plot(w,phase);
xlabel('w')
ylabel('Angle')



