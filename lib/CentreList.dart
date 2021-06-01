import 'dart:math';

import 'package:cowin/cowinServices.dart';
import 'package:cowin/homepage.dart';
import 'package:flutter/material.dart';
import 'package:date_format/date_format.dart';
import 'package:google_fonts/google_fonts.dart';

import 'models/centres.dart';

class CentreList extends StatefulWidget {
  final int districtId;
  CentreList({this.districtId});

  @override
  _CentreListState createState() => _CentreListState();
}

class _CentreListState extends State<CentreList> {
  currentDate() {
    return formatDate(DateTime.now(), ['dd', '-', 'mm', '-', 'yyyy']);
  }

  Future<List<Centre>> centres;
  fetchCentre(int id, String date) {
    centres = CowinService.getAllCentresFromDistrict(id, date);
  }

  @override
  void initState() {
    super.initState();
    fetchCentre(widget.districtId, currentDate());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: borderColor,
        ),
        backgroundColor: Color(0xfff0f0f0),
        body: FutureBuilder<List<Centre>>(
          future: centres,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data != null) {
                List<Centre> centreList = snapshot.data;
                return ListView.builder(
                  itemCount: centreList.length,
                  itemBuilder: (BuildContext context, int index) {
                    bool fees() {
                      return centreList[index].feeType == 'Free';
                    }

                    var todaySession = centreList[index]
                        .sessions
                        .takeWhile((value) => value.date == currentDate())
                        .toList();
                    return Card(
                      semanticContainer: false,
                      borderOnForeground: false,
                      elevation: 0,
                      shadowColor: Colors.red,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      margin: EdgeInsets.symmetric(vertical: 2, horizontal: 4),
                      child: ListTile(
                        onTap: () {},
                        trailing: Icon(Icons.chevron_right),
                        leading: CircleAvatar(
                          backgroundColor: Colors.blue[900].withOpacity(0.1),
                          radius: 22,
                          child: Icon(
                            Icons.domain,
                            color: Colors.blue[700],
                          ),
                        ),
                        title: Text(
                          centreList[index].name,
                          style: GoogleFonts.notoSans(
                              color: Colors.blue[900],
                              fontSize: 16,
                              fontWeight: FontWeight.w600),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              centreList[index].blockName,
                              style: GoogleFonts.notoSans(
                                  color: Colors.grey[700], fontSize: 14),
                            ),
                            Row(
                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                buildChip(fees() ? Colors.green : Colors.orange,
                                    centreList[index].feeType),
                                todaySession
                                            .reduce((e1, e2) => Session(
                                                availableCapacity:
                                                    e1.minAgeLimit +
                                                        e2.minAgeLimit))
                                            .availableCapacity >
                                        0
                                    ? buildChip(Colors.lightGreen, "Available")
                                    : buildChip(Colors.redAccent, "Booked"),
                                buildChip(
                                    Colors.lightBlue,
                                    todaySession
                                            .reduce((e1, e2) => Session(
                                                minAgeLimit: min(e1.minAgeLimit,
                                                    e2.minAgeLimit)))
                                            .minAgeLimit
                                            .toString() +
                                        '+'),
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                    // Card(
                    //   margin: EdgeInsets.symmetric(
                    //     horizontal: 8,
                    //     vertical: 4,
                    //   ),
                    //   child: Padding(
                    //     padding: const EdgeInsets.all(8.0),
                    //     child: Column(
                    //       crossAxisAlignment: CrossAxisAlignment.start,
                    //       children: [
                    //         Text(
                    //           centreList[index].name,
                    //           style: GoogleFonts.notoSans(
                    //               color: Colors.blue[900],
                    //               fontSize: 18,
                    //               fontWeight: FontWeight.w600),
                    //         ),
                    //         Text(
                    //           centreList[index].blockName,
                    //           style: GoogleFonts.notoSans(
                    //               color: Colors.grey[700], fontSize: 14),
                    //         ),
                    //         SizedBox(
                    //           height: 10,
                    //         ),
                    //         Row(
                    //           // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //           children: [
                    //             buildChip(fees() ? Colors.green : Colors.orange,
                    //                 centreList[index].feeType),
                    //             todaySession
                    //                         .reduce((e1, e2) => Session(
                    //                             availableCapacity:
                    //                                 e1.minAgeLimit +
                    //                                     e2.minAgeLimit))
                    //                         .availableCapacity >
                    //                     0
                    //                 ? buildChip(Colors.lightGreen, "Available")
                    //                 : buildChip(Colors.redAccent, "Booked"),
                    //             buildChip(
                    //                 Colors.lightBlue,
                    //                 todaySession
                    //                         .reduce((e1, e2) => Session(
                    //                             minAgeLimit: min(e1.minAgeLimit,
                    //                                 e2.minAgeLimit)))
                    //                         .minAgeLimit
                    //                         .toString() +
                    //                     '+'),
                    //           ],
                    //         )
                    //       ],
                    //     ),
                    //   ),
                    // );
                  },
                );
              }
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            return Center(
              child: Text(
                'No centers available',
                style:
                    GoogleFonts.notoSans(fontSize: 18, color: Colors.grey[800]),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget buildChip(Color color, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Chip(
          label: Text(text),
          backgroundColor: color.withOpacity(0.1),
          labelPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
          padding: EdgeInsets.zero,
          labelStyle: GoogleFonts.notoSans(
              color: color,
              fontSize: 14,
              fontWeight: FontWeight.w500,
              height: 1)),
    );
  }
}
