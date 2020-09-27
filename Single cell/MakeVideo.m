function MakeVideo(param_span, freq, param_name)

Image_Format = '.jpg';
Image_Folder = ['image\' param_name '\'];
outputname = ['Single_cell_' param_name];
writerObj = VideoWriter([Image_Folder outputname '.mp4'],'MPEG-4');
writerObj.FrameRate = freq;
open(writerObj);

for i=1:length(param_span)
	param_val = param_span(i);
    image_name = [Image_Folder param_name '_' num2str(param_val) Image_Format];
    image = imread(image_name);
    writeVideo(writerObj, image);
end

close(writerObj);
end

