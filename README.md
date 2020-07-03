# Vitis-AI-1.1 Design Flow for Ultra96
## Quick Start

1. Clone Xilinx’s Vitis-AI github repository: 
 

```
$ git clone https://github.com/Xilinx/Vitis-AI
$ cd Vitis-AI
$ export VITIS_AI_HOME="$PWD"

```
 
2. Download the pre-trained models from the Xilinx Model Zoo:
 
```
$ cd $VITIS_AI_HOME/AI-Model-Zoo
$ source ./get_model.sh 
```
 
3.Download the DPU-TRD directory for your platform:
 
```
$ git clone https://github.com/JinChen-tw/Vitis-AI-1.1-Flow-for-Ultra96
$ mv Vitis-AI-1.1-Design-Flow-for-Ultra96V2/DPU-TRD-ULTRA96/ .
$ export TRD_HOME=$VITIS_AI_HOME/DPU-TRD-ULTRA96
```

4. Launch the tools docker from the Vitis-AI directory 
```
$ cd $VITIS_AI_HOME
$ sh -x docker_run.sh xilinx/vitis-ai 
```
\ \    / (_) | (_)            /\   |_   _|
 \ \  / / _| |_ _ ___ ______ /  \    | |  
  \ \/ / | | __| / __|______/ /\ \   | |  
   \  /  | | |_| \__ \     / ____ \ _| |_ 
    \/   |_|\__|_|___/    /_/    \_\_____|

==========================================

Docker Image Version: latest
Build Date: Fri Jul  3 03:54:48 MDT 2020
VAI_ROOT=/opt/vitis_ai
For TensorFlow Workflows do:
  conda activate vitis-ai-tensorflow
For Caffe Workflows do:
  conda activate vitis-ai-caffe
For Neptune Workflows do:
  conda activate vitis-ai-neptune
More detail on conda packages included in container: /opt/vitis_ai/conda/conda_packages.txt
More detail on other 3rd party package source included in container: https://www.xilinx.com/products/design-tools/guest-resources.html
jin2@ubuntu:/workspace$
```
$ conda activate vitis-ai-caffe
(vitis-ai-caffe) $ cd DPU-TRD-ULTRA96
(vitis-ai-caffe) $ cd modelzoo

```  
Create a directory for the compiled models
```
(vitis-ai-caffe) $ mkdir compiled_output
```
 
Compile the caffe model for the resnet50 application, using the generic script that you downloaded:
```
(vitis-ai-caffe) $ source ./compile_cf_model.sh resnet50 cf_resnet50_imagenet_224_224_7.7G
```

Kernel topology "resnet50_kernel_graph.jpg" for network "resnet50"
kernel list info for network "resnet50"
                               Kernel ID : Name
                                       0 : resnet50_0
                                       1 : resnet50_1

                             Kernel Name : resnet50_0
--------------------------------------------------------------------------------
                             Kernel Type : DPUKernel
                               Code Size : 0.87MB
                              Param Size : 24.35MB
                           Workload MACs : 7715.95MOPS
                         IO Memory Space : 2.25MB
                              Mean Value : 104, 107, 123, 
                      Total Tensor Count : 56
                Boundary Input Tensor(s)   (H*W*C)
                               data:0(0) : 224*224*3

               Boundary Output Tensor(s)   (H*W*C)
                             fc1000:0(0) : 1*1*1000

                        Total Node Count : 55
                           Input Node(s)   (H*W*C)
                                conv1(0) : 224*224*3

                          Output Node(s)   (H*W*C)
                               fc1000(0) : 1*1*1000
                             Kernel Name : resnet50_1
--------------------------------------------------------------------------------
                             Kernel Type : CPUKernel
                Boundary Input Tensor(s)   (H*W*C)
                               prob:0(0) : 1*1*1000

               Boundary Output Tensor(s)   (H*W*C)
                               prob:0(0) : 1*1*1000

                           Input Node(s)   (H*W*C)
                                    prob : 1*1*1000

                          Output Node(s)   (H*W*C)
                                    prob : 1*1*1000

 


Compile the tensorflow models, using the generic script:
 
```
$ conda activate vitis-ai-tensorflow
(vitis-ai-tensorflow) $ source ./compile_tf_model.sh tf_resnet50 tf_resnetv1_50_imagenet_224_224_6.97G
```
Kernel topology "tf_resnet50_kernel_graph.jpg" for network "tf_resnet50"
kernel list info for network "tf_resnet50"
                               Kernel ID : Name
                                       0 : tf_resnet50_0
                                       1 : tf_resnet50_1

                             Kernel Name : tf_resnet50_0
--------------------------------------------------------------------------------
                             Kernel Type : DPUKernel
                               Code Size : 0.79MB
                              Param Size : 24.35MB
                           Workload MACs : 6964.51MOPS
                         IO Memory Space : 2.25MB
                              Mean Value : 0, 0, 0, 
                      Total Tensor Count : 59
                Boundary Input Tensor(s)   (H*W*C)
                              input:0(0) : 224*224*3

               Boundary Output Tensor(s)   (H*W*C)
         resnet_v1_50_logits_Conv2D:0(0) : 1*1*1000

                        Total Node Count : 58
                           Input Node(s)   (H*W*C)
            resnet_v1_50_conv1_Conv2D(0) : 224*224*3

                          Output Node(s)   (H*W*C)
           resnet_v1_50_logits_Conv2D(0) : 1*1*1000

                             Kernel Name : tf_resnet50_1
--------------------------------------------------------------------------------
                             Kernel Type : CPUKernel
                Boundary Input Tensor(s)   (H*W*C)
        resnet_v1_50_SpatialSqueeze:0(0) : 1*1*1000

               Boundary Output Tensor(s)   (H*W*C)
   resnet_v1_50_predictions_Softmax:0(0) : 1*1*1000

                           Input Node(s)   (H*W*C)
             resnet_v1_50_SpatialSqueeze : 1*1*1000

                          Output Node(s)   (H*W*C)
        resnet_v1_50_predictions_Softmax : 1*1*1000


Exit the tools docker
```
(vitis-ai-caffe) $ exit
```
 
 


