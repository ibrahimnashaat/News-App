import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:news_app/layout/news_app/cubit/cubit.dart';
import 'package:news_app/layout/news_app/cubit/states.dart';
import 'package:news_app/network/dio/dio.dart';
import 'package:news_app/network/local/cach_helper/cach_helper.dart';

import 'layout/news_layout/news_layout.dart';

void main() async{

    WidgetsFlutterBinding.ensureInitialized();

    DioHelper.init();
    await CachHelper.init();
    bool? themeDark = CachHelper.getBoolean(key: 'themeDark');
  runApp(MyApp(themeDark));
}

class MyApp extends StatelessWidget {


  final bool? themeDark;

  MyApp(this.themeDark);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => NewsCubit()..getBusiness()..getScience()..getSports()..getThemeData(
        isDark: themeDark,
      ),
      child: BlocConsumer<NewsCubit, NewsStates>(

        listener: (context ,state){},
        builder: (context, state){

          return MaterialApp(

            debugShowCheckedModeBanner: false,
            theme:  ThemeData(



              bottomNavigationBarTheme:  BottomNavigationBarThemeData(
                selectedItemColor: HexColor('#9a906b'),
                backgroundColor: HexColor('#fff2cc'),
                unselectedItemColor: Colors.grey[400]

              ),

              scaffoldBackgroundColor: HexColor('#fff2cc'),

              appBarTheme:   AppBarTheme(

                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: HexColor('#fff2cc'),
                  statusBarIconBrightness: Brightness.dark,
                ),



                backgroundColor:  HexColor('#fff2cc'),
                elevation: 0.0,

                titleTextStyle: TextStyle(
                    color:  HexColor('#9a906b'),
                    fontSize: 20,
                    fontWeight: FontWeight.bold

                ),

                iconTheme: IconThemeData(
                  color: HexColor('#9a906b'),
                ),

              ),
              textTheme: TextTheme(

                bodyText1: TextStyle(

                  color: HexColor('#000000'),
                  fontSize: 18.0,

                ),
              ),
            ),
            darkTheme: ThemeData(


              bottomNavigationBarTheme:  BottomNavigationBarThemeData(
                  selectedItemColor: Colors.lightGreenAccent,
                  backgroundColor: HexColor('#000000'),
                  unselectedItemColor: Colors.greenAccent

              ),

              scaffoldBackgroundColor:  HexColor('#000000'),

              appBarTheme: AppBarTheme(

                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: HexColor('#000000'),
                  statusBarIconBrightness: Brightness.light,
                ),



                backgroundColor:   HexColor('#000000'),

                elevation: 0.0,

                titleTextStyle: TextStyle(
                    color:  Colors.lightGreenAccent,
                    fontSize: 20,
                    fontWeight: FontWeight.bold

                ),

                iconTheme: IconThemeData(
                  color: Colors.lightGreenAccent,
                ),

              ),



              textTheme: TextTheme(

                bodyText1: TextStyle(

                  color: HexColor('#ffffff'),
                  fontSize: 18.0,

                ),
              ),


            ),
            themeMode: NewsCubit.get(context).themeDark ? ThemeMode.dark : ThemeMode.light,

            home : const NewsLayout(),

          );
        },


      ),
    );
    }

}
