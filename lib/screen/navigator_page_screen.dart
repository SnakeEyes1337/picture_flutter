import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import 'package:picture_flutter/bloc/pageNavigatorBloc/page_navigator_bloc.dart';
import 'package:picture_flutter/bloc/pageNavigatorBloc/page_navigator_event.dart';
import 'package:picture_flutter/bloc/pageNavigatorBloc/page_navigator_state.dart';
import 'package:picture_flutter/screen/home_screen.dart';

class PageNavigatorScreen extends StatelessWidget {
  const PageNavigatorScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    return  BlocProvider(
        create: (context) => NavigatorPageBloc(),
        child: Scaffold(
          body: BlocListener<NavigatorPageBloc, NavigatorPageState>(
            listener: (context, state){},
            child: BlocBuilder<NavigatorPageBloc, NavigatorPageState>(
                builder: (context, state){
                  if (state is PageInitialState){
                    context.read<NavigatorPageBloc>().add(PageLoadEvent(1));
                  }
                   if(state is PageLoadindState){
                     return Scaffold(
                       body: Center(
                           child:CircularProgressIndicator()),
                     );
                   }
                   if(state is HomePageState){
                     return HomePage(state.user);
                   }
                   if(state is ProfilePageState){
                     return Center(child: CircularProgressIndicator(),);
                   }
                   if(state is AddingPageState){
                    return Center(child: Text("Adding Page"),);
                  }

                   return Scaffold(body: Text("fuck this"),);

                },
            ),
          ),


      bottomNavigationBar: BlocBuilder<NavigatorPageBloc, NavigatorPageState>(
              builder: (context, state) {
                  return BottomNavigationBar(
                      items: [
                        BottomNavigationBarItem(icon: Icon(Icons.person),
                            label: "Profile"
                        ),
                        BottomNavigationBarItem(icon: Icon(Icons.home),
                            label: "Home"
                        ),
                        BottomNavigationBarItem(icon: Icon(Icons.add_box),
                            label: "Add"
                        )
                      ],
                     currentIndex:BlocProvider.of<NavigatorPageBloc>(context).currentIndex ,
                    onTap: (index){
                        context.read<NavigatorPageBloc>().add(PageLoadEvent(index));
                    },
                  );
              }
            ),
        ),
    );
        }

  }

