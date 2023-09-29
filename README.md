# 수산물 프로젝트(Front)

## 폴더 구조

### lib : 코드 파일이 위치해 있는곳

- main.dart : 앱의 설정 정보 및 실행시키는 파일
- router.dart : 라우터 정보가 있는 파일

#### assets : 이미지나 비디오 파일을 넣는곳

- images : 이미지
- videos : 비디오

#### features : 기능 별로 파일/폴더 생성

- user : 유저 기능 및 페이지가 포함되어 있는 폴더
  1. home : 네비게이션으로 가기 전 페이지
  2. navigation : 메인 네비게이션 및 하위 페이지 폴더
  3. profile : 사용자 프로필 기능 폴더
  4. sign_in_up : 로그인/회원가입
- store : 가게 기능 및 페이지가 포함되어 있는 폴더

#### constants : 정적으로 생성한 클래스들이 위치한 곳

#### models : 앱 내부에서 쓰는 모델들을 모아놓은곳

#### storages : 클라이언트에 저장되는 스토리지(암호화)

#### utils : 라이브러리를 간단하게 사용하기 위한 파일을 모아놓은곳

## 라이브러리

- font_awesome_flutter: ^10.3.0 (무료 아이콘 라이브러리)
- http: ^0.13.5 (통신)
- cupertino_icons: ^1.0.2 (iOS 스타일 아이콘 라이브러리)
- flutter_secure_storage: ^8.0.0 (로컬 스토리지를 만드는 라이브러리)
- provider: ^6.0.5 (상태 관리 라이브러리)
- go_router: ^6.5.5 (라우터 페이지 관리 라이브러리)
- image_picker: ^1.0.0 (갤러리, 카메라 라이브러리)
- google_maps_flutter: ^2.3.1 (구글 맵 라이브러리)
- kpostal: ^0.5.1 (카카오 주소 검색 라이브러리)

## 화면 프로토타입

### 로그인 & 회원가입

<img src="https://github.com/SWAG-2023ICT/marine_front/assets/77985708/5446a36e-1d00-4c78-bfa2-519eab6d7c6f.jpg" width="200" height="450"/>
<img src="https://github.com/SWAG-2023ICT/marine_front/assets/77985708/09ee59d7-74ad-46bb-b0d7-5824d65cdef8.jpg" width="200" height="450"/>
<img src="https://github.com/SWAG-2023ICT/marine_front/assets/77985708/8d61ac55-3a63-4650-b5a9-3bc3a0a88690.jpg" width="200" height="450"/>
<img src="https://github.com/SWAG-2023ICT/marine_front/assets/77985708/aecb20cb-d803-4298-bc5e-818461d79b12.jpg" width="200" height="450"/>
<img src="https://github.com/SWAG-2023ICT/marine_front/assets/77985708/4cd3e9c5-6ce6-4f39-aa02-126a5a2b362f.jpg" width="200" height="450"/>
