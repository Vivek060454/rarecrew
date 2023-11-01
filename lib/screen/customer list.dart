import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../Repository/repository.dart';
import '../bloc/blocs/customer_bloc.dart';
import '../bloc/blocstate/customer_state.dart';
import '../bloc/blocsvent/customer_event.dart';
import '../theme.dart';
import 'Auth/add)_customer.dart';
import 'Auth/edit_customer.dart';
import 'Auth/login.dart';



class Home extends StatefulWidget {
  const Home({super.key, });

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final uid1 = new FlutterSecureStorage();

  @override
  void initState() {
    getdata();

    // TODO: implement initState
    super.initState();
  }
  getdata(){
    context.read<ProfileBloc>().add(getdataEvent());

  }



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        title: Text("List of Customer"),

        centerTitle: true,

      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(

            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[

              BlocBuilder <ProfileBloc,ProductState>(
                  builder:(context,state){
                    if(state is ProductLoading){
                      Center(child: CircularProgressIndicator());
                    }
                    if(state is ProductSuccess){

                      return Column(
                        children: [
                          Align(
                            alignment:Alignment.topRight,
                            child:   Padding(
                              padding: const EdgeInsets.all(8.0),
                              child:   InkWell(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>BlocProvider(
                                      create: (context)=>ProfileBloc(WebServise()),
                                      child: AddCustomer()),));
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    // color: Mytheme().primary,
                                      borderRadius: BorderRadius.all( Radius.circular(10)),
                                      border:Border.all(color: Mytheme().primary, )
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 4,bottom: 4,left: 8,right: 8),
                                    child: Text(' ADD ',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500,color:  Mytheme().primary,),),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Align(
                            alignment:Alignment.topLeft,
                            child:   Padding(
                              padding: const EdgeInsets.all(8.0),
                              child:   Container(

                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(' Customer List ',style: TextStyle(fontSize: 22,fontWeight: FontWeight.w600,color:  Mytheme().primary,),),
                                ),
                              ),
                            ),
                          ),

                          for(var i=0;i<state.model.length;i++)...[
                            state.model.length==0?Text('No customer list'):  Padding(
                              padding: const EdgeInsets.only(top: 8,bottom: 8,left: 8,right: 8),
                              child: Container(
                                decoration: BoxDecoration(

                                  color: Colors.white,

                                  borderRadius:  BorderRadius.circular(13),

                                  border: Border.all(color: Colors.grey,),

                                  boxShadow: [

                                    BoxShadow(

                                        color: Mytheme().primary,



                                        offset: Offset(0,- 1)),

                                    BoxShadow(

                                        color: Color.fromRGBO(0, 0, 100, 0),

                                        offset: Offset(3, 3),

                                        blurRadius: 1,

                                        spreadRadius: 2)

                                  ],

                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: ListTile(
                                    leading: ConstrainedBox(
                                      constraints: const BoxConstraints(
                                          minWidth: 50,
                                          minHeight: 260,
                                          maxWidth: 55,
                                          maxHeight: 264
                                      ),
                                      child:  CircleAvatar(
                                        minRadius: 13,
                                        maxRadius: 16,
                                        child: ClipRRect(
                                            borderRadius: BorderRadius.all(Radius.circular(20)),
                                            child: FadeInImage.assetNetwork(
                                              placeholder: 'assets/Avatar_3.png',
                                              image:  state.model[i].image,
                                              fit: BoxFit.cover,
                                            )),
                                      ),
                                    ),

                                    title: Text(state.model[i].name,maxLines:1, overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 19,fontWeight: FontWeight.bold),),
                                    subtitle: Text(state.model[i].city+','+state.model[i].state,maxLines:2, overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 13,color: Colors.black54),),
                                    trailing: PopupMenuButton(
                                      child: Container(
                                          height: 40,
                                          width: 40,

                                          child: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Icon(Icons.more_vert_outlined)
                                          )
                                        //   IconButton(icon: Icon(Icons.edit),onPressed: (){
                                        //   Navigator.push(context, MaterialPageRoute(builder: (context)=>EditAdmin(alladminresponse!.data[index])));
                                        // },),
                                      ),
                                      elevation: 0,
                                      // shape:  TooltipShape(),
//

//

                                      offset: Offset(0, -15),
                                      color: Color.fromRGBO(255, 255, 255, 0.1),
//

                                      itemBuilder: (context) {
                                        return [
                                          PopupMenuItem(
                                            value: 'edit',
                                            child: Row(
                                              children: [
                                                Padding(
                                                  padding:
                                                  const EdgeInsets.only(
                                                      top: 2,
                                                      left: 2,
                                                      right: 2,
                                                      bottom: 2),
                                                  child: InkWell(
                                                    onTap: () {
                                                      Navigator.push(context, MaterialPageRoute(builder: (context)=>BlocProvider(
                                                          create: (context)=>ProfileBloc(WebServise()),
                                                          child: EditCustomer(state.model[i])),));    //
                                                    },
                                                    child: Container(
                                                        height: 40,
                                                        width: 40,
                                                        decoration:
                                                        BoxDecoration(
                                                          borderRadius:
                                                          BorderRadius
                                                              .circular(40),
                                                          color:
                                                          Mytheme().primary,
                                                          boxShadow: [
                                                            BoxShadow(
                                                              color:
                                                              Colors.grey,
                                                              //New
                                                              blurRadius: 5.0,
                                                            )
                                                          ],
                                                        ),
                                                        child: Padding(
                                                            padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                            child: Icon(Icons.edit)
                                                        )
                                                      //   IconButton(icon: Icon(Icons.edit),onPressed: (){
                                                      //   Navigator.push(context, MaterialPageRoute(builder: (context)=>EditAdmin(alladminresponse!.data[index])));
                                                      // },),
                                                    ),
                                                  ),
                                                ),
                                                PopupMenuItem(
                                                  value: 'delete',
                                                  child: Padding(
                                                    padding:
                                                    const EdgeInsets.only(
                                                        top: 2,
                                                        left: 2,
                                                        right: 2,
                                                        bottom: 2),
                                                    child: InkWell(
                                                      onTap: () async {
                                                        context.read<ProfileBloc>().add(deletedata(state.model[i].id));
context.read<ProfileBloc>().add(getdataEvent());

                                                      },
                                                      child: Container(
                                                          height: 40,
                                                          width: 40,
                                                          decoration:
                                                          BoxDecoration(
                                                            borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                40),
                                                            color:
                                                            Mytheme().primary,
                                                            boxShadow: [
                                                              BoxShadow(
                                                                color:
                                                                Colors.grey,
                                                                //New
                                                                blurRadius: 5.0,
                                                              )
                                                            ],
                                                          ),
                                                          child: Padding(
                                                            padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                            child: Icon(Icons.delete),
                                                          )
                                                        //   IconButton(icon: Icon(Icons.edit),onPressed: (){
                                                        //   Navigator.push(context, MaterialPageRoute(builder: (context)=>EditAdmin(alladminresponse!.data[index])));
                                                        // },),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ];
                                      },
                                      onSelected: (String value) {
                                        print('You Click on po up menu item');
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ),

//                             Padding(
//                               padding: const EdgeInsets.only(left: 10,right: 10,top: 0,bottom: 0),
//                               child: Container(
//                                 decoration: BoxDecoration(
//                     color: Colors.white,
//                                     borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10)),
//                                     border:Border.all(color: Mytheme().primary, )
//                                 ),
//
//                                 child: Table(
//                                   columnWidths: {
//                                     0:FlexColumnWidth(4),
//                                     1:FlexColumnWidth(4),
//                                     2:FlexColumnWidth(2),
//                                     3:FlexColumnWidth(2)
//                                   },
//                                   children: [
//                                     TableRow(
//                                         children: [
//                                           Container(
//                                             decoration: BoxDecoration(
//                                                 color: Colors.white
//                                               //  borderRadius: BorderRadius.only(topLeft: Radius.circular(10))
//                                             ),
//
//                                             child: Padding(
//                                               padding: const EdgeInsets.all(8.0),
//                                               child: Text(state.model[i].name,style: TextStyle(
//                                                     fontSize: 16,
//                                                     fontWeight: FontWeight.w500,
//                                                     color: Mytheme().primary
//                                                   // color: Color.fromRGBO(158, 63, 97, 100),
//
//                                               )),
//                                             ),
//                                           ),
//                                           Container(
//                                             decoration: BoxDecoration(
//                                                 color: Colors.white
//                                             ),
//
//                                             child: Padding(
//                                               padding: const EdgeInsets.all(8.0),
//                                               child: Text(state.model[i].state,style:  TextStyle(
//                                                     fontSize: 16,
//                                                     fontWeight: FontWeight.w500,
//                                                     color: Mytheme().primary
//                                                   // color: Color.fromRGBO(158, 63, 97, 100),
//                                                 ,
//                                               )),
//                                             ),
//                                           ),
//                                           Container(
//                                             decoration: BoxDecoration(
//                                                 color: Colors.white
//                                               // borderRadius: BorderRadius.only(topRight: Radius.circular(10))
//
//
//
//                                             ),
//
//                                             child: Padding(
//                                               padding: const EdgeInsets.all(8.0),
//                                               child: InkWell(
//                                                   onTap: (){
//                                                     //
//                                                   },
//                                                   child: Icon(Icons.edit)),
//                                             ),
//                                           ),
//
//                                           Container(
//                                             decoration: BoxDecoration(
//                                                 color: Colors.white
//                                               // borderRadius: BorderRadius.only(topRight: Radius.circular(10))
//
//
//
//                                             ),
//
//                                             child: Padding(
//                                               padding: const EdgeInsets.all(8.0),
//                                               child:  InkWell(
//                                                   onTap: () async {
// print('rg');
//
// context.read<ProfileBloc>().add(deletedata(state.model[i].id));
// context.read<ProfileBloc>().add(getdataEvent());
//
// //setState((){});
//                                                   },
//                                                   child: Icon(Icons.delete)),
//                                             ),
//                                           ),
//
//
//                                         ]
//                                     )
//                                   ],
//                                 ),
//                               ),
//                             ),
                          ],

                          // Expanded(
                          //   child: ListView.builder(
                          //     itemCount: widget.data.length,
                          //     itemBuilder: (_, i) => ListTile(
                          //       leading: CircleAvatar(
                          //         child: Text(widget.data[i]!.Productname.substring(0, 1)),
                          //       ),
                          //       title: Text(widget.data[i]!.Productname),
                          //       subtitle: Column(
                          //         children: [
                          //           Text(widget.data[i]!.total),
                          //         ],
                          //       ),
                          //     ),
                          //   ),
                          // ),
                        ],
                      );

                      // return Text(
                      // model.item[0].name
                      // );
                    }
                    if(state is ProductError){
                      return Text(state.msg);                    }
                    return Center(child: CircularProgressIndicator());

                  }


              ),



            ],
          ),
        ),
      ),

    );

  }
}