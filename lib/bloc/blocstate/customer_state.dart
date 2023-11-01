import 'package:equatable/equatable.dart';


abstract class ProductState extends Equatable{
  const ProductState();
}
class ProfileInitiate extends ProductState{
  @override
  List<Object?> get props =>[];
}
class ProductLoading extends ProductState{
  @override
  // TODO: implement props
  List<Object?> get props => [];

}
class ProductSuccess extends ProductState{
  final model;
  ProductSuccess(this.model);
  @override
  // TODO: implement props
  List<Object?> get props => [model];

}
class ProductError extends ProductState{
  final String msg;
  ProductError(this.msg);
  @override
  // TODO: implement props
  List<Object?> get props => [msg];

}