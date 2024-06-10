## 1.0.43
* 홍수주의 구간 안내 기능 추가 (AOS,IOS)
* 경로요약화면 UI버그 개선, 자동안내 관련 버그 개선(AOS)

## 1.0.42
* AOS UISDK version 수정

## 1.0.41
* TmapDriveGuide정보에 현재 주행중인 각도 정보 추가 (AOS,IOS)

## 1.0.40
* 경로요약화면, 주행 중 전체경로화면의 출력되는 경로의 align문제 수정 (AOS)

## 1.0.39
* 자동 길안내 timer기능 적용 (AOS,iOS)

## 1.0.38
* 종료팝업 off설정 후 모의주행 시 popup출력하지 않도록 수정 (AOS,iOS)

## 1.0.37
* 하이패스 차로정보 추가 (AOS,iOS)

## 1.0.36
* driveGuide정보에 목적지 이름 추가 (AOS,iOS)
* driveGuide의 json변환문제 수정 (flutter)

## 1.0.35
* 남은 경유지 정보에 경유지 이름 추가 (AOS,iOS)

## 1.0.34
* Privacy Manifest 추가 (iOS)

## 1.0.33
* DriveGuide에 목적지위치, 경유지위치정보 추가

## 1.0.32
* 소형트럭 톨게이트 option설정관련 버그 수정

## 1.0.31
* AOS 비정상 상황에서 종료 요청 시 errorCode를 전달하도록 수정

## 1.0.30
* release mode에서의 IllegalStateException exception발생 현상 방어코드 추가

## 1.0.29
* IllegalStateException exception발생 현상 방어코드 추가 (AOS - java.lang.IllegalStateException: The Android view returned from PlatformView#getView() was already added to a parent view.)

## 1.0.28
* 차종에 따른 톨게이트 비용 처리 오류 수정 (iOS)
* 경로 요약화면에서 EV차량인 경우 충전소 표시되지 않던 사항 수정 (iOS, AOS)
* 경로종료시 팝업설정 오류 수정 (iOS)
* 경로 preview시 하나의 경로만 나오던 사항 수정 (AOS)

## 1.0.27
* 인증 후 종료 시 Memory Leak관련 수정 (AOS)

## 1.0.26
* Memory Leak관련 수정 (AOS)
* SDK finalize interface 추가

## 1.0.25
* 후면단속 카메라 관련 버그 수정 (AOS)
* DriveGuide정보의 SDI type에 후면단속 카메라 관련 정보 추가
* 모의주행 기능 추가
* 경로요약화면의 주행 버튼영역 조정 (AOS)

## 1.0.24
* 이어서 경로안내 기능불가상황 알림 추가 

## 1.0.23
* 이어서 경로안내 기능 추가

## 1.0.22
* 구간단속 구간 내 속도 표시 이상현상 수정 (AOS)
* 경유지 접근 시 하단 "다음 목적지로 안내" button 출력이상 현상 수정(AOS)
* 다음 경유지로의 안내를 위한 interface 추가 (AOS,IOS)

## 1.0.21
* 속도반응형 지도설정 동작하지 않는 버그 수정 (IOS)

## 1.0.20
* UISDK의 fragment를 screen size보다 작게 하는 경우 화면 layout 이상현상 수정(AOS)

## 1.0.19
* secondSDI 전달되지 않는 문제 수정 (AOS)

## 1.0.18
* 실시간 경로 탐색 on/off 기능 추가

## 1.0.17
* 배경음악 play중 TTS play시 배경음악 stop되는 문제 수정 (AOS)

## 1.0.16
* 후면단속 카메라 지원
* DriveStatus에 secondSDI, secondTBT, remainViaPointSize 정보 추가

## 1.0.15
* Navigation관련 데이터 type 수정

## 1.0.14
* 경유지가 설정된 경우 DriveGuide 데이터 전달 관련 버그 수정

## 1.0.13
* DriveGuide에 현재 위치 전달기능 추가

## 1.0.12
* (AOS) 경로선 색 지정 관련 버그 수정

## 1.0.11
* (AOS) play-services-location version conflict로 인한 crash수정

## 1.0.10
* pause/resume시 자차 marker 출력 이상오류 수정

## 1.0.9
* 교통약자 SDI지원
* 트럭 제약사항 데이터 전달 추가
* 초기 인증 시 deviceKey 추가
* DriveStatus 전달 버그 수정

## 1.0.8
* 트럭옵션 설정 관련 버그 수정

## 1.0.7
* 지원되지 않는 경로 option 제거
* 경로 option 처리오류 수정

## 1.0.6
* 경로요청 API 동작 실패시 오류 수정

## 1.0.5
* 인증 key관련 주석 변경 (userKey optional)
* AOS/IOS sdk version 변경

## 1.0.4
* readme 수정
* example app의 위치 권한 획득관련 수정

## 1.0.3
* Flutter 3.7.0/Dart 2.19.0 SDK 최소 버전 환경 세팅

## 1.0.2
* go_routes 이용 하여 sample app 수정
* 주행 화면의 flutter appbar 제거
* Provider 상태 관리 적용
* driveWithoutPreview 페이지 제거 
* TmapDriveGuide, TmapDriveStatus 스트림 기능 추가

## 1.0.1
* 주행 종료 popup의 on/off 설정을 위한 기능 추가

## 1.0.0
* Initial commit
