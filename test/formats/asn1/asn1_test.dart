import 'package:ninja/formats/asn1/asn1.dart';
import 'package:ninja/ninja.dart';
import 'package:ninja/utils/big_int.dart';
import 'package:test/test.dart';

import 'package:asn1lib/asn1lib.dart' as asn1;

void main() {
  group('ASN1', () {
    final integer = BigInt.parse(
        '20620915813302906913761247666337410938401372343750709187749515126790853245302593205328533062154315527282056175455193812046134139935830222032257750866653461677566720508752544506266533943725970345491747964654489405936145559121373664620352701801574863309087932865304205561439525871868738640172656811470047745445089832193075388387376667722031640892525639171016297098395245887609359882693921643396724693523583076582208970794545581164952427577506035951122669158313095779596666008591745562008787129160302313244329988240795948461701615228062848622019620094307696506764461083870202605984497833670577046553861732258592935325691');

    final octet = bigIntToBytes(integer);

    test('ASN1Sequence.encode', () {
      expect(
          hexEncode(ASN1Sequence(
              [ASN1Integer(integer), ASN1Null(), ASN1Boolean(true)]).encode()),
          '3082010a0282010100a3595fd150ee7d21f051f6a20d8b9adabfa8fc4a3b9ac037fcc327261b519c019028a3f157172fd13f8bfa001be3c7f06f6e28ae28842da037cd54caebd14c8822b501d4a447f29b450506b444a1c80b5aab4140158ff5b68d9527e086d7d9a96b7d66fa0e811c2d4d1b25796ed8b56e04af345182efed1804916dbbfd1514358df90ccf2845fb2043248337abafdbbe5b307b16fb485dd6cf16bbd9fab1d1f99dfadee1e01b89d3a509c2845b400c37a26c7b4aa880232c1effa084fc5cbead313a4868a01883d98cbd19a8ad04ee130e92e7b2ea4d6036417fbd57649a4c3ee7d134dbd84881635404fa8819ed3fac47391eaa3e5232a95bd67c9ebc972ffb05000101ff');
    });

    test('ASN1Boolean.encode', () {
      expect(hexEncode(ASN1Boolean(false).encode()), '010100');
      expect(hexEncode(ASN1Boolean(true).encode()), '0101ff');
    });

    test('ASN1Integer.encode', () {
      expect(hexEncode(ASN1Integer(integer).encode()),
          '0282010100a3595fd150ee7d21f051f6a20d8b9adabfa8fc4a3b9ac037fcc327261b519c019028a3f157172fd13f8bfa001be3c7f06f6e28ae28842da037cd54caebd14c8822b501d4a447f29b450506b444a1c80b5aab4140158ff5b68d9527e086d7d9a96b7d66fa0e811c2d4d1b25796ed8b56e04af345182efed1804916dbbfd1514358df90ccf2845fb2043248337abafdbbe5b307b16fb485dd6cf16bbd9fab1d1f99dfadee1e01b89d3a509c2845b400c37a26c7b4aa880232c1effa084fc5cbead313a4868a01883d98cbd19a8ad04ee130e92e7b2ea4d6036417fbd57649a4c3ee7d134dbd84881635404fa8819ed3fac47391eaa3e5232a95bd67c9ebc972ffb');
    });

    test('ASN1OctetString.encode', () {
      expect(hexEncode(ASN1OctetString(octet).encode()),
          '04820100a3595fd150ee7d21f051f6a20d8b9adabfa8fc4a3b9ac037fcc327261b519c019028a3f157172fd13f8bfa001be3c7f06f6e28ae28842da037cd54caebd14c8822b501d4a447f29b450506b444a1c80b5aab4140158ff5b68d9527e086d7d9a96b7d66fa0e811c2d4d1b25796ed8b56e04af345182efed1804916dbbfd1514358df90ccf2845fb2043248337abafdbbe5b307b16fb485dd6cf16bbd9fab1d1f99dfadee1e01b89d3a509c2845b400c37a26c7b4aa880232c1effa084fc5cbead313a4868a01883d98cbd19a8ad04ee130e92e7b2ea4d6036417fbd57649a4c3ee7d134dbd84881635404fa8819ed3fac47391eaa3e5232a95bd67c9ebc972ffb');
    });

    test('ASN1Null.encode', () {
      expect(hexEncode(ASN1Null().encode()), '0500');
    });

    test('ASN1ObjectIdentifier.encode', () {
      expect(
          hexEncode(
              ASN1ObjectIdentifier.fromString('1.25.140.134569').encode()),
          '060641810c889b29');
    });

    test('ASN1BitString.encode', () {
      expect(hexEncode(ASN1BitString(octet, unusedBits: 4).encode()),
          '0382010104a3595fd150ee7d21f051f6a20d8b9adabfa8fc4a3b9ac037fcc327261b519c019028a3f157172fd13f8bfa001be3c7f06f6e28ae28842da037cd54caebd14c8822b501d4a447f29b450506b444a1c80b5aab4140158ff5b68d9527e086d7d9a96b7d66fa0e811c2d4d1b25796ed8b56e04af345182efed1804916dbbfd1514358df90ccf2845fb2043248337abafdbbe5b307b16fb485dd6cf16bbd9fab1d1f99dfadee1e01b89d3a509c2845b400c37a26c7b4aa880232c1effa084fc5cbead313a4868a01883d98cbd19a8ad04ee130e92e7b2ea4d6036417fbd57649a4c3ee7d134dbd84881635404fa8819ed3fac47391eaa3e5232a95bd67c9ebc972ffb');
    });
  });
}
