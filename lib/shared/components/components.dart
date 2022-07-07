
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:news_app/modules/web_view/web_view.dart';

import '../../layout/news_app/cubit/states.dart';

Widget  buildArticleItem ( article, context) => InkWell(
  onTap: (){
    navigateTo(context, WebViewScreen(article['url']));
  },

  child:   Padding(

    padding: const EdgeInsets.all(20),

    child: Row(

      children: [

        Container(

          width: 120,

          height: 120,



          decoration: BoxDecoration(

            borderRadius: BorderRadius.circular(20),

            image: DecorationImage(

              image: NetworkImage('${article['urlToImage']==null?'https://cdn4.vectorstock.com/i/1000x1000/85/43/error-page-not-found-vector-27898543.jpg':article['urlToImage']}'),

              fit: BoxFit.cover,

            ),

          ),

        ),

        const SizedBox(

          width: 20,

        ),



        Expanded(

          child: Container(



            height: 120,



            child: Column(

              mainAxisAlignment: MainAxisAlignment.start,

              crossAxisAlignment: CrossAxisAlignment.start,

              children:   [



                 Expanded(

                  child: Text(

                    '${article['title']}',

                    style: Theme.of(context).textTheme.bodyText1,

                    maxLines: 3,

                    overflow: TextOverflow.ellipsis,

                  ),

                ),







                Text(

                  '${article['publishedAt']}',

                  style: const TextStyle(

                    color: Colors.grey,



                    fontWeight: FontWeight.bold,



                  ),

                  maxLines: 3,

                  overflow: TextOverflow.ellipsis,

                ),





              ],

            ),

          ),

        ),



      ],

    ),



  ),
);

Widget myDevider () => Padding(
  padding: const EdgeInsets.all(20.0),
  child:  Container(

    height: 1,
    width: double.infinity,
    color: Colors.grey,

  ),
);

Widget articalBuilder (list,context , {isSearch= false}) =>ConditionalBuilder (
  condition :list.length > 0,
  builder :  (context)   {
    return  ListView.separated(
      physics: const  BouncingScrollPhysics(),
      itemBuilder: (context, index) =>  buildArticleItem(list[index],context),
      separatorBuilder:(context , index) => myDevider (),
      itemCount:list.length,
    );

  }   ,
  fallback : (context) {
    return  isSearch ? Container() : const Center(child:  CircularProgressIndicator(),);
  },


);

void navigateTo (context , widget) => Navigator.push(
    context,
    MaterialPageRoute(
        builder: (context)=>widget,
    ),
);