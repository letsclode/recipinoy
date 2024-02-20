import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

import '../color.dart';
import '../controllers/user_controller.dart';
import '../drawer/drawer_index_provider.dart';
import '../extensions/utils.dart';
import '../models/report/report_model.dart';
import '../user/user_model.dart';
import 'report_filter_type_provider.dart';

part 'report_provider.g.dart';

@riverpod
class ReportProvider extends _$ReportProvider {
  Future<List<ReportModel>> _fetchReports() async {
    final filter = ref.watch(filterReportTypeProvider);
    final json = await FirebaseFirestore.instance
        .collection('reports')
        .orderBy('updatedAt', descending: true)
        .get();

    List<ReportModel> reports =
        json.docs.map((e) => ReportModel.fromJson(e.data())).toList();

    print('reports: $reports');

    switch (filter) {
      case ReportFilterType.verified:
        return reports.where((element) => element.isVerified).toList();
      case ReportFilterType.unverified:
        return reports
            .where((element) =>
                !element.isVerified && element.status != 'rejected')
            .toList();
      case ReportFilterType.complete:
        return reports
            .where((element) =>
                element.status == 'completed' && element.isVerified)
            .toList();
      case ReportFilterType.ongoing:
        return reports
            .where(
                (element) => element.status == 'ongoing' && element.isVerified)
            .toList();
      case ReportFilterType.all:
        return reports;

      case ReportFilterType.rejected:
        return reports
            .where((element) =>
                element.status == 'rejected' && !element.isVerified)
            .toList();
    }
  }

  @override
  FutureOr<List<ReportModel>> build() async {
    // Load initial todo list from the remote repository
    return _fetchReports();
  }

  Future<List<ReportModel>> getVisibleReports() async {
    return _fetchReports();
  }

  Future pinnedLocation() async {
    List<Map<String, dynamic>> pinnedLocations = [];
    try {
      final data = await getVisibleReports();

      pinnedLocations.clear();
      for (ReportModel report in data) {
        if (report.status == 'ongoing') {
          pinnedLocations.add(
            {
              'latitude': report.position['geopoint'].latitude,
              'longitude': report.position['geopoint'].longitude,
              'address': report.address
            },
          );
        }
      }

      debugPrint('pineed: $pinnedLocations');

      return pinnedLocations;
    } catch (e) {
      print(e);
    }
  }

  Future<void> updateStatus(
      {required String reportId, required String value}) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await FirebaseFirestore.instance
          .collection('reports')
          .doc(reportId)
          .update(
              {'status': value, 'completedDate': DateTime.now().toString()});
      return _fetchReports();
    });
  }

  Future<void> verifyReport(String uid) async {
    Map<Object, Object?> newData = {
      'isVerified': true,
      'status': 'ongoing',
      'verifiedDate': DateTime.now().toString()
    };
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      FirebaseFirestore.instance.collection('reports').doc(uid).update(newData);
      return _fetchReports();
    });
  }

  Future<void> rejectReport(String uid, String? reason) async {
    Map<Object, Object?> newData = {
      'status': 'rejected',
      'reason': reason ?? '',
      'rejectedDate': DateTime.now().toString()
    };
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      FirebaseFirestore.instance.collection('reports').doc(uid).update(newData);
      return _fetchReports();
    });
  }

  Future<int> monthlyReport() async {
    try {
      // Get the current date
      DateTime now = DateTime.now();

      // Calculate the first day of the current month
      DateTime firstDayOfMonth = DateTime(now.year, now.month, 1);

      // Calculate the last day of the current month
      DateTime lastDayOfMonth = DateTime(now.year, now.month + 1, 0);

      // Query the Firestore collection with a range filter on the timestamp
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('reports')
          .where('createdAt', isGreaterThanOrEqualTo: firstDayOfMonth)
          .where('createdAt', isLessThanOrEqualTo: lastDayOfMonth)
          .get();

      // Calculate the total report value
      int totalReport = 0;
      for (QueryDocumentSnapshot doc in querySnapshot.docs) {
        // Assuming each document has a field 'value' that represents the report value
        totalReport++;
      }

      return totalReport;
    } catch (e) {
      debugPrint(e.toString());
    }
    return 0;
  }

  Future<int> reportCounter(
      {required String reportType, required int month}) async {
    DateTime now = DateTime.now();
    // Build the timestamp range based on arguments
    DateTime firstDayOfMonth = DateTime(now.year, month, 1);

    // Calculate the last day of the current month
    DateTime lastDayOfMonth = DateTime(now.year, month + 1, 0);

    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('reports')
          .where('status', isEqualTo: reportType)
          .get();

      // Calculate the total report value
      int totalReport = 0;
      for (QueryDocumentSnapshot doc in querySnapshot.docs) {
        var creatdAt = (doc.data() as Map<String, Object?>)['createdAt'];
        if (DateTime.parse(creatdAt.toString()).isAfter(firstDayOfMonth) &&
            DateTime.parse(creatdAt.toString()).isBefore(lastDayOfMonth)) {
          totalReport++;
        }
      }

      return totalReport;
    } catch (e) {
      debugPrint(e.toString());
    }

    return 0;
  }

  Future<void> rateReport(double rates, String uid) async {
    Map<Object, Object?> newData = {'ratings': rates};
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      FirebaseFirestore.instance.collection('reports').doc(uid).update(newData);
      return _fetchReports();
    });
  }

  Future<void> deleteReport(String uid) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await FirebaseFirestore.instance.collection('reports').doc(uid).delete();
      return _fetchReports();
    });
  }

  Future addReport(ReportModel report) async {
    state = const AsyncValue.loading();
    var uuid = const Uuid();
    final generatedId = uuid.v1();
    //TODO: make it reportmodel
    await FirebaseFirestore.instance
        .collection('reports')
        .doc(generatedId)
        .set(report.copyWith(id: generatedId).toJson());
  }

  Future updateReport(ReportModel updateReport) async {
    await FirebaseFirestore.instance
        .collection('reports')
        .doc(updateReport.id)
        .update(updateReport.toJson());
  }

  Future addUpdate(
      {String? title,
      required String reportId,
      required String imageurl,
      required String description}) async {
    //TODO: addd update in firestore
    state = const AsyncValue.loading();

    state = await AsyncValue.guard(() async {
      FirebaseFirestore.instance.collection('reports').doc(reportId).update({
        'updatedAt': DateTime.now().toString(),
        'updates': FieldValue.arrayUnion([
          {
            'image': imageurl,
            'description': description,
            title: 'title',
            'createdAt': DateTime.now().toString()
          }
        ])
      });
      return _fetchReports();
    });
  }

  void showReportDetails(
      {required BuildContext context, required ReportModel row}) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Center(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Report Details"),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.close),
                    ),
                  ],
                )
              ],
            )),
            content: SizedBox(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Column(
                    children: [
                      Container(
                        height: 200,
                        width: 500,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: Image.network(
                                  row.imageUrl ?? 'assets/images/map.png',
                                ).image,
                                fit: BoxFit.cover),
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      Container(
                        height: row.updates.isEmpty && !row.isVerified
                            ? 200
                            : row.updates.isNotEmpty
                                ? 500
                                : 250,
                        width: 500,
                        padding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Consumer(builder: (_, ref, child) {
                              final user = ref
                                  .watch(userControllerProvider.notifier)
                                  .getUserById(id: row.userId);
                              return FutureBuilder<UserModel>(
                                  future: user,
                                  builder: (_, snap) {
                                    if (snap.hasData) {
                                      return RichText(
                                        text: TextSpan(
                                          style: const TextStyle(
                                              color: Colors.black),
                                          children: <TextSpan>[
                                            const TextSpan(
                                                text: 'Posted by : ',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            TextSpan(
                                              text: snap.data!.email,
                                            ),
                                          ],
                                        ),
                                      );
                                    }
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  });
                            }),
                            RichText(
                              text: TextSpan(
                                style: const TextStyle(color: Colors.black),
                                children: <TextSpan>[
                                  const TextSpan(
                                      text: 'Title: ',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold)),
                                  TextSpan(
                                    text: row.title,
                                  ),
                                ],
                              ),
                            ),
                            RichText(
                              text: TextSpan(
                                style: const TextStyle(color: Colors.black),
                                children: <TextSpan>[
                                  const TextSpan(
                                      text: 'Type: ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  TextSpan(text: row.type),
                                ],
                              ),
                            ),
                            RichText(
                              text: TextSpan(
                                style: const TextStyle(color: Colors.black),
                                children: <TextSpan>[
                                  const TextSpan(
                                      text: 'Address: ',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold)),
                                  TextSpan(
                                    text: row.address,
                                  ),
                                ],
                              ),
                            ),
                            RichText(
                              text: TextSpan(
                                style: const TextStyle(color: Colors.black),
                                children: <TextSpan>[
                                  const TextSpan(
                                      text: 'Landmark: ',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold)),
                                  TextSpan(
                                    text: row.landmark,
                                  ),
                                ],
                              ),
                            ),
                            RichText(
                              text: TextSpan(
                                style: const TextStyle(color: Colors.black),
                                children: <TextSpan>[
                                  const TextSpan(
                                      text: 'Description: ',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold)),
                                  TextSpan(
                                    text: row.description,
                                  ),
                                ],
                              ),
                            ),
                            RichText(
                              text: TextSpan(
                                style: const TextStyle(color: Colors.black),
                                children: <TextSpan>[
                                  const TextSpan(
                                      text: 'Date Reported: ',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold)),
                                  TextSpan(
                                    text: formatDate(row.createdAt),
                                  ),
                                ],
                              ),
                            ),
                            if (row.verifiedDate != null)
                              RichText(
                                text: TextSpan(
                                  style: const TextStyle(color: Colors.black),
                                  children: <TextSpan>[
                                    const TextSpan(
                                        text: 'Date Verified: ',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold)),
                                    TextSpan(
                                      text: formatDate(row.verifiedDate!),
                                    ),
                                  ],
                                ),
                              ),
                            if (row.completedDate != null)
                              RichText(
                                text: TextSpan(
                                  style: const TextStyle(color: Colors.black),
                                  children: <TextSpan>[
                                    const TextSpan(
                                        text: 'Date Completed: ',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold)),
                                    TextSpan(
                                      text: formatDate(row.completedDate!),
                                    ),
                                  ],
                                ),
                              ),
                            if (row.rejectedDate != null)
                              RichText(
                                text: TextSpan(
                                  style: const TextStyle(color: Colors.black),
                                  children: <TextSpan>[
                                    const TextSpan(
                                        text: 'Date Rejected: ',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold)),
                                    TextSpan(
                                      text: formatDate(row.rejectedDate!),
                                    ),
                                  ],
                                ),
                              ),
                            row.status != 'ongoing'
                                ? row.updates.isNotEmpty
                                    ? const Padding(
                                        padding: EdgeInsets.only(
                                            top: 20, bottom: 10),
                                        child: Text(
                                          'Updates :',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      )
                                    : const SizedBox()
                                : Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            if (row.updates.isNotEmpty)
                                              const Text(
                                                'Ongoing Updates',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.orange),
                                              ),
                                            Consumer(
                                                builder: (context, ref, child) {
                                              final reportProvider = ref.read(
                                                  reportProviderProvider
                                                      .notifier);
                                              final currentIndex = ref
                                                  .watch(drawerIndexProvider);
                                              return MaterialButton(
                                                color: primaryColor,
                                                onPressed: () {
                                                  //TODO: verify
                                                  Navigator.pop(context);
                                                  if (currentIndex == 1) {
                                                    reportProvider
                                                        .verifyReport(row.id);
                                                  } else {}
                                                },
                                                child: const Row(
                                                  children: [
                                                    Icon(
                                                      Icons.add,
                                                      color: Colors.white,
                                                    ),
                                                    Text(
                                                      'Update',
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            })
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Consumer(builder: (context, ref, child) {
                                    final reportProvider = ref
                                        .read(reportProviderProvider.notifier);
                                    final currentIndex =
                                        ref.watch(drawerIndexProvider);

                                    return Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        row.status == 'completed'
                                            ? const SizedBox()
                                            : Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  if (currentIndex == 1)
                                                    MaterialButton(
                                                      color: Colors.red,
                                                      onPressed: () {
                                                        Navigator.pop(context);

                                                        TextEditingController
                                                            reasonController =
                                                            TextEditingController();
                                                        showDialog(
                                                            context: context,
                                                            builder: (context) {
                                                              return AlertDialog(
                                                                title: const Text(
                                                                    "Rejecting report"),
                                                                content:
                                                                    SizedBox(
                                                                  height: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .height /
                                                                      6,
                                                                  child: Column(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    children: [
                                                                      const Text(
                                                                          'Are you sure you want to reject this report?'),
                                                                      TextField(
                                                                        controller:
                                                                            reasonController,
                                                                        decoration:
                                                                            const InputDecoration(hintText: 'Reasons of rejection'),
                                                                      ),
                                                                      Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.end,
                                                                        children: [
                                                                          OutlinedButton(
                                                                              onPressed: () {
                                                                                Navigator.pop(context);
                                                                              },
                                                                              child: const Text("Cancel")),
                                                                          const SizedBox(
                                                                            width:
                                                                                20,
                                                                          ),
                                                                          Consumer(
                                                                            builder: (context,
                                                                                ref,
                                                                                child) {
                                                                              return MaterialButton(
                                                                                color: secondaryColor,
                                                                                onPressed: () async {
                                                                                  reportProvider.rejectReport(row.id, reasonController.text);
                                                                                },
                                                                                child: const Text(
                                                                                  "Reject",
                                                                                  style: TextStyle(color: Colors.white),
                                                                                ),
                                                                              );
                                                                            },
                                                                          )
                                                                        ],
                                                                      )
                                                                    ],
                                                                  ),
                                                                ),
                                                              );
                                                            });
                                                      },
                                                      child: const Text(
                                                        'Reject',
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  if (currentIndex != 4)
                                                    MaterialButton(
                                                      color: Colors.green,
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                        if (currentIndex == 1) {
                                                          reportProvider
                                                              .verifyReport(
                                                                  row.id);
                                                        } else {
                                                          reportProvider
                                                              .updateStatus(
                                                                  reportId:
                                                                      row.id,
                                                                  value:
                                                                      'completed');
                                                        }
                                                      },
                                                      child: Text(
                                                        currentIndex == 1
                                                            ? 'Verify'
                                                            : 'Complete Report',
                                                        style: const TextStyle(
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ),
                                                ],
                                              )
                                      ],
                                    );
                                  }),
                                ],
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }
}