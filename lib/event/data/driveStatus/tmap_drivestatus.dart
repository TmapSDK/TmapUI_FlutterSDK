import 'dart:core';

enum TmapDriveStatus {
  notDriving('notDriving'),

  /// 대안경로 변경됨
  onAlternativeRouteChanged('onAlternativeRouteChanged'),

  /// 목적지 접근 중
  onApproachingDestination('onApproachingDestination'),

  /// 목적지 도착
  onArrivedDestination('onArrivedDestination'),

  /// 경로 이탈
  onBreakawayFromRouteEvent('onBreakawayFromRouteEvent'),

  /// 대안경로 접근 중
  onApproachingAlternativeRoute('onApproachingAlternativeRoute'),

  /// 대안경로 갈림길 지점 통과
  onPassedAlternativeRouteJunction('onPassedAlternativeRouteJunction'),

  /// 정주기 재탐색
  onPeriodicReroute('onPeriodicReroute'),

  /// 경로 변경됨
  onRouteChanged('onRouteChanged'),

  /// 강제 재탐색
  onForceReroute('onForceReroute'),

  /// 위치 신호 수신 상태
  onNoLocationSignal('onNoLocationSignal'),

  /// 경유지 접근
  onApproachingViaPoint('onApproachingViaPoint'),

  /// 경유지/도착지 접근 (픽업용 300m)
  onApproachingViaOrDestination('onApproachingViaOrDestination'),

  /// 경유지 통과
  onPassedViaPoint('onPassedViaPoint'),

  /// 경로 option변경 수행 완료
  onChangeRouteOptionComplete('onChangeRouteOptionComplete'),

  /// 이탈 재탐색 수행 완료
  onBreakAwayRequestComplete('onBreakAwayRequestComplete'),

  /// 정주기 재탐색 수행 완료
  onPeriodicRerouteComplete('onPeriodicRerouteComplete'),

  /// 사용자 재탐색 수행 완료
  onUserRerouteComplete('onUserRerouteComplete'),

  /// 강제 재탐색 수행 완료
  onForceRerouteComplete('onForceRerouteComplete'),

  /// 목적지 방향성 재탐색 수행 완료
  onDestinationDirResearchComplete('onDestinationDirResearchComplete'),

  /// 재탐색 이후 목적지 방향성 재탐색 수행하지 않음
  doNotDestinationDirSearchFromNowOn('doNotDestinationDirSearchFromNowOn'),

  /// 경로요청 실패
  onFailRouteRequest('onFailRouteRequest'),

  /// tollgate 통과
  onPassedTollgate('onPassedTollgate'),

  /// finish route request완료
  onFinishRouteRequestOnComplete('onFinishRouteRequestOnComplete'),

  /// 재탐색 실행
  onReroute('onReroute'),

  /// 재탐색 수행 완료
  onRerouteComplete('onRerouteComplete'),

  /// 재탐색 수행 실패
  onRerouteFailed('onRerouteFailed'),

  /// 재탐색 수행되지 않음.
  onIgnoringDisabledReroute('onIgnoringDisabledReroute'),

  /// 목적지 건너편 지나감
  passedDestinationOpposite('passedDestinationOpposite'),

  /// 재탐색중 새로운 재탐색 수행되지 않음
  onNewRerouteIsIgnoredDuringRerouting('onNewRerouteIsIgnoredDuringRerouting'),
  ;
  final String text;
  const TmapDriveStatus(this.text);

  factory TmapDriveStatus.getByText(String text){
    return TmapDriveStatus.values.firstWhere((value) => value.text == text,
        orElse: () => TmapDriveStatus.notDriving);
  }
}