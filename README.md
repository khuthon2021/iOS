# 주제
- 2021 경희대학교 1박2일 해커톤 khuthon 주제 : AI로 극복하는 재난 
- 프로젝트 주제 : AI를 이용한 졸음운전 방지 서비스

## 개요

우리 주변에서 가장 흔하게 볼 수 있는 재난인 '자동차 사고', 그리고 이의 주요 원인 중 하나인 '졸음운전'을 방지하기 위해 제작되었습니다.
운전자의 눈을 인식하여 일정 시간 동안 눈이 감기는 것을 감지하면 옆에 있는 휴대폰으로 알림을 주어 운전자에게 주의를 줍니다.

## 프로젝트 목표
- 카메라를 통해 운전자가 졸음운전을 하고 있다고 판단된 경우 실시간으로 어플리케이션에서  알림을 울려 운전자를 깨워주고 안전하게 운행을 할 수 있도록 도와줍니다.

## 프로젝트 구조
<img width="800" alt="스크린샷 2021-06-22 오후 4 31 01" src="https://user-images.githubusercontent.com/29617557/152778724-e48265eb-5bb0-45f3-89d1-8435098fb153.png">

## 스크린샷
- 초기화면
<img width="400" alt="스크린샷 2021-06-22 오후 4 31 01" src="https://user-images.githubusercontent.com/29617557/152778830-91f4d76f-136f-4f22-83ba-ac3d1e4e7da0.png">
- 구글로 로그인
<img width="400" alt="스크린샷 2021-06-22 오후 4 31 44" src="https://user-images.githubusercontent.com/29617557/152779084-3cf22bd9-cad0-4d84-9cb8-fa1afcff3a99.png">
- 메인 화면
<img width="400" alt="스크린샷 2021-06-22 오후 4 32 19" src="https://user-images.githubusercontent.com/29617557/152779198-8bb57fba-ad5e-4468-8428-79bc86abd31b.png">
- 알림이 왔을 때
<img width="400" alt="스크린샷 2021-06-22 오후 4 32 55" src="https://user-images.githubusercontent.com/29617557/152779317-4b6e8616-2a75-405c-a085-4513105fa8ef.jpg">



## 사용한 기술 또는 API

Google Firebase Realtime Database 
Google Firebase Authentication 
FCM(Firebase Cloud Messaging) Swift 


## 구현 기능

1. Firebase Authentication을 이용해 '이메일로 회원가입/로그인', 'Google로 회원가입/로그인' 
구현 2. Firebase Realtime Database에서 로그인 한 사용자에 맞는 정보를 ViewController들에 표 
시. 3. Spring 서버에서 이벤트가 발생하면 FCM을 이용해 iOS App이 Push Notification을 받을 수 
있도록 구현. 

## Demo
![그림5](https://user-images.githubusercontent.com/29617557/152779418-9f7966fe-5d8a-4463-8b0b-53764dbf7224.mp4)

## 수상
[대상 수상](https://thon.khlug.org/about/2021)
