function [D,ID,img] = DECODE_AR_TAG(img,N)

D = zeros(N,N);
ID = 0;

[av,ah] = size(img);
x = 1;

for i = 1:N
    
   y = 1;
    for j = 1:N 
        D(j,i) = 1;
        p1 = int16(ah/(2*N));
        p2 = int16(av/(2*N));
        D(j,i) = img(y+p2,x+p1 );
        
        ID = ID + i*j*D(j,i);
        
        if D(j,i)
       
         img(y+int16(av/(2*N))-10:y+int16(av/(2*N))+10 , x+int16(ah/(2*N))-10:x+int16(ah/(2*N))+10) = zeros(21,21);
       
        else 
        
        img(y+int16(av/(2*N))-10:y+int16(av/(2*N))+10 , x+int16(ah/(2*N))-10:x+int16(ah/(2*N))+10) = ones(21,21);
      
        end
            
         y = y + int16(av/N);
    end
    
    x = x + int16(ah/N);

end


end

