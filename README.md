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
$ tar -xvzf Vitis-AI-1.1-Flow-for-Ultra96.tar.gz
$ export TRD_HOME=$VITIS_AI_HOME/DPU-TRD-ULTRA96
```

4. Launch the tools docker from the Vitis-AI directory 
```
$ cd $VITIS_AI_HOME
$ sh -x docker_run.sh xilinx/vitis-ai 
$ conda activate vitis-ai-caffe
(vitis-ai-caffe) $ 
(vitis-ai-caffe) $ cd DPU-TRD-ULTRA96
```
 
Use the dlet tool to generate your.dcf file
```
(vitis-ai-caffe) $ dlet -f ULTRA96V2.hwh

```
 
Rename this file to ULTRA96V2.dcf
 
```
(vitis-ai-caffe) $ mv dpu*.dcf {platform}.dcf
```
 

Create a file named “custom.json” with the following content
```
{"target": "dpuv2", "dcf": "./{platform}.dcf", "cpu_arch": "arm64"}
```
 
 
Create a directory for the compiled models
```  
(vitis-ai-caffe) $ mkdir compiled_output
```
Create a generic recipe for compiling a caffe model, by creating a script named “compile_cf_model.sh” with the following content 

