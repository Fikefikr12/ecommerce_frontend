class myValidator{
  static String? validateEmail(String? value){
    if(value == null || value.isEmpty){
      return 'email is required';
    }

    // regular expression for email validation
   final emailRegExp =RegExp(r'^[\W-\.]+@([\W-]+\.)[\W-]{2,4}$');

   if(!emailRegExp.hasMatch(value)){
    return 'Invalid email address.';
   }

    return null;
  }
   
  static String? validatePassWord(String? value){
    if (value == null || value.isEmpty){
   return 'Passeord is required.';
    }


// check for minimum  password length   
   if (value.length < 6){
    return" Password must be at least 6 characters long .";
   }

// check for uppercase letter 
   if (!value.contains(RegExp(r'[A-Z]'))){
    return" Password must contain at leasr one uppercase letter.";
  }


// check for numbers 
   if (!value.contains(RegExp(r'[0-9]'))){
    return" Password must contain at leasr one number.";
  }


// check for numbers 
   if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))){
    return" Password must contain at leasr one special character.";
  }
  return null;

  }

static String? validatePhoneNumber(String? value){
  if(value == null || value.isEmpty){
    return 'phone number is registered.';
  }

  // Regular expression for number validation (assuming a 10 phone number format)
  final phoneRegExp=RegExp(r'^\d{10}$');
  
   if(!phoneRegExp.hasMatch(value)){
    return 'Invalid phone number format (10 fdigits required).';
   }
   return null;
}

}