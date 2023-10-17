
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/MainSearch.dart';
import 'package:untitled/ProviderData.dart';
import 'package:untitled/main.dart';


// void main(){
//   runApp(MyApp());
// }



 class MyApp extends StatelessWidget{
  @override
   Widget build(BuildContext conetxt){
    return MaterialApp(
       home: ChangeNotifierProvider(
         create: (conetxt)=> ProviderData() ,
         child: MyNavigation()
       ),
    );
  }
 }

 class MyNavigation extends StatefulWidget {
  @override
  State<MyNavigation> createState() => _MyNavigation();


}

 class _MyNavigation extends State<MyNavigation>{

  void onItemdTapped(int Index){
    setState(() {
       _selectedIndex = Index ;
    });
  }
  int _selectedIndex = 0 ;
  final List<Widget> screen =[
    MyHomePage(title: 'hello',) ,
    MainSearch(),

  ];

  @override
   Widget build(BuildContext context){
      return MaterialApp(
       home:Scaffold(
         appBar: AppBar(
           title: Text('Mepac SpareParts'),
         ),
         body: screen[_selectedIndex],
         bottomNavigationBar: BottomNavigationBar(
           currentIndex:  _selectedIndex,
           onTap: onItemdTapped,
           items: [
             BottomNavigationBarItem(
                 icon: Icon(Icons.home),
               label: 'Home'
             ),
             BottomNavigationBarItem(
              icon:Image(image: AssetImage('assets/spare-parts.png') ,height: 25,color: Colors.blue,),
             // icon: Icon(Icons.favorite),
               label: 'Image'
             )
           ],
         )
       )

      );
  }
 }



class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Home Screen'),
    );
  }
}


// class ImageItems extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Text('ImageItems'),
//     );
//   }
// }

