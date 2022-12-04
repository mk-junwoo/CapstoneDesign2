# CapstoneDesign2

# Video Compression for Object Tracking

## 연구배경

  CCTV, 자율자동자의 센서, 제조 공정상에서의 불량 검출 등, 영상이 사용되는 곳은 점점 늘어나고 있다. 이러한 영상을 원본 그대로 처리하는 것은 정확도를 높일 수는 있지만, 저장 공간의 한계, 전송 대역폭의 한계 등 여러 요소로 인해 비효율 적이다. 따라서 이러한 영상을 압축하고 전송 후 처리부에서 수신을 하고 압축을 해제하여 영상을 용도에 맞게 처리하는 것이 일반적이다.
이러한 과정을 위해 원본 영상을 사용하는 것이 아닌, 영상자체를 압축하여 전송하거나 영상에서 여러 Feature를 추출하여 이를 이용하여 압축하고 전송하면 process의 정확도를 많이 낮추지 않는 선에서 데이터의 크기를 줄여 전송할 수 있다.

  또한 위와 같은 task를 수행하는 주체는 Neural Net 기반의 Detector, Tracker 등등 사람이 아니라 기계인 경우가 많아지고 있다. 사람을 위해 영상을 압축하는 것이 아닌 기계를 위한 압축, VCM(Video Coding for Machine)의 중용성이 대두되고 있다.


## 관련연구

> * Object Detection
>
> Object detection은 일반적으로 Classification과 Localization이 같이 수행된 것을 의미한다. 입력된 영상에서 유의미한 특정 객체를 감지하는 것으로서, 시각적으로는 아래 그림과 같이 Bounding box를 이미지 위에 덧 그려서 표시하고, 그 Object의 Classification 결과를 같이 표시하여 나타낸다. 아래와 같이 한 영상에 여러 Object가 있을 수 있다.
> 
> ![image](https://user-images.githubusercontent.com/112960519/205511072-884f4c80-0f66-4fa4-ba44-6e856163da4e.png)
> 
> Detectron2를 이용한 Object detection 예시

> * Object Tracking
>
> Object tracking은 입력된 영상으로부터 Object를 추적하는 것이다. Object가 변형이 일어나도 계속 추적할 수 있어야 한다. 예를 들어 걷고 있는 사람의 형태는 정지된 영상과는 다르게 팔, 다리도 계속 움직이고 경우에 따라서 몸의 측면이 보이다가 정면이 보일수도 있고 걷는 도중 주변의 여러 물체에 의해 신체의 일부가 가려질 수도 있다. 이러한 상황들에 대해서도 지속적인 추적이 이루어 지도록 한 것이 Object tracking이다. 
> 
> ![image](https://user-images.githubusercontent.com/112960519/205511213-0a77780b-1d83-455c-bb28-8d152750f64a.png) 
> 
> TVD-01 Object tracking 예시, 60번째 프레임과 50번째 프레임


## 연구내용

## 결론

## 참고자료
