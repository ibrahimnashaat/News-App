
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/news_app/cubit/states.dart';
import 'package:news_app/modules/business/business.dart';
import 'package:news_app/modules/science/science.dart';
import 'package:news_app/modules/sports/sports.dart';
import 'package:news_app/network/dio/dio.dart';
import 'package:news_app/network/local/cach_helper/cach_helper.dart';

class NewsCubit extends Cubit<NewsStates>{
  NewsCubit() : super(NewsInitialState());

   static NewsCubit get(context) => BlocProvider.of(context);

  int currentIndex=0;

  List<BottomNavigationBarItem> bottomNavItems =const [

    BottomNavigationBarItem(
      icon: Icon(
        Icons.business_center,
      ),
      label: 'Business'
    ),
    BottomNavigationBarItem(
        icon: Icon(
          Icons.science,
        ),
        label: 'Science'
    ),
    BottomNavigationBarItem(
        icon: Icon(
          Icons.sports_baseball,
        ),
        label: 'Sports'
    ),


  ];

   void changeBottomNavBar ( int index){

    currentIndex = index;

    if (index == 1)
      getScience();
    if (index == 2)
      getSports();


    emit(NewsBottomNavState());
  }


  List<Widget> screens = const  [

    BusinessScreen(),
    ScienceScreen(),
    SportsScreen(),


  ];

   List<dynamic> business = [];
  List<dynamic> sports = [];
  List<dynamic> science = [];

   void getBusiness () {

     emit(NewsGetBusinessLoadingState());

     if ( business.length ==0){

       DioHelper.getData(url: 'v2/top-headlines', query: {
         'country' : 'eg',
         'category':'business',
         'apiKey' : 'aaa23a5a71e946aebc7e8e4fa1326f08',
       }).then((value) {

         business = value.data['articles'];
         print(business[0]['title']);

         emit(NewsGetBusinessSuccessState());

       }).catchError((error) {
         print(error.toString());

         emit(NewsGetBusinessErrorState(error.toString()));
       });

     }
     else
       {
         emit(NewsGetBusinessSuccessState());
       }





   }
  void getSports () {

    emit(NewsGetSportsLoadingState());
     if (sports.length ==0){
       DioHelper.getData(url: 'v2/top-headlines', query: {
         'country' : 'eg',
         'category':'sports',
         'apiKey' : 'aaa23a5a71e946aebc7e8e4fa1326f08',
       }).then((value) {

         sports = value.data['articles'];
         print(sports[0]['title']);

         emit(NewsGetSportsSuccessState());

       }).catchError((error) {
         print(error.toString());

         emit(NewsGetSportsErrorState(error.toString()));
       });
     }else {
       emit(NewsGetSportsSuccessState());
     }




  }
  void getScience () {

    emit(NewsGetScienceLoadingState());

    if (science.length == 0){
      DioHelper.getData(url: 'v2/top-headlines', query: {
        'country' : 'eg',
        'category':'science',
        'apiKey' : 'aaa23a5a71e946aebc7e8e4fa1326f08',
      }).then((value) {

        science = value.data['articles'];
        print(science[0]['title']);

        emit(NewsGetScienceSuccessState());

      }).catchError((error) {
        print(error.toString());

        emit(NewsGetScienceErrorState(error.toString()));
      });
    }else {
      emit(NewsGetScienceSuccessState());
    }




  }
  

  bool themeDark = true ;

   void getThemeData( {bool? isDark}){


     if(isDark != null){
       themeDark = isDark ;
       emit( NewsGetThemeDataState());
     }
     else {themeDark = !themeDark;

     CachHelper.putBoolean(key: 'themeDark', value: themeDark).then((value) {
       emit( NewsGetThemeDataState());
     });}




   }


   List<dynamic> search = [];

  void getSearch (String value) {

    emit(NewsGetSearchLoadingState());

      DioHelper.getData(url: 'v2/top-headlines', query: {

        'q':'$value',
        'apiKey' : 'aaa23a5a71e946aebc7e8e4fa1326f08',
      }).then((value) {

        search = value.data['articles'];
        print(search[0]['title']);

        emit(NewsGetSearchSuccessState());

      }).catchError((error) {
        print(error.toString());

        emit(NewsGetSearchErrorState(error.toString()));
      });





  }
  
}