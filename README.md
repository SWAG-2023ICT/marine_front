# 수산물 프로젝트(Front)

## 폴더 구조

### lib : 코드 파일이 위치해 있는곳

- main.dart : 앱의 설정 정보 및 실행시키는 파일
- router.dart : 라우터 정보가 있는 파일

#### assets : 이미지나 비디오 파일을 넣는곳

- images : 이미지
- videos : 비디오

#### screens : 페이지 별로 파일/폴더 생성

- main_navigation : 메인 네비게이션 페이지(기초 틀)
- menus : 네이베이션에 들어갈 내부 페이지
- sign_in_up : 로그인/회원가입

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

![KakaoTalk_20230928_193822148](https://github.com/SWAG-2023ICT/marine_front/assets/77985708/62408601-cf7e-4f03-8515-5779cdfee3d2.png){: width="100" height="200"}
![KakaoTalk_20230928_193745558](https://github.com/SWAG-2023ICT/marine_front/assets/77985708/1d5591dc-ccc0-4c41-a758-90ed79bd6d64.png){: width="100" height="200"}
![KakaoTalk_20230928_193745558_01](https://github.com/SWAG-2023ICT/marine_front/assets/77985708/ca2813ac-335e-4bc0-a3bf-4fe99127bec5.png){: width="100" height="200"}
![KakaoTalk_20230928_193745558_02](https://github.com/SWAG-2023ICT/marine_front/assets/77985708/488b0d59-b71d-48c8-ad6f-fe2834299fae.png){: width="100" height="200"}
![KakaoTalk_20230928_193745558_03](https://github.com/SWAG-2023ICT/marine_front/assets/77985708/b9e32f08-f040-4680-8162-d6a90afc460d.png){: width="100" height="200"}

