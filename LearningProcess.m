function [ weights ] = LearningProcess(num_unit, side_pixels, image_base, num_image,meangrey)
%LEARNINGPROCESS simulates the learning process of the network according to
%Sanger's rule

%num_unit       Number of output units in the network.
%side_pixels    Number of pixels in a side of the presented images.
%image_base     The database of images to be sampled from.
%num_image      Number of images in the database.
%meangrey       The mean grey level of 20000 samples of the given size from
%               the database. 

%Initialise weights so that the sum of the squares is approximately 1.
weights=0.06*(rand(num_unit,side_pixels^2)-0.5);

learn_rate=1;
for time=1:120000
    %Select 64x64 piece of image from database.
    image_no=randi(num_image);
    image_x=randi(257-side_pixels);
    image_y=randi(257-side_pixels);
    image=image_base(image_x:image_x+side_pixels-1,image_y:image_y+side_pixels-1,image_no);
    %Subtract mean grey level
    image=image-meangrey;
    %Mask the image with a Gaussian.
    image=image.*Gaussian(side_pixels);
    %Reshape image matrix into a vector.
    image_vec=reshape(image,side_pixels^2,1);
    %Normalise the image vector to have unit length.
    image_vec=image_vec/norm(image_vec);
    %Update weights.
    weights=sagerupdate( image_vec, weights, learn_rate );
    
    %Change learning rate every 20000 presentations.
    if mod(time,20000)==0
        learn_rate=learn_rate/2;
    end
end

end
