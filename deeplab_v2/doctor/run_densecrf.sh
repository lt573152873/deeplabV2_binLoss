#!/bin/bash 

###########################################
# You can either use this script to generate the DenseCRF post-processed results
# or use the densecrf_layer (wrapper) in Caffe
###########################################
DATASET=doctor
LOAD_MAT_FILE=1

MODEL_NAME=deeplab_largeFOV

TEST_SET=val           #val, test

# the features  folder save the features computed via the model trained with the train set
# the features2 folder save the features computed via the model trained with the trainval set
FEATURE_NAME=features #features, features2
FEATURE_TYPE=fc8

# specify the parameters
MAX_ITER=0

Bi_W=4
Bi_X_STD=49
Bi_Y_STD=49
Bi_R_STD=5
Bi_G_STD=5 
Bi_B_STD=5

POS_W=3
POS_X_STD=3
POS_Y_STD=3


#######################################
# MODIFY THE PATY FOR YOUR SETTING
#######################################
#SAVE_DIR=/rmt/work/deeplab/exper/${DATASET}/res/${FEATURE_NAME}/${MODEL_NAME}/${TEST_SET}/${FEATURE_TYPE}/post_densecrf_W${Bi_W}_XStd${Bi_X_STD}_RStd${Bi_R_STD}_PosW${POS_W}_PosXStd${POS_X_STD}
#SAVE_DIR=/home/lt/liuteng/deep_lab/deeplab_v2/${DATASET}/res/${FEATURE_NAME}/${MODEL_NAME}/${TEST_SET}

SAVE_DIR=/home/lt/liuteng/deeplab_focalloss/deeplab_v2/${DATASET}/res/${FEATURE_NAME}/${MODEL_NAME}/${TEST_SET}/${FEATURE_TYPE}/post_densecrf_W${Bi_W}_XStd${Bi_X_STD}_RStd${Bi_R_STD}_PosW${POS_W}_PosXStd${POS_X_STD}

echo "SAVE TO ${SAVE_DIR}"

#CRF_DIR=/rmt/work/deeplab/code/densecrf
CRF_DIR=/home/lt/liuteng/deeplab_focalloss/deeplab_v2/deeplab-public-ver2/densecrf

#if [ ${DATASET} == "voc2012" ]
#then
   # IMG_DIR_NAME=pascal/VOCdevkit/VOC2012
     #IMG_DIR_NAME=/home/lt/liuteng/my_dataset/ophtha_ex/row-label
     #IMG_DIR_NAME=/home/lt/liuteng/my_dataset/isbi
     #IMG_DIR_NAME=/home/lt/liuteng/my_dataset/44
     IMG_DIR_NAME=/home/lt/liuteng/my_dataset/isbi_ex
#elif [ ${DATASET} == "coco" ]
#then
#    IMG_DIR_NAME=coco
#elif [ ${DATASET} == "voc10_part" ]
#then
#    IMG_DIR_NAME=pascal/VOCdevkit/VOC2012
#fi

# NOTE THAT the densecrf code only loads ppm images
IMG_DIR=${IMG_DIR_NAME}/PPMimg

#if [ ${LOAD_MAT_FILE} == 1 ]
#then
    # the features are saved in .mat format
    CRF_BIN=${CRF_DIR}/prog_refine_pascal_v4
    FEATURE_DIR=/home/lt/liuteng/deeplab_focalloss/deeplab_v2/${DATASET}/${FEATURE_NAME}/${MODEL_NAME}/${TEST_SET}/${FEATURE_TYPE}
#else
    # the features are saved in .bin format (has called SaveMatAsBin.m in the densecrf/my_script)
 #   CRF_BIN=${CRF_DIR}/prog_refine_pascal
    #FEATURE_DIR=/rmt/work/deeplab/exper/${DATASET}/${FEATURE_NAME}/${MODEL_NAME}/${TEST_SET}/${FEATURE_TYPE}/bin
  #  FEATURE_DIR=/home/lt/liuteng/deep_lab/deeplab_v2/${DATASET}/${FEATURE_NAME}/${MODEL_NAME}/${TEST_SET}/${FEATURE_TYPE}/bin	
#fi

mkdir -p ${SAVE_DIR}

# run the program
${CRF_BIN} -id ${IMG_DIR} -fd ${FEATURE_DIR} -sd ${SAVE_DIR} -i ${MAX_ITER} -px ${POS_X_STD} -py ${POS_Y_STD} -pw ${POS_W} -bx ${Bi_X_STD} -by ${Bi_Y_STD} -br ${Bi_R_STD} -bg ${Bi_G_STD} -bb ${Bi_B_STD} -bw ${Bi_W}

