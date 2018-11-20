import 'dart:convert';
import 'dart:typed_data';
// import 'package:pointycastle/pointycastle.dart' as pointy;
// import 'package:pointycastle/export.dart';
import 'package:ninja/utils/hex_string.dart';
import 'package:ninja/utils/big_int.dart';

part 'engine.dart';

/// Public key for RSA encryption
class RSAPublicKey {
  /// Modulus
  final BigInt n;

  /// Public exponent
  final BigInt e;

  RSAPublicKey(this.n, this.e);
}

/// Private key for RSA encryption
class RSAPrivateKey implements RSAPublicKey {
  /// Modulus
  final BigInt n;

  /// Public exponent
  final BigInt e;

  /// Private exponent
  final BigInt d;

  /// Prime p
  final BigInt p;

  /// Prime q
  final BigInt q;

  RSAPrivateKey(this.n, this.e, this.d, this.p, this.q);
}

class RSAEncoder extends Converter<String, String> {
  final RSAPublicKey key;

  RSAEncoder(this.key);

  @override
  String convert(String input) {
    var engine = RSAEncryptionEngine(key);
    Uint8List output = engine.process(Uint8List.fromList(input.codeUnits));
    return hexStringDecoder.convert(output);
  }
}

class RSADecoder extends Converter<String, String> {
  final RSAPrivateKey key;

  RSADecoder(this.key);

  @override
  String convert(String input) {
    var engine = RSADecryptionEngine(key);
    Uint8List output = engine.process(hexStringEncoder.convert(input));
    return String.fromCharCodes(output);
  }
}

class RSA extends Codec<String, String> {
  @override
  final RSAEncoder encoder;

  @override
  final RSADecoder decoder;

  RSA(RSAPublicKey key)
      : encoder = RSAEncoder(key),
        decoder = key is RSAPrivateKey ? RSADecoder(key) : null;

  @override
  String decode(String encoded) {
    if (decoder == null) throw Exception('Do not have Private key!');
    return super.decode(encoded);
  }
}
