
                                             readme.txt


This package provides information on how to generate the anchor results for object tracking using TVD dataset as 
described in MPEG contribution m57470 "[VCM] TVD dataset for object tracking"


---------------------------------------------------------------
Part 0: Software Environment

Operating system: Ubuntu 18.04.5 LTS
Nvidia Driver version: 470.82.00
CUDA: 11.3.1
Python: 3.8.12
Torch: 1.10.0
Detectron2: 0.4
VTM 12.0 
FFMPEG: 4.2.2


Install Towards-Realtime-MOT package (commit 5c88bd53):
  https://github.com/Zhongdao/Towards-Realtime-MOT

Install py-motmetrics (commit 6597e8a4):
  https://github.com/cheind/py-motmetrics


----------------------------------------------------------------
Part 1: Download data

Downlaod the TVD Video Sequences with Annotations for Object tracking from https://multimedia.tencent.com/resources/tvd
Unzip the downloaded zip file, i.e, TVD_object_tracking_dataset_and_annotations.zip and change directory to the folder: 
TVD_object_tracking_dataset_and_annotations

(1) Convert the mp4 to png image 
    ffmpeg -i TVD-01.mp4 -vsync 0 -pix_fmt rgb24 TVD-01/%06d.png
	ffmpeg -i TVD-02.mp4 -vsync 0 -pix_fmt rgb24 TVD-02/%06d.png
	ffmpeg -i TVD-03.mp4 -vsync 0 -pix_fmt rgb24 TVD-03/%06d.png

(2)  Convert each png to yuv420 format

    ffmpeg -i inputPNG_filename -vf "pad=ceil(iw/2)*2:ceil(ih/2)*2" pdfFilename
    ffmpeg -i padFilename -f rawvideo -pix_fmt yuv420p -dst_range 1 yuvFilename
	
Note that concat_yuv.sh can be used to concatenate per-frame yuv file into a multiple-frame yuv file. In addition, the padding step can be ignored since we only consider 100% case and the image width and height are even.

(3) Concatenate individual yuv into one yuv file for each video sequence. 

Note that the folder TVD_object_tracking_dataset_and_annotations holds the ground truth data together with uncompressed source images
Its directory structure will be as follows:

/TVD_object_tracking_dataset_and_annotations
      /TVD-01
             /gt
             /img1
              seqinfo.ini
      /TVD-02
             /gt
             /img1
              seqinfo.ini
      /TVD-03
             /gt
             /img1
              seqinfo.ini



Part 2. Encoding and decoding operations 

(1) Encode the yuv file using VTM12.0. The script is as following:

VTM-12.0-encoder -c encoder_randomaccess_vtm.cfg --InputFile=TVD-01.yuv --BitstreamFile=TVD-01.bin --SourceWidth=1920 --SourceHeight=1080 --QP=22 --FrameSkip=0 --FramesToBeEncoded=3000 --IntraPeriod=64 --FrameRate=50 --InputBitDepth=8 --ReconFile=/dev/null --PrintHexPSNR -v 6 -dph 1 --ConformanceWindowMode=1

Note that the IntraPeriod is set to 64 and the GOPSize=32 as defined in  encoder_randomaccess_vtm.cfg
         For TVD-01 and TVD-03, QP=22, 27, 32, 37, 42, 47
         For TVD-02,            QP=42, 46, 50, 54, 58, 62

(2) decode the bin file
    VTM-12.0-decoder -i inputBinFilename -o decodedYUVFilename
	
(3) Split the multiple-frame yuv file into per-frame yuv files and convert the yuv into png format:
    ffmpeg -f rawvideo -s 1920x1080 -pix_fmt yuv420p10le -i yuvFileName -frames 1 -pix_fmt rgb24 outputPNGFilename  

Note that the genearted PNG files are put into the a folder with the following structure

/base_folder
      /TVD-01
             /img1
              seqinfo.ini
      /TVD-02
             /img1
              seqinfo.ini
      /TVD-03
             /img1
              seqinfo.ini

All the PNG files for TVD-01 sequences will be put under /base_folder/TVD-01/img1
All the PNG files for TVD-02 sequences will be put under /base_folder/TVD-03/img1
All the PNG files for TVD-03 sequences will be put under /base_folder/TVD-03/img1
We also need copy seqinfo.ini from the ground truth folder for each sequence. 

Note that in order to generate summary MOTA score including TVD-01, TVD-02 and TVD-03 sequences, we need put the png files for TVD-01 and TVD-03 sequence with  a giving QP value and the png files for TVD-02 with the corresponding QP value into the same base folder. For example, QP = {22, 27, 32, 37, 42, 47} for TVD-01 and TVD-03 correspond to QP= {42, 46, 50, 54, 58, 62} for TVD-02, respectively.

Part 3. Generate object tracking results

(1) Clone the following repository and follow the instruction to setup the environment. 

https://github.com/Zhongdao/Towards-Realtime-MOT


(2) Assume the folder name is: /Towards-Realtime-MOT

Put tvd_track.py in the curent package and run_tvd_track.sh into /Towards-Realtime-MOT.    Note that you need modify the following part of code to point to the right folder in your local machine: 
---------------------------------------------------
    if opt.test_case == 'uncompressed':
        data_root = '/data/Datasets/TVD/train'
        exp_name = opt.test_case
        output_root = '/data/wgao/dataset/TVD'
    else:
        data_root = '/data/wgao/SoftwareDev/vvc_inter_tool/png/TVD/{0}/scale{1}/QP{2}'.format(opt.test_case, opt.scale, opt.qp)
----------------------------------------------------

Here the data_root is the same as the base_folder of the uncompressed or compressed images for TVD video sequences. 

Part 4. MOTA evaluation

For MOTA evaluation, you need clone the repository https://github.com/cheind/py-motmetrics.git

Assume the folder is /py-motmetrics

Put the following three files in the current package into  /py-motmetrics/motmetrics/apps

  run_evaluateTracking_TVD.sh
  seqmap_TVD.txt
  evaluateTracking_TVD.py

note that you need modify the following part in evaluateTracking_TVD.py 

------------------
  parser.add_argument('--groundtruths', type=str, default = '/data/Datasets/TVD/train', help='Directory containing ground truth files.')
------------------

to point to the base_folder of ground truth data and specify the based_folder for the test case using the option  --tests  

please refer to run_evaluateTracking_TVD.sh as an example.

Note that based folder structure for test case should be the same as the base_folder for the ground truth. However, you don't need copy ground truth data in the test case folder. 


