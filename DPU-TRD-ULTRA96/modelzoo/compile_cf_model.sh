model_name=$1
modelzoo_name=$2
vai_c_caffe \
--prototxt ../../AI-Model-Zoo/models/${modelzoo_name}/quantized/deploy.prototxt \
--caffemodel ../../AI-Model-Zoo/models/${modelzoo_name}/quantized/deploy.caffemodel \
--arch ./custom.json \
--output_dir ./compiled_output/${modelzoo_name} \
--net_name ${model_name} \
--options "{'mode': 'normal'}"
