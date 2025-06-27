class FormValidators {
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'هذا الحقل مطلوب';
    }
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (!emailRegex.hasMatch(value)) {
      return 'أدخل عنوان بريد إلكتروني صالح';
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  static String? validateRequired(String? value, {String fieldName = 'Field'}) {
    if (value == null || value.trim().isEmpty) {
      // return '$fieldName is required';
      return 'هذا الحقل مطلوب';
    }
    return null;
  }

  static String? validatePhone(String? value, {String fieldName = 'Field'}) {
    if (value == null || value.trim().isEmpty) {
      // return '$fieldName is required';
      return 'هذا الحقل مطلوب';
    }else if (value == null || value.trim().length < 9) {
      // return '$fieldName is required';
      return 'رقم الهاتف غير صالح';
    }
    return null;
  }
  static String? validatePassConfirmation(String? value,String pass ,{String fieldName = 'Field'}) {
    if (value == null || value.trim().isEmpty) {
      // return '$fieldName is required';
      return 'هذا الحقل مطلوب';

    }else if(value != null && value != pass){

      return 'يجب أن يكون رقم التأكيد متماثل مع رقم المرور';

    }
    return null;
  }

  static String? validateNewPass(String? value, {String fieldName = 'Field'}) {
    if (value == null || value.trim().isEmpty) {
      // return '$fieldName is required';
      return 'هذا الحقل مطلوب';
    }else if(value.trim().length < 8){
      return 'يجب أن يكون حقل كلمة المرور 8 أحرف على الأقل';
    }
    return null;
  }

// Add more validators as needed
}


