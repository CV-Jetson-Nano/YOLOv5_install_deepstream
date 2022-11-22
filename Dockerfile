FROM deepstream

WORKDIR /root

RUN python3 -m venv venv
RUN source venv/bin/activate

RUN apt update \
sudo apt install -y python3-pip \
pip3 install --upgrade pip

RUN git clone https://github.com/ultralytics/yolov5

RUN sudo apt install -y libfreetype6-dev

RUN pip install --upgrade pip setuptools wheel \
pip install numpy==1.19.4 \
pip install matplotlib 

RUN pip3 install -r requirements.txt

RUN cd ~ \
git clone https://github.com/marcoslucianops/DeepStream-Yolo

RUN cp DeepStream-Yolo/utils/gen_wts_yoloV5.py yolov5

RUN cp DeepStream-Yolo/utils/gen_wts_yoloV5.py yolov5

RUN python3 gen_wts_yoloV5.py -w yolov5s.pt

RUN cp yolov5s.cfg ~/DeepStream-Yolo \
cp yolov5s.wts ~/DeepStream-Yolo

RUN cd ~/DeepStream-Yolo \
CUDA_VER=10.2 make -C nvdsinfer_custom_impl_Yolo

