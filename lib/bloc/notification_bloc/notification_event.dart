abstract class NotificationEvent {
  NotificationEvent([List props = const []]) : super();
}

class GetNotificationList extends NotificationEvent {
  GetNotificationList();
}
class SetNotificationEnable extends NotificationEvent {
  int id;
  SetNotificationEnable(this.id);
}class TapOnPressedNotification extends NotificationEvent {
  int index;
  TapOnPressedNotification(this.index);
}