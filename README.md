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
![](./images/image001.PNG)
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
![](./images/image002.PNG)




Compile the tensorflow models, using the generic script:
 
```
$ conda activate vitis-ai-tensorflow
(vitis-ai-tensorflow) $ source ./compile_tf_model.sh tf_resnet50 tf_resnetv1_50_imagenet_224_224_6.97G
```
![](./images/image003.PNG)


Exit the tools docker
```
(vitis-ai-caffe) $ exit
```

### Compile the DNNDK based AI Applications

1. Change to the DPU-TRD-ULTRA96 work directory.
```
(vitis-ai-caffe) $ exit
```


2. Download and install the SDK for cross-compilation, specifying a unique and meaningful installation destination (knowing that this SDK will be specific to the Vitis-AI 1.1 DNNDK samples)

```
$ wget -O sdk.sh https://www.xilinx.com/bin/public/openDownload?filename=sdk.sh
$ chmod +x sdk.sh
$ ./sdk.sh -d ~/petalinux_sdk_vai_1_1_dnndk
```
3. Setup the environment for cross-compilation

```
$ unset LD_LIBRARY_PATH
$ source ~/petalinux_sdk_vai_1_1_dnndk/environment-setup-aarch64-xilinx-linux
```
4. Download and extract the additional DNNDK runtime content to the previously installed SDK
```
$ wget -O vitis-ai_v1.1_dnndk.tar.gz  https://www.xilinx.com/bin/public/openDownload?filename=vitis-ai_v1.1_dnndk.tar.gz
$ tar -xvzf vitis-ai-v1.1_dnndk.tar.gz
```
5. Install the additional DNNDK runtime content to the previously installed SDK

$ cd vitis-ai-v1.1_dnndk
$ ./install.sh $SDKTARGETSYSROOT
6. Make a working copy of the “vitis_ai_dnndk_samples” directory.
```
$ cp -r ../mpsoc/vitis_ai_dnndk_samples .
```
7. Download and extract the additional content (images and video files) for the DNNDK samples.
```
$ wget -O vitis-ai_v1.1_dnndk_sample_img.tar.gz https://www.xilinx.com/bin/public/openDownload?filename=vitis-ai_v1.1_dnndk_sample_img.tar.gz
$ tar -xvzf vitis-ai_v1.1_dnndk_sample_img.tar.gz
```

#### RESNET50

11. For the resnet50 application, create a model directory and copy the dpu_*.elf model files we previously built

$ cd $TRD_HOME/vitis_ai_dnndk_samples/resnet50
$ mkdir model_for_{platform}
$ cp ../../modelzoo/compiled_output/cf_resnet50_imagenet_224_224_7.7G/dpu_*.elf model_for_{platform}/.
12. For the resnet50 application, copy the “model_for_{platform}” directory to “model”, then run the “make” command

$ cp -r model_for_{platform} model
$ make
 
 


