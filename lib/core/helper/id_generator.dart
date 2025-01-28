import 'package:uuid/uuid.dart';

class IdGenerator {
  static final Uuid _uuid = Uuid();

  /// Generates a unique ID for each instance.
  static String generateId() {
    return _uuid.v4(); // Generates a unique UUID
  }
}
