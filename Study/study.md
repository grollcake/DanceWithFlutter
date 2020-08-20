# flutter 학습일지

## 2020-08-20: 환경 구성

### 환경 구성 요약

* https://flutter.dev/
* 윈도우 인스톨: https://flutter.dev/docs/get-started/install/windows
* MAC 인스톨: https://flutter.dev/docs/get-started/install/macos
* 디렉토리 구성

| 디렉토리            | 용도                                                         | 비고                              |
| ------------------- | ------------------------------------------------------------ | --------------------------------- |
| D:\flutter-dev      | 기본 디렉토리                                                |                                   |
| + downloads         | 각종 설치파일 다운로드 (Android Studio, SDK, git-scm 등)     |                                   |
| + sdk / flutter     | flutter sdk 설치                                             |                                   |
| + DanceWithFlutter  | 코드 저장소: https://github.com/grollcake/DanceWithFlutter.git |                                   |
| ++ study            | 학습한 내용을 정리                                           |                                   |
| ++ Era              | 김훈균 개인 프로젝트 공간                                    | flutter 프로젝트별 하위 폴더 생성 |
| ++ NewMiracle       | 송준수 개인 프로젝트 공간                                    | flutter 프로젝트별 하위 폴더 생성 |
| ++ DeveloperUnknown | 김경민 개인 프로젝트 공간                                    | flutter 프로젝트별 하위 폴더 생성 |
|                     |                                                              |                                   |

* IDE: [Android Studio](https://developer.android.com/studio)를 기본 툴로 사용. [VSCode](https://code.visualstudio.com/download)도 사용할 수 있음.

### 설치 순서

1. 디렉토리 생성: d:\flutter-dev

2. git 설치: https://git-scm.com/downloads

3. DanceWithFlutter clone: git clone https://github.com/grollcake/DanceWithFlutter.git

4. flutter sdk 설치: https://storage.googleapis.com/flutter_infra/releases/stable/windows/flutter_windows_1.20.2-stable.zip  => d:\flutter-dev\sdk\flutter

5. Path 등록: d:\flutter-dev\sdk\flutter\bin

6. flutter doctor 실행해보기: cmd 창을 열고 `flutter doctor`

7. Android Studio 설치: https://developer.android.com/studio

8. ADV 구성: 가상 안드로이드 에뮬레이터
   **Android Studio > Tools > Android > AVD Manager** 

9. (옵션) 에뮬레이터 가속 설정: https://developer.android.com/studio/run/emulator-acceleration

10. Android Studio 플러그인 설치: flutter Enhancement Suite (Pub package 설치 지원)

    

