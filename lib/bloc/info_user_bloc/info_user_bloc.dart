
import 'package:flutter_bloc/flutter_bloc.dart';


import 'package:picture_flutter/bloc/info_user_bloc/info_user_event.dart';
import 'package:picture_flutter/bloc/info_user_bloc/info_user_state.dart';


class InfoUserBloc extends Bloc<InfoUserEvent, InfoUserState>{
  InfoUserBloc(InfoUserState initialState) : super(initialState){
    on<OpeningInfoUser>((event, emit){
      emit(EditingInfoState(event.user));
    });

    on<ClosingInfoUser>((event, emit){
      emit(StaticInfoState(event.user));
    });
  }


}