enum ForegroundStatus {
  ready,
  notificationsDenied,
  notificationsBlocked,
  unsupported;

  bool get isReady => this == ForegroundStatus.ready;
  bool get needsSettings => this == ForegroundStatus.notificationsBlocked;
}
