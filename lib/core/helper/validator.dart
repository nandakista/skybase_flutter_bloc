import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

sealed class Validate {
  static FormFieldValidator<String> regex({
    required RegExp regex,
    required String err,
  }) {
    return (v) {
      if (v != null && regex.hasMatch(v)) {
        return null;
      } else {
        return err;
      }
    };
  }
}

class Validator {
  static FormFieldValidator<T> list<T>(List<FormFieldValidator<T>> validators) {
    return (valueCandidate) {
      for (var validator in validators) {
        final validatorResult = validator.call(valueCandidate);
        if (validatorResult != null) {
          return validatorResult;
        }
      }
      return null;
    };
  }

  static FormFieldValidator<String> required({String? message}) {
    return (value) {
      if (value == null || value.trim().isEmpty) {
        return message ?? 'txt_field_cannot_be_empty'.tr();
      }
      return null;
    };
  }

  static FormFieldValidator<String> name({String? err}) {
    RegExp regex = RegExp(
      r"^^[a-zA-Z]+(([',. -][a-zA-Z ])?[a-zA-Z]*)*[a-zA-Z]\s*$",
    );
    return Validate.regex(regex: regex, err: err ?? 'txt_valid_name'.tr());
  }

  static FormFieldValidator<String> email({String? err}) {
    RegExp regex = RegExp(r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+');
    return Validate.regex(regex: regex, err: err ?? 'txt_valid_email'.tr());
  }

  static FormFieldValidator<String> phone({String? err}) {
    RegExp regex = RegExp(r'^(\+628|628|08)[1-9][0-9]{7,11}$');
    return Validate.regex(regex: regex, err: err ?? 'txt_valid_phone'.tr());
  }

  static FormFieldValidator<String> password({String? err}) {
    // contains 8 char
    RegExp regex = RegExp(r"^.*(?=.{8,}).*$");

    /// Contains 8 char, 1 Uppercase, 1 Lowercase, 1 number
    // RegExp regex = RegExp(r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[A-Za-z\d!@#$%^&*()_+=-{};:',<.>?`\/\|~-]{8,}$");

    // Minimum 8 characters, at least one uppercase letter, one lowercase letter and one number:
    // RegExp regex = RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{8,}$');

    // Minimum 8 characters, at least one uppercase, one lowercase, and one number:
    // RegExp regex = RegExp(r'(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[A-Za-z\d!@#$%^&*()_+=-{};:'",<.>?`\/\|~-]{8,}');

    // Minimum 8 characters, at least one uppercase, one lowercase, one number and one special character:
    // RegExp regex = RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*()_+=-{};:'",<.>?`\/\|~-])[A-Za-z\d!@#$%^&*()_+=-{};:'",<.>?`\/\|~-]{8,}$');

    return Validate.regex(regex: regex, err: err ?? 'txt_valid_password'.tr());
  }

  static FormFieldValidator<String> notEmpty({String? err}) {
    RegExp regex = RegExp(r'^\S+$');
    return Validate.regex(regex: regex, err: err ?? 'txt_valid_notEmpty'.tr());
  }

  static FormFieldValidator<String> confirmPassword(String password) {
    return (value) {
      if (value == null || value.isEmpty) return 'txt_validation_required'.tr();
      if (value != password) return 'txt_validation_password_mismatch'.tr();
      return null;
    };
  }

  static FormFieldValidator<String> sameValue({
    required String sameAs,
    String? err,
  }) {
    return (value) =>
    value != sameAs ? (err ?? 'txt_field_is_not_same'.tr()) : null;
  }
}
