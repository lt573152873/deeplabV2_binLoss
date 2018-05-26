% save jpg images as bin file for cpp
%
is_server = 1;

dataset = 'doctor';  %'coco', 'voc2012'

if is_server
  if strcmp(dataset, 'doctor')
    %img_folder  = '/home/lt/liuteng/my_dataset/ophtha_ex/row-label/img';
    %img_folder  = '/home/lt/liuteng/my_dataset/isbi/img';
    %img_folder  = '/home/lt/liuteng/my_dataset/44/img';
    img_folder  = '/home/lt/liuteng/my_dataset/isbi_ex/img';
    %save_folder = '/home/lt/liuteng/my_dataset/ophtha_ex/row-label/PPMimg';
    %save_folder = '/home/lt/liuteng/my_dataset/isbi/PPMimg';
    save_folder = '/home/lt/liuteng/my_dataset/44/PPMimg';
    save_folder = '/home/lt/liuteng/my_dataset/isbi_ex/PPMimg'
  elseif strcmp(dataset, 'coco')
    img_folder  = '/rmt/data/coco/JPEGImages';
    save_folder = '/rmt/data/coco/PPMImages';
  end
else
  img_folder = '../img';
  save_folder = '../img_ppm';
end

if ~exist(save_folder, 'dir')
    mkdir(save_folder);
end

img_dir = dir(fullfile(img_folder, '*.jpg'));

for i = 1 : numel(img_dir)
    fprintf(1, 'processing %d (%d)...\n', i, numel(img_dir));
    img = imread(fullfile(img_folder, img_dir(i).name));
    
    img_fn = img_dir(i).name(1:end-4);
    save_fn = fullfile(save_folder, [img_fn, '.ppm']);
    
    imwrite(img, save_fn);   
end
    
