# YOLOv5 Documentation

According to this [LINK](https://docs.ultralytics.com/tutorials/nvidia-jetson), the document created


## JatPack version 4.6.1
## Install DeepStream 6.0.1 for Jetson

### Install Necessary Packages

* Create envorment:

```bash
python3 -m venv venv
source venv/bin/activate
```

* step 1: Access the terminal of Jetson device, install pip and upgrade it

```bash
sudo apt update

sudo apt install -y python3-pip

pip3 install --upgrade pip
```


If does'nt work above command try this

```bash
apt-get remove python-pip python3-pip

wget https://bootstrap.pypa.io/get-pip.py

python3 get-pip.py
```

* step 2: Clone the following repo
```bash
git clone https://github.com/ultralytics/yolov5
```

* step 3:  install the below dependency

```bash
sudo apt install -y libfreetype6-dev
```

* step 4: installing matplotlib

```bash
pip install --upgrade pip setuptools wheel
pip install numpy==1.19.4
pip install matplotlib
```

* step 5: Install the necessary packages

```bash
pip3 install -r requirements.txt
```

## DeepStream Configuration for YOLOv5

* step 1: Clone the following repo

```bash
cd ~

git clone https://github.com/marcoslucianops/DeepStream-Yolo
```

* Step 2. Copy gen_wts_yoloV5.py from DeepStream-Yolo/utils into yolov5 directory

```bash
cp DeepStream-Yolo/utils/gen_wts_yoloV5.py yolov5
```

* Step 3. Inside the yolov5 repo, download pt file from YOLOv5 releases (example for YOLOv5s 6.1)

```bash
cd yolov5

wget https://github.com/ultralytics/yolov5/releases/download/v6.1/yolov5s.pt
```

* Step 4. Generate the cfg and wts files

```bash
python3 gen_wts_yoloV5.py -w yolov5s.pt
```

* Step 5. Copy the generated cfg and wts files into the DeepStream-Yolo folder

```bash
cp yolov5s.cfg ~/DeepStream-Yolo

cp yolov5s.wts ~/DeepStream-Yolo
```

* Step 6. Open the DeepStream-Yolo folder and compile the library

```bash
cd ~/DeepStream-Yolo

CUDA_VER=10.2 make -C nvdsinfer_custom_impl_Yolo
```
 
* Step 7. Edit the config_infer_primary_yoloV5.txt file according to your model

```bash
[property]

...

custom-network-config=yolov5s.cfg

model-file=yolov5s.wts

...
```

* Step 8. Edit the deepstream_app_config file

```bash
...

[primary-gie]

...

config-file=config_infer_primary_yoloV5.txt
```

* Step 9. Change the video source in deepstream_app_config file. Here a default video file is loaded as you can see below

```bash
...

[source0]

...

uri=file:///opt/nvidia/deepstream/deepstream/samples/streams/sample_1080p_h264.mp4
```

## Run the Inference

```bash
deepstream-app -c deepstream_app_config.txt
```