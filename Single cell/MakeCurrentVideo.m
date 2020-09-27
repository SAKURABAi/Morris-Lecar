function MakeCurrentVideo(I_span, tau, freq)

Image_Format = '.jpg';
Image_Folder = ['image\tau_' num2str(tau) '_I_max\'];
outputname = ['Single_cell_tau_' num2str(tau) '_I_max'];
writerObj = VideoWriter([Image_Folder outputname '.mp4'],'MPEG-4');
writerObj.FrameRate = freq;
open(writerObj);

for i=1:length(I_span)
	I_val = I_span(i);
    image_name = [Image_Folder 'I_max_' num2str(I_val) Image_Format];
    image = imread(image_name);
    writeVideo(writerObj, image);
end

close(writerObj);
end

