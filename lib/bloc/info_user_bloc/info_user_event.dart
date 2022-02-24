import 'package:picture_flutter/servises/user_sirvises.dart';

abstract class InfoUserEvent{}

class OpeningInfoUser extends InfoUserEvent{
  OpeningInfoUser(this.user);
  final MyUser user;
}

class SavingInfoUser extends InfoUserEvent{
  SavingInfoUser({required this.user});
  final MyUser user;
}

class ClosingInfoUser extends InfoUserEvent{
  ClosingInfoUser({required this.user});
  final MyUser user;
}