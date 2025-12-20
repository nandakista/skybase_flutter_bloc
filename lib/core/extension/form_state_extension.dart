import 'package:flutter/material.dart';

extension FormStateExtension on GlobalKey<FormState> {
  bool saveAndValidate() {
    final form = currentState;
    if (form == null) return false;
    if (!form.validate()) return false;
    form.save();
    return true;
  }
}