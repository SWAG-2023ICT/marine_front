# 수산물 프로젝트(Front)

# 프로젝트 정보

<a><img src="https://img.shields.io/badge/-Flutter-387ADF?style=flat-plastic&logo=Flutter&logoColor=white"/>
<img src="https://img.shields.io/badge/-Provider-FBA834?style=flat-plastic&logo=Provider&logoColor=white"/>
<img src="https://img.shields.io/badge/-Github-black?style=flat-plastic&logo=Github&logoColor=white"/></a>

개발자 : 이재현


프로젝트 한줄소개 : 학교에서 키오스크에서 구매하는 학식권을 모바일에서 구매하고 이를 인증할 수 있는 프로그램


프로젝트 화면 구조
- 로그인 / 회원가입
- 날짜별 식단표 출력
- 식권 구매
- 구매한 식권을 QR로 표시
- 결제 내역 표시

## 폴더 구조

- lib : 코드 파일이 위치해 있는곳
- assets : 이미지나 비디오 파일을 넣는곳
- features : 기능 별로 파일/폴더 생성
- constants : 정적으로 생성한 클래스들이 위치한 곳
- models : 앱 내부에서 쓰는 모델들을 모아놓은곳
- storages : 클라이언트에 저장되는 스토리지(암호화)
- utils : 라이브러리를 간단하게 사용하기 위한 파일을 모아놓은곳

## 라이브러리

- font_awesome_flutter: ^10.3.0 (무료 아이콘 라이브러리)
- http: ^0.13.5 (통신)
- cupertino_icons: ^1.0.2 (iOS 스타일 아이콘 라이브러리)
- flutter_secure_storage: ^8.0.0 (로컬 스토리지를 만드는 라이브러리)
- provider: ^6.0.5 (상태 관리 라이브러리)
- go_router: ^11.1.4 (라우터 페이지 관리 라이브러리)
- image_picker: ^1.0.0 (갤러리, 카메라 라이브러리)
- google_maps_flutter: ^2.3.1 (구글 맵 라이브러리)
- kpostal: ^0.5.1 (카카오 주소 검색 라이브러리)
- image_picker: ^1.0.0 (갤러리, 카메라 라이브러리)
- intl: ^0.18.1 (날짜, 단위 포맷 라이브러리)

## 화면 프로토타입

### 로그인 & 회원가입

<img src="https://github.com/SWAG-2023ICT/marine_front/assets/77985708/5446a36e-1d00-4c78-bfa2-519eab6d7c6f.jpg" width="200" height="450"/>
<img src="https://github.com/SWAG-2023ICT/marine_front/assets/77985708/09ee59d7-74ad-46bb-b0d7-5824d65cdef8.jpg" width="200" height="450"/>
<img src="https://github.com/SWAG-2023ICT/marine_front/assets/77985708/8d61ac55-3a63-4650-b5a9-3bc3a0a88690.jpg" width="200" height="450"/>
<img src="https://github.com/SWAG-2023ICT/marine_front/assets/77985708/aecb20cb-d803-4298-bc5e-818461d79b12.jpg" width="200" height="450"/>
<img src="https://github.com/SWAG-2023ICT/marine_front/assets/77985708/4cd3e9c5-6ce6-4f39-aa02-126a5a2b362f.jpg" width="200" height="450"/>

### 유저 기능

#### 방사능 검사 결과 검색 페이지

<img src="https://github.com/SWAG-2023ICT/marine_front/assets/77985708/3ad1db78-5c41-4ad3-9515-a245d7f59bf9.jpg" width="200" height="450"/>

#### 가게 관련 페이지

<img src="https://github.com/SWAG-2023ICT/marine_front/assets/77985708/155fa1ac-d2bd-4005-83c1-7411563c1585.jpg" width="200" height="450"/>
<img src="https://github.com/SWAG-2023ICT/marine_front/assets/77985708/f5a2d5f1-a081-49d5-8cb1-a643c4ddc7dc.jpg" width="200" height="450"/>
<img src="https://github.com/SWAG-2023ICT/marine_front/assets/77985708/4f88b2ac-61c2-48ba-8840-ea7f46446da4.jpg" width="200" height="450"/>

#### 즐겨찾기 페이지

<img src="https://github.com/SWAG-2023ICT/marine_front/assets/77985708/12ff015f-714c-41d4-b483-9921032b714f.jpg" width="200" height="450"/>

#### 마이 페이지

<img src="https://github.com/SWAG-2023ICT/marine_front/assets/77985708/f06800a6-32c0-4fa3-b15c-2f876d31a1b7.jpg" width="200" height="450"/>
<img src="https://github.com/SWAG-2023ICT/marine_front/assets/77985708/a16e8d0a-fe11-4154-9568-753fff9bda5d.jpg" width="200" height="450"/>
<img src="https://github.com/SWAG-2023ICT/marine_front/assets/77985708/f953e884-5a90-4d53-8950-77a836aaa84f.jpg" width="200" height="450"/>
<img src="https://github.com/SWAG-2023ICT/marine_front/assets/77985708/3e50dffc-8a83-45d7-8e1e-3fc26ffff2ac.jpg" width="200" height="450"/>

#### 회원 정보 관리 페이지

<img src="https://github.com/SWAG-2023ICT/marine_front/assets/77985708/37f60116-dfa5-42ce-8a94-42cbbadf6e37.jpg" width="200" height="450"/>
<img src="https://github.com/SWAG-2023ICT/marine_front/assets/77985708/8b8e9b52-c170-4a48-97a0-64af41e95b13.jpg" width="200" height="450"/>
<img src="https://github.com/SWAG-2023ICT/marine_front/assets/77985708/cbdca4b4-fac3-4b09-a3fd-9a53c9f4eeea.jpg" width="200" height="450"/>
<img src="https://github.com/SWAG-2023ICT/marine_front/assets/77985708/5331e5b2-44f2-4daf-848b-dfce850b3db1.jpg" width="200" height="450"/>

#### 설정 페이지

<img src="https://github.com/SWAG-2023ICT/marine_front/assets/77985708/320e678d-07f7-4612-a32f-ea6d83077a86.jpg" width="200" height="450"/>

### 가게 기능

#### 메뉴 관련 기능

<img src="https://github.com/SWAG-2023ICT/marine_front/assets/77985708/37cff233-835d-4e62-89a1-a42a91f20c26.jpg" width="200" height="450"/>
<img src="https://github.com/SWAG-2023ICT/marine_front/assets/77985708/a79f8ef4-34ea-40fd-a412-cef5990e3008.jpg" width="200" height="450"/>
<img src="https://github.com/SWAG-2023ICT/marine_front/assets/77985708/08303116-3c5e-4fa5-bdf6-69a2c08b27a3.jpg" width="200" height="450"/>
<img src="https://github.com/SWAG-2023ICT/marine_front/assets/77985708/08850294-60df-4e46-8e2f-bce322a22c58.jpg" width="200" height="450"/>

#### 주문 페이지

<img src="https://github.com/SWAG-2023ICT/marine_front/assets/77985708/146c5668-d5cf-401f-a93b-9c361b33fa43.jpg" width="200" height="450"/>

#### 신청 관리 페이지

<img src="https://github.com/SWAG-2023ICT/marine_front/assets/77985708/ce32bed1-b102-47e0-beff-f629f36fbe31.jpg" width="200" height="450"/>

#### 마이 페이지

<img src="https://github.com/SWAG-2023ICT/marine_front/assets/77985708/1297c01d-1992-4dc8-a0b1-67750a3164c0.jpg" width="200" height="450"/>

#### 설정 페이지

<img src="https://github.com/SWAG-2023ICT/marine_front/assets/77985708/efc71137-9762-4598-806a-3fe2215ed050.jpg" width="200" height="450"/>
