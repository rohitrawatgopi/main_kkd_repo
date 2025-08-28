import 'dart:io';

import 'package:paint_shop/core/model/category.model.dart';

abstract class ProfileState {}

class Profilenitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileSuccess extends ProfileState {
  final List<CategoryModel> categoryList;

  ProfileSuccess({required this.categoryList});
}

class ProflieFailure extends ProfileState {
  final String message;
  ProflieFailure(this.message);
}

class FilePickeSuccess extends ProfileState {
  final File file;

  FilePickeSuccess({required this.file});
}

class FilePickefailer extends ProfileState {
  final String msg;

  FilePickefailer({required this.msg});
}

class FileUploadSuccess extends ProfileState {
  final String msg;

  FileUploadSuccess({required this.msg});
}

class FileUploadLoading extends ProfileState {}

class FileUploadFail extends ProfileState {
  final String msg;

  FileUploadFail({required this.msg});
}

class SlecteStateSuccess extends ProfileState {
  final String state;

  SlecteStateSuccess({required this.state});
}

class SlecteBankSuccess extends ProfileState {
  final String bank;

  SlecteBankSuccess({required this.bank});
}
