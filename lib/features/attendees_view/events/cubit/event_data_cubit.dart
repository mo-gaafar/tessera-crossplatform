import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

class DataCubit<T> extends Cubit<T> {
  DataCubit(T initialState) : super(initialState);

  void setData(T newData) {
    emit(newData);
  }
}