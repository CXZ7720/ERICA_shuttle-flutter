# HYBUS_flutter
![lang](https://img.shields.io/github/languages/top/CXZ7720/ERICA_shuttle-flutter) ![license](https://img.shields.io/github/license/CXZ7720/ERICA_shuttle-flutter) ![commit](https://img.shields.io/github/last-commit/cxz7720/ERICA_shuttle-flutter) [![project](https://img.shields.io/badge/project-DSC-%231976d2)](https://developers.google.com/community/dsc)<br>

<p>
<img src="https://user-images.githubusercontent.com/29659112/71321409-220f2d80-24fc-11ea-82ce-f2deb6caea96.png" width="80">
<img src="https://user-images.githubusercontent.com/29659112/71321425-6a2e5000-24fc-11ea-841f-07cb6c0561ee.png" height="80">
<img src="https://user-images.githubusercontent.com/29659112/71321605-2a1c9c80-24ff-11ea-9724-dba89c6f41b9.png" height="80">
</p>

**한양대학교 셔틀버스 도착시간 안내 어플리케이션**

한양대학교ERICA 캠퍼스의 셔틀버스와 연계교통 정보를 확인할 수 있는 안드로이드 어플리케이션입니다.<br>
2019-2 오픈소스기초 기말고사 대체 프로젝트 및 <br>[DSC Korea](https://developers.google.com/community/dsc) - HanyangUniv ERICA의 2019년 2학기 Core member로 활동하며 진행한 개인 프로젝트 입니다.


* DevLog는 다음 위키페이지에서 확인하실 수 있습니다.
[링크](https://github.com/CXZ7720/ERICA_shuttle-flutter.wiki.git)

## 0. Screenshots
<p float="left">
    <img src="https://user-images.githubusercontent.com/29659112/71321616-7c5dbd80-24ff-11ea-8d00-668c3dd4cb28.png" width="350">
    <img src="https://user-images.githubusercontent.com/29659112/71321622-8bdd0680-24ff-11ea-9cb5-42145d2da5c6.png" width="350">
</p>

## 1. Dependencies
Most of the dependencies of this project is written in `pubspec.yaml`
 * cupertino_icons: ^0.1.2
 * font_awesome_flutter: ^8.5.0
 * http: ^0.12.0+2
 * pull_to_refresh: ^1.4.5
 * Fonts(Already included in this project)
    - Spoqa Han Sans - [LINK](https://spoqa.github.io/spoqa-han-sans/ko-KR/#intro)
    - KT&G SangSang Font - [LINK](https://www.ktng.com/sangsang?mode=DOWN)
    - NotoSansKR - [LINK](https://fonts.google.com/specimen/Noto+Sans+KR)
* API Resources
    - [ERICA_Shuttcock_API](https://github.com/CXZ7720/ERICA_shuttlecock_API)
    - Seoul TOPIS(Transport Operation & Information Service) - [LINK](http://data.seoul.go.kr) 
    - GyeongGi-Do Bus Infomation(GBIS) - [LINK](https://www.data.go.kr/dataset/15000175/openapi.do?)

## 2. Requirements
* Android Studio
* Flutter

## 3. Test Devices and Environments
* Xiaomi Mi Note3 (Android 9 - *PIE*  / MIUI 10.1 / Kernel 4.4.153-perf-g74a1e10)

## 4. ETC

#### 하냥이 이미지 사용 관련
  본 프로젝트 진행을 위하여 하냥이 이미지 사용에 관하여 **한양대학교ERICA캠퍼스 대외협력팀**과 사전에 협의가 완료되었음을 미리 밝힙니다. 캐릭터디자인에 관한 모든 권리는 한양대학교ERICA캠퍼스에 있습니다.

## 5. For Developments

### 0) Development Environment
1. RAM : DDR4 2133 16GB
2. CPU : Intel™ Core I5 8250U
3. Flutter : Channel stable, v1.12.13+hotfix.5
4. Dart version 2.7.0
5. Android toolchain - Android SDK Version 29.0.2
6. Java version : OpenJDK Bukld 1.8.0_202-releases-1483-b03
7. Android Studio : Version 3.5
    - Flutter plugin version : 42.1.1
    - Dart plugin version : 191.8593
    

### 1) Colone This repository
`git clone https://github.com/CXZ7720/ERICA_shuttle-flutter`

### 2) Install Fultter
Follow this [LINK](https://flutter.dev/docs/get-started/install)<br>
It depends on your OS.<br>
You should pass all tests of `flutter doctor -v`.

### 3) Install Android Studio
You can download [HERE](https://developer.android.com/studio/)

### 4) Open this project as a Android Studio Project

### 5) Get dependencies
* Open `pubspec.yaml` file.
* Click `Packages get` button on the top bar or run command via termial `flutter packages get`

Then, Flutter will automatically install dependencies on `pubspec.yaml`

## 6) Connect Your phone

## 7) Run build
It takes few minute, depends on your machine's peformance.
You must turn on Andoird debug bridge on your phone, and grant to install APK through USB connection.

## 8) Market download Link
Google Play Store 등록 완료. 현재 검토 대기중.

![image](https://user-images.githubusercontent.com/29659112/71321761-897bac00-2501-11ea-8921-ca51087e02ea.png)
