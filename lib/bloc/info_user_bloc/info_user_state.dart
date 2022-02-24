import 'package:equatable/equatable.dart';
import 'package:picture_flutter/servises/user_sirvises.dart';

abstract class InfoUserState extends Equatable{
  const InfoUserState();
}

class InitialState extends InfoUserState{
  const InitialState();

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class StaticInfoState extends InfoUserState{
  StaticInfoState(this.user);
  MyUser user;

  @override
  List<Object?> get props=>[user];
}

class EditingInfoState extends InfoUserState{
  EditingInfoState(this.user);
  MyUser user;

  @override
  List<Object> get props=>[user];
}

class UpdatingInfoState extends InfoUserState{
  UpdatingInfoState(this.user);
  MyUser user;

  @override
  List<Object> get props=>[user];
}