# CapstoneDesign2

### Software Environment

* Operating system : Windows 11 22H2 build 22621.819
* Nvidia Driver version : 516.94.00
* CUDA: 11.7
* Python: 3.8.12
* Torch: 1.10.0
* Detectron2: 0.4
* FFMPEG: 4.2.2

Install Towards-Realtime-MOT package (commit 5c88bd53):
  https://github.com/Zhongdao/Towards-Realtime-MOT

Install py-motmetrics (commit 6597e8a4):
  https://github.com/cheind/py-motmetrics
  
Downloads dataset
  https://multimedia.tencent.com/resources/tvd

# Video Compression for Object Tracking

## 연구배경

  CCTV, 자율자동자의 센서, 제조 공정상에서의 불량 검출 등, 영상이 사용되는 곳은 점점 늘어나고 있다. 이러한 영상을 원본 그대로 처리하는 것은 정확도를 높일 수는 있지만, 저장 공간의 한계, 전송 대역폭의 한계 등 여러 요소로 인해 비효율 적이다. 따라서 이러한 영상을 압축하고 전송 후 처리부에서 수신을 하고 압축을 해제하여 영상을 용도에 맞게 처리하는 것이 일반적이다.
이러한 과정을 위해 원본 영상을 사용하는 것이 아닌, 영상자체를 압축하여 전송하거나 영상에서 여러 Feature를 추출하여 이를 이용하여 압축하고 전송하면 process의 정확도를 많이 낮추지 않는 선에서 데이터의 크기를 줄여 전송할 수 있다.

  또한 위와 같은 task를 수행하는 주체는 Neural Net 기반의 Detector, Tracker 등등 사람이 아니라 기계인 경우가 많아지고 있다. 사람을 위해 영상을 압축하는 것이 아닌 기계를 위한 압축, VCM(Video Coding for Machine)의 중용성이 대두되고 있다.


## 관련연구

* Object Detection
>
> Object detection은 일반적으로 Classification과 Localization이 같이 수행된 것을 의미한다. 입력된 영상에서 유의미한 특정 객체를 감지하는 것으로서, 시각적으로는 아래 그림과 같이 Bounding box를 이미지 위에 덧 그려서 표시하고, 그 Object의 Classification 결과를 같이 표시하여 나타낸다. 아래와 같이 한 영상에 여러 Object가 있을 수 있다.
> 
> ![image](https://user-images.githubusercontent.com/112960519/205511072-884f4c80-0f66-4fa4-ba44-6e856163da4e.png)
> 
> Detectron2를 이용한 Object detection 예시
>
>

* Object Tracking
>
> Object tracking은 입력된 영상으로부터 Object를 추적하는 것이다. Object가 변형이 일어나도 계속 추적할 수 있어야 한다. 예를 들어 걷고 있는 사람의 형태는 정지된 영상과는 다르게 팔, 다리도 계속 움직이고 경우에 따라서 몸의 측면이 보이다가 정면이 보일수도 있고 걷는 도중 주변의 여러 물체에 의해 신체의 일부가 가려질 수도 있다. 이러한 상황들에 대해서도 지속적인 추적이 이루어 지도록 한 것이 Object tracking이다. 
> 
> ![image](https://user-images.githubusercontent.com/112960519/205511213-0a77780b-1d83-455c-bb28-8d152750f64a.png) 
> 
> TVD-01 Object tracking 예시, 60번째 프레임과 50번째 프레임


## 연구내용

### 압축률에 따른 성능 분석
> 
> 기존의 비디오 압축방식인 H.264를 이용하여 영상압축을 진행하였다.
>
> QP는 22, 27, 32, 37, 42, 47로 고정하고 압축하였다.
>
> ![image](https://user-images.githubusercontent.com/112960519/205514085-8becf351-bf28-4037-9bfa-e3de37ec0202.png)
> ![image](https://user-images.githubusercontent.com/112960519/205514087-a6ff1b87-8925-4386-b0a9-a6c35ec74fd6.png)
> ![image](https://user-images.githubusercontent.com/112960519/205514089-2a62358d-6642-454c-aeef-bab8b93ba29d.png)
>
> 일반적으로 압축률이 높아질수록(QP가 높아질수록), bitrate는 줄어들고 성능(MOTA) 또한 줄어드는 것을 확인할 수 있음


### 압축 - Downscale 후 다시 Upscale
> 
> 데이터를 각각 1080p에서 720p, 480p로 downscaling 후 다시 upscaling 하여 tracking task를 수행해보았다.
>
> ![image](https://user-images.githubusercontent.com/112960519/205514169-e4bc1d34-acb0-4369-ae25-5eafc5b576ba.png)
> ![image](https://user-images.githubusercontent.com/112960519/205514174-7ce005d6-e0c8-4c8f-81e8-6973af13d60c.png)
> ![image](https://user-images.githubusercontent.com/112960519/205514180-50fb1781-6715-44ad-8d57-f710e4daf745.png)
>
> Downscale 후 Upscale 하면 RP curve에서 이득을 볼 것이라 예상하였으나 그렇지 않음
> 
> TVD-03은 압축에 따른 성능 열화가 거의 없음


### 압축 - Gray scale
> 
> 영상을 각각 컬러데이터를 없애고 gray 데이터만 남긴 후 tracking task를 수행해보았다.
>
> ![image](https://user-images.githubusercontent.com/112960519/205514213-d110265d-d47c-49a0-87ac-3158a5ff996d.png)
> ![image](https://user-images.githubusercontent.com/112960519/205514215-ea493057-a0ca-4351-9cd2-51d93f7207e9.png)
> ![image](https://user-images.githubusercontent.com/112960519/205514218-cb81086c-f3e2-4061-9d56-80759e3a3f22.png)
>
> 일반적으로 압축이 더 많이 되었을수록 (QP가 높아질수록, 회색이미지) bitrate는 줄어들고 성능 또한 줄어드는 것을 보임
>
> TVD-02는 회색이미지가 성능이 더 좋음



## 결론

> 이처럼 각 데이터의 특성(배경의 색상이나 Object의 특성 등)에 따라 같은 정도로 압축하였더라도 더 나은 성능을 보여줄 수 있고 많이 열화된 성능을 보일 수 있다는 것을 확인하였다. 앞서 서술하였지만 현재 우리 생활에서 영상데이터를 수집하고 처리하는 것은 필수 불가결 하다. 이렇게 Object tracking과 같은 task를 수행하기 위해서는 영상의 압축과 같은 영상의 대역폭을 줄이거나 전송 대역폭을 늘리는 방법이 필요하다. 이 중 영상의 대역폭을 줄이는 방법으로서, 영상이 촬영되는 장소의 특성을 파악하고 추적하고자 하는 Object에 따라 압축률이나 압축 방식을 다르게 한다면 크게 낮은 bitrate로 유의미한 결과를 얻을 수 있을 정도로 압축하여 전송할 수 있을 것이다. 이렇게 압축하여 전송할 수 있게 된다면 같은 대역폭으로 전송하더라도 더 많은 정보를 처리할 수 있게 되어 더 많은 task를 수행할 수 있게 될 것이고 이는 수많은 데이터를 실시간으로 저장하고 처리하는 현재 사회에서 많은 도움이 될 수 있을 것이라고 생각한다.
>
> 또한 회색 데이터와 컬러 데이터의 차이를 통해 인간이 눈으로 좋다고 판단하는 기준과 기계가 task를 수행하는데 좋다고 판단하는 데이터는 다른것을 확인하였다. 인간이 인식하는 좋은 영상압축과 기계가 인식하는 좋은 영상압축이 다른 것이다 따라서 Machine vision tracker를 위한 새로운 압축 방법이 필요하다.


## 참고자료

> https://github.com/facebookresearch/detectron2
>
> https://mpeg.chiariglione.org/
>
> Hinami S. Parekh(2014) A Survey on Object Detection and Tracking Methods, IJIRCCE Vol. 2, Issue 2, Feb 2014
>
> Zhongdao Wang(2020), Toward Real-Time Multi Object tracking
