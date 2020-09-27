function MakeDecayCurrentVideo(tau_span, decay_time, freq)

Image_Format = '.jpg';
Image_Folder = ['image\tau\decay_' num2str(decay_time) '\'];
outputname = ['Single_cell_decay_' num2str(decay_time)];
writerObj = VideoWriter([Image_Folder outputname '.mp4'],'MPEG-4');
writerObj.FrameRate = freq;
open(writerObj);

for i=1:length(tau_span)
	tau_val = tau_span(i);
    image_name = [Image_Folder 'tau_' num2str(tau_val) Image_Format];
    image = imread(image_name);
    writeVideo(writerObj, image);
end

close(writerObj);
end

