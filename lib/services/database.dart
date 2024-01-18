 import 'package:cloud_firestore/cloud_firestore.dart';
class DatbaseMethods{

  Future addBookingDeatails(Map<String,dynamic> bookinhInfoMap,String id)
  async{ 
    return await FirebaseFirestore.instance
    .collection("Booking")
    .doc(id)
    .set(bookinhInfoMap);
  }

  Future <Stream<QuerySnapshot>> getBookingDetails() async{
    return await FirebaseFirestore.instance.collection("Booking").snapshots();
  }

   Future updateBookingDetails(Map<String,dynamic> updateInfo,String id)
  async{ 
    return await FirebaseFirestore.instance
    .collection("Booking")
    .doc(id)
    .set(updateInfo);
  }

Future deleteBookingDetails(String id) async {
  return await FirebaseFirestore.instance
      .collection("Booking")
      .doc(id)
      .delete();
}

  
  //  Future deleteBookingDetails(String id)
  // async{ 
  //   return await FirebaseFirestore.instance
  //   .collection("Booking")
  //   .doc(id)
  //   ;
  // }

  Future<List<Map<String, dynamic>>> getReservationsByHallName(String hallName) async {
    // Replace this with actual logic to fetch reservations from the database
    // based on the hall name
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection("Booking") 
          .where("Hall", isEqualTo: hallName)
          .get();

      return querySnapshot.docs
          .map((DocumentSnapshot doc) => doc.data() as Map<String, dynamic>)
          .toList();
    } catch (e) {
      print("Error fetching reservations: $e");
      throw e;
    }
  }

}
