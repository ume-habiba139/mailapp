// import 'package:flutter/material.dart';
// import 'package:firebase_database/firebase_database.dart';
// import 'package:intl/intl.dart';
// import 'package:remotebac/sendEmail.dart';
//
// class ExpiredNodesScreen extends StatefulWidget {
//   @override
//   _ExpiredNodesScreenState createState() => _ExpiredNodesScreenState();
// }
//
// class _ExpiredNodesScreenState extends State<ExpiredNodesScreen> {
//   final DatabaseReference databaseRef = FirebaseDatabase.instance.ref();
//   Map<String, List<Map<String, dynamic>>> groupedExpiredNodes = {};
//
//   @override
//   void initState() {
//     super.initState();
//     fetchExpiredNodes();
//   }
//
//   void fetchExpiredNodes() async {
//     try {
//       final snapshot = await databaseRef.get();
//       if (snapshot.value != null) {
//         List data = snapshot.value as List;
//         Map<String, List<Map<String, dynamic>>> tempMap = {};
//         String currentDate = DateFormat('dd-MM-yy').format(DateTime.now());
//
//         for (int i = 0; i < data.length; i++) {
//           if (data[i] != null) {
//             final node = data[i] as Map<dynamic, dynamic>;
//             String? actionDate = node['V__Action_Date'];
//             if (actionDate != null && actionDate.isNotEmpty) {
//               if (DateFormat('dd-MM-yy').parse(actionDate).isBefore(DateTime.now())) {
//                 String owner = node['I__Owner'] ?? 'Unknown';
//                 tempMap.putIfAbsent(owner, () => []).add({
//                   "A__ID": node['A__ID'],
//                   "V__Action_Date": actionDate,
//                 });
//               }
//             }
//           }
//         }
//
//         setState(() {
//           groupedExpiredNodes = tempMap;
//         });
//       }
//     } catch (e) {
//       print("Error fetching data: $e");
//     }
//   }
//
//   void sendEmail(String owner, List<Map<String, dynamic>> nodes) {
//     String emailBody = "Expired Nodes for Owner: $owner\n\n";
//     for (var node in nodes) {
//       emailBody += "ID: ${node['A__ID']}, Expired On: ${node['V__Action_Date']}\n";
//     }
//
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => EmailSender(email: owner, body: emailBody),
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Expired Nodes"),
//       ),
//       body: groupedExpiredNodes.isEmpty
//           ? Center(child: Text("No expired nodes found."))
//           : ListView(
//         children: groupedExpiredNodes.entries.map((entry) {
//           return ListTile(
//             title: Text("Owner: ${entry.key}"),
//             subtitle: Text("${entry.value.length} expired nodes"),
//             trailing: ElevatedButton(
//               onPressed: () => sendEmail(entry.key, entry.value),
//               child: Text("Send"),
//             ),
//           );
//         }).toList(),
//       ),
//     );
//   }
// }
