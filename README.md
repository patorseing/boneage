# boneage
This project is developed as the project in ITCS476_Digital Image Processing (Mj.DB) that professor in class give the scope to us to set up the project and try to use image processing concept and creating gui to call the method that apply the concept.
the feature is used in this project is Local binary patterns (LBP).
run on Matlab that you have to install Computer vision system toolbox (addon)

##GUI
### Window OS
![Window](https://github.com/patorseing/boneage/blob/master/snapshot/Capture.JPG)
### Mac OS
![Window](https://github.com/patorseing/boneage/blob/master/snapshot/Screen%20Shot%202561-12-02%20at%2013.51.05.png)
------
1. it is for getting image both multi and single
    1.1 select the model function to import a image or folder that contain images and that folder have to csv that descript those images.
    the data is can download on [data](https://drive.google.com/drive/folders/1kUtBlb4Ls7dTuarzdGcCLlmjXLOtBmLF?usp=sharing)
    - train data: boneage-training-dataset
    in the drive, there are sample test data folder that you can try
    - test 1
    - test 2
    - test 3
    1.2 click get button and 

2. when you are already import the data to program you can select folder to test in 2.1 and click test NN on 2.2
** the result of the 2. is in "resultNN.csv" the will record the result every time that you use with average of reliability in the time**

3. In this panel, you need to import 2 dataset (boneage-training-dataset & test 1,2,3) in point 1 that euclidean distance will compare data that you select in 3.1 with 3.2 that 
    3.1 is the tarin data
    3.2 is the test test data that you want to know the predicted age
** the result of the 3. is in "resultEU.csv" the will record the result every time that you use with average of reliability in the time**