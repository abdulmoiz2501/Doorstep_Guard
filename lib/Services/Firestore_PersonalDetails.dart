import 'package:cloud_firestore/cloud_firestore.dart';

class DataBaseService {
  final String uid;
  final CollectionReference userDetails =
      FirebaseFirestore.instance.collection('User Details');

  DataBaseService({this.uid});

  Future updateUserData(String fullName,String cnic,String phone,String email,String phase,String street,String houseNo,String postalCode) async {
    return await userDetails.doc(uid).set({
      "user type ": 'guard',
      "Full Name ": fullName,
      "Cnic ": cnic,
      "Phone ": phone,
      "Email ": email,
      "Phase ": phase,
      "Street No ": street,
      "House No ": houseNo,
      "Postal Code  ": postalCode,
    });
  }


  Future<void> editProduct(
      String fullName,
      String cnic,
      String phone,
      String email,
      String phase,
      String street,
      String houseNo,
      String postalCode) async {
    await FirebaseFirestore.instance
        .collection("User Details")
        .doc(uid)
        .update({
      "Full Name ": fullName,
      "Cnic ": cnic,
      "Phone ": phone,
      "Email ": email,
      "Phase ": phase,
      "Street No ": street,
      "House No ": houseNo,
      "Postal Code  ": postalCode,
    });
  }
}
