import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
@immutable
abstract class ProductEvent extends Equatable{
  const ProductEvent();
  @override
  List<Object?> get props =>[];
}
class getdataEvent extends ProductEvent{
  @override
  List<Object?> get props =>[];
}
class deletedata extends ProductEvent{
  final id;
   deletedata( this.id);

  @override
  List<Object?> get props =>[];
}
class updatedata extends ProductEvent{
  final id;
  final name;
  final state;
  final city;
  final image;
  final dob;
  updatedata(this.id,this.name,this.state,this.city,this.image,this.dob);
  @override
  List<Object?> get props =>[];
}
class adddata extends ProductEvent{
  final name;
  final state;
  final country;
  final city;
  final image;
  final dob;

  // adddata(TextEditingController name);
  adddata(this.name,this.state,this.country,this.city,this.image,this.dob);
  @override
  List<Object?> get props =>[];
}