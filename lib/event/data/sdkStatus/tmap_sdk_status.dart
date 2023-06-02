import 'dart:core';

enum TmapSDKStatus {
  /// 초기화 상태
  none('none'),
  /// MAP관련 초기화 진행상태
  mapInitializing('mapInitializing'),
  /// 인증을 요청하고 있는 상태
  requestingAuth('requestingAuth'),
  /// MAP초기화 에러
  vsmError('vsmError'),
  /// 인증 진행중 에러
  authError('authError'),
  /// 인증완료 및 동작가능 상태
  completed('completed'),
  /// 동작가능 상태
  ready('ready'),
  /// 요청한 동작의 완료후 노출되고 있는 ViewController를 화면에서 제거요청
  /// 이 요청을 받게 되면 TMAP SDK에서 전달되었던 view controller를 제거해야 합니다.
  /// TMAP은 내부적인 동작을 완료한 뒤 더이상 수행이 필요없는 경우 이 요청을 전달하게 됩니다.
  dismissReq('dismissReq'),
  /// SDK의 동작 완료 후 permission 요청
  dismissNRequestPermission('dismissNRequestPermission'),
  /// SDK동작에 필요한 권한 요청
  requestPermission('requestPermission'),
  /// SDK의 종료
  finished('finished'),

  ;
  final String text;
  const TmapSDKStatus(this.text);

  factory TmapSDKStatus.getByText(String text){
    return TmapSDKStatus.values.firstWhere((value) => value.text == text,
        orElse: () => TmapSDKStatus.none);
  }
}