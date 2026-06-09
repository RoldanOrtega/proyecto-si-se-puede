class UserStorage {
  static final Map<String, String> _users = {
    "andrea@lectura.com": "12345" 
  };

  static void saveUser(String email, String password) {
    _users[email] = password;
  }

  static bool verifyUser(String email, String password) {
    return _users.containsKey(email) && _users[email] == password;
  }
}