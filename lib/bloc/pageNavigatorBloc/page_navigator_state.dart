import 'package:equatable/equatable.dart';
import 'package:picture_flutter/bloc/pageNavigatorBloc/page_navigator_bloc.dart';
import 'package:picture_flutter/servises/user_sirvises.dart';

abstract class NavigatorPageState extends Equatable{
 const NavigatorPageState();
  List<Object> get props => [];
}

class PageInitialState extends NavigatorPageState{
  const  PageInitialState();
}

class PageLoadindState extends NavigatorPageState{
 const  PageLoadindState();
}

class ProfilePageState extends NavigatorPageState{
    ProfilePageState(this.user);
  final MyUser user;


  List<Object> get props => [];
}

class HomePageState extends NavigatorPageState{
  HomePageState(this.user);
 final MyUser user;


  List<Object> get props => [];
}

class AddingPageState extends NavigatorPageState{
  AddingPageState(this.user);
  MyUser user;

  List<Object> get props => [];
}

