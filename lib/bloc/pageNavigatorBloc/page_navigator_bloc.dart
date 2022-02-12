import 'package:bloc/bloc.dart';
import 'package:picture_flutter/bloc/pageNavigatorBloc/page_navigator_event.dart';
import 'package:picture_flutter/bloc/pageNavigatorBloc/page_navigator_state.dart';
import 'package:picture_flutter/servises/firestore_servises.dart';
import 'package:picture_flutter/servises/user_sirvises.dart';

class NavigatorPageBloc extends Bloc<NavigatorPageEvent, NavigatorPageState>{
  int currentIndex=1;
  NavigatorPageBloc() : super(PageInitialState()){
    on<PageLoadEvent>((event, emit) async{

      emit(PageLoadindState());
      try{
        MyUser user = await FirestoreServises().getCurrentUser();
        this.currentIndex=event.currentIndex;
        switch (event.currentIndex){
          case 0: emit(PageLoadindState()); emit(ProfilePageState(user));
          break;

          case 1:emit(PageLoadindState()); emit(HomePageState(user));
          break;

          case 2:emit(PageLoadindState()); emit(AddingPageState(user));
        }


      }catch (e){
        print(e);
      }

    });
  }

}