import 'package:aes_crypt/aes_crypt.dart';

class EncryptData {
  static String encryptFile(String path) {
    AesCrypt crypt = AesCrypt();
    crypt.setOverwriteMode(AesCryptOwMode.on);
    crypt.setPassword('my cool password');
    String encFilepath;
    encFilepath = crypt.encryptFileSync(path);
    return encFilepath;
  }

  static String decryptFile(String path) {
    AesCrypt crypt = AesCrypt();
    crypt.setOverwriteMode(AesCryptOwMode.on);
    crypt.setPassword('my cool password');
    String decFilepath;
    decFilepath = crypt.decryptFileSync(path);
    return decFilepath;
  }
}
