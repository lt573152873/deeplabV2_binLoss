#!/usr/bin/env python2
# -*- coding: utf-8 -*-
"""
Created on Tue Aug  1 17:00:05 2017

@author: pqzhuang
"""

import os
from scipy.io import loadmat as sio
import numpy as np
import PIL.Image as Image
import scipy.misc

#os.chdir('/home/dl/deeplab_v2/voc2012/features/deeplab_largeFOV/val/fc8/')
os.chdir('/home/lt/liuteng/deeplab_focalloss/deeplab_v2/doctor/features/deeplab_largeFOV/val/fc8/')
path=os.getcwd()
files=os.listdir(path)
labels_path=os.path.join(path,'labelsF')


#palette=[]
#for i in range(256):
#    palette.extend((i,i,i))
#palette[:3*2]=np.array([[255, 255, 255],
#                            [0, 0, 0]],dtype='uint8').flatten()



for afile in files:
    file_path=os.path.join(path,afile)
    if os.path.isfile(file_path):
        if os.path.getsize(file_path)==0:
            continue
        mat_idx=afile[:afile.find('.mat')]
        mat_file=sio(file_path)
        mat_file=mat_file['data']
        #lt
        label=mat_file.reshape(mat_file.shape[0],mat_file.shape[1])
	labels=mat_file.reshape(mat_file.shape[0],mat_file.shape[1])
	rows,clos = label.shape
	for i in range(rows):
		for j in range(clos):
			if(label[i,j]>=0.5):
				labels[i,j]=1
			else:
				labels[i,j]=0
        #label_img=Image.fromarray((labels*255).astype(np.uint8)) 
	#label_img=Image.fromarray(label).astype(np.float32)       
	# labels=np.argmax(mat_file,axis=2).astype(np.uint8)
        # label_img=Image.fromarray(labels.reshape(labels.shape[0],labels.shape[1]))
        # label_img.putpalette(palette)
        # label_img=label_img.transpose(Image.FLIP_LEFT_RIGHT)
        # label_img = label_img.rotate(90)
        dst_path=os.path.join(labels_path,mat_idx+'.png')
        # label_img.save(dst_path)
        scipy.misc.imsave(dst_path,label)
