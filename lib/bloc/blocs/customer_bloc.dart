import 'dart:convert';

import 'package:bloc/bloc.dart';

import '../../Repository/repository.dart';
import '../blocstate/customer_state.dart';
import '../blocsvent/customer_event.dart';


import 'package:http/http.dart' as http;


class ProfileBloc extends Bloc<ProductEvent,ProductState>{
  final WebServise webServise;
  ProfileBloc(this.webServise):super(ProfileInitiate()){
    on<getdataEvent>((event, emit) => _callApi(event,emit));
    on<deletedata>((event, emit)=>_delete(event,emit));
    on<updatedata>((event, emit)=>_update(event,emit));
    on<adddata>((event, emit)=>_adddata(event,emit));
  }
  _callApi(getdataEvent event,Emitter<ProductState> emit)async{

    try{
      emit(ProfileInitiate());
      var data = await webServise.callProfileApi();
      emit(ProductSuccess(data));
    }
    catch(e){
      print(e);
      emit(ProductError("$e"));
    }

  }
  _delete(deletedata event,Emitter<ProductState> emit)async{
    await webServise.delete(event.id);
    // on<getdataEvent>((event, emit) => _callApi(event,emit));
    //    emit(ProfileInitiate());
    //    var dataa = await webServise.callProfileApi();
    //    emit(ProductSuccess(dataa));
    // try{
    //     emit(ProfileInitiate());
    //   var data = await webServise.delete(event.id);
    //  if( data.statusCode==200){
    //    on<getdataEvent>((event, emit) => _callApi(event,emit));
    //    emit(ProfileInitiate());
    //    var dataa = await webServise.callProfileApi();
    //    emit(ProductSuccess(dataa));
    //  }
    //   else{
    //    emit(ProductError(data.body));
    //  }
    //   print('delete');
    //
    // }
    // catch(e){
    //   print(e);
    //   emit(ProductError("$e"));
    // }

  }
  _update(updatedata event,Emitter<ProductState> emit)async{

    await webServise.update(event.id,event.name,event.state,event.city,event.image,event.dob);


  }
  _adddata(adddata event,Emitter<ProductState> emit)async{
    await webServise.add(event.name,event.country,event.state,event.city,event.image,event.dob);


  }
}