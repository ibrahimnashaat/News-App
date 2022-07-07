import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:news_app/layout/news_app/cubit/cubit.dart';
import 'package:news_app/layout/news_app/cubit/states.dart';
import 'package:news_app/shared/components/components.dart';

class Search extends StatelessWidget {
  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit , NewsStates>(

      listener: (context ,state){},
      builder: (context, state){
        var list = NewsCubit.get(context).search;
        return Scaffold(
          appBar: AppBar(),
          body: Column(
            children: [

              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextFormField(



                  keyboardType: TextInputType.text,
                  validator: (String? value){
                    if (value!.isEmpty){

                      print('search must not be empty');

                    }

                    return null ;

                  },
                  controller: searchController ,
                  onChanged: (value){

                    NewsCubit.get(context).getSearch(value);

                  },
                    decoration: InputDecoration(
                      label: Text(
                          'Search',
                        style: TextStyle(
                          color: HexColor('#808080'),
                        ),
                      ) ,
                      fillColor: Colors.white,
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: BorderSide(
                          color: Colors.blue,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: BorderSide(
                          color: HexColor('#808080'),
                          width: 2.0,
                        ),
                      ),
                    )

                ),

              ),
              Expanded(child: articalBuilder(list, context, isSearch: true)),

            ],
          ),
        ) ;
      },

    );
  }
}
