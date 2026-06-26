/// Validation utilities
class AppValidators {
  AppValidators._();

  /// Validates email format
  static String? email(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }

    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );

    if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email address';
    }

    return null;
  }

  /// Validates password
  static String? password(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }

    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }

    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regex = RegExp(pattern);

    if (!regex.hasMatch(value)) {
      return 'Must contain uppercase, lowercase, number, and special character (!@#)';
    }

    return null;
  }

  /// Validates password confirmation
  static String? confirmPassword(String? currentValue, String? originValue) {
    if (currentValue == null || currentValue.isEmpty) {
      return 'Please confirm your password';
    }

    if (currentValue != originValue) {
      return 'Passwords do not match';
    }

    return null;
  }

  /// Validates required field
  static String? required(String? value, [String? fieldName]) {
    if (value == null || value.isEmpty) {
      return '${fieldName ?? 'This field'} is required';
    }
    return null;
  }

  /// Validates phone number (Iraqi format: 07xxxxxxxxx)
  static String? phone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number is required';
    }

    final phoneRegex = RegExp(r'^[0-9]{11}$');
    if (!phoneRegex.hasMatch(value)) {
      return 'Phone number must be 11 digits';
    }

    return null;
  }

  /// Validates age
  static String? age(String? value) {
    if (value == null || value.isEmpty) {
      return 'Age is required';
    }

    final ageRegex = RegExp(r'^[1-9][0-9]{0,1}$');
    if (!ageRegex.hasMatch(value)) {
      return 'Please enter a valid age';
    }

    return null;
  }

  static String? year(String? value) {
    if (value == null || value.isEmpty) {
      return 'Year is required';
    }
    if (!RegExp(r'^\d{4}$').hasMatch(value)) {
      return 'Enter a 4-digit year';
    }
    final year = int.parse(value);
    final maxYear = DateTime.now().year + 1;
    if (year < 1950 || year > maxYear) {
      return 'Enter a valid year (1950–$maxYear)';
    }
    return null;
  }

  /// Validates full name (at least 3 words)
  static String? fullName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Full name is required';
    }

    String trimmedValue = value.trim();

    // Split by spaces and filter out empty strings
    List<String> words = trimmedValue.split(RegExp(r'\s+'));

    // Check if there are at least 3 words
    if (words.length < 3) {
      return 'Please enter your full name (first, middle, last)';
    }

    // Check that each word contains at least 2 characters
    for (var word in words) {
      if (word.length < 2) {
        return 'Each part of the name must have at least 2 characters';
      }
    }

    return null;
  }

  /// Validates name
  static String? name(String? value, {String? fieldName}) {
    if (value == null || value.isEmpty) {
      return '${fieldName ?? 'Name'} is required';
    }

    if (value.length < 2) {
      return '${fieldName ?? 'Name'} must be at least 2 characters';
    }

    return null;
  }

  /// Validates username
  static String? username(String? value) {
    if (value == null || value.isEmpty) {
      return 'Username is required';
    }

    if (value.length < 4) {
      return 'Username must be at least 4 characters';
    }
    if (value.length > 20) {
      return 'Username must not exceed 20 characters';
    }

    final RegExp usernameRegex = RegExp(r'^[a-zA-Z][a-zA-Z0-9_]*$');

    if (!usernameRegex.hasMatch(value)) {
      if (value.contains(' ')) {
        return 'Spaces are not allowed';
      }
      if (RegExp(r'^[^a-zA-Z]').hasMatch(value)) {
        return 'Username must start with a letter';
      }
      return 'Only English letters, numbers, and underscores are allowed';
    }

    return null;
  }
}
