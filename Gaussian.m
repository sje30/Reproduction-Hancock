function [ array ] = Gaussian( size )
%GAUSSIAN creates a size by size array with gaussian values centred in the
%middle.

sigma=size*5/32;

array=zeros(size,size);
x0=(size/2)+0.5;
y0=x0;

for x=1:size
    for y=1:size
        array(x,y)=exp(-((x-x0)^2+(y-y0)^2)/(2*sigma^2));
    end
end


end

