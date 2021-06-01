import 'package:cowin/cowinServices.dart';
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
          backgroundColor: Colors.white,
          leading: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
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
                      if (centreList[index].feeType == 'Free')
                        return true;
                      else
                        return false;
                    }

                    return Card(
                      margin: EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              centreList[index].name,
                              style: GoogleFonts.notoSans(
                                  color: Colors.blue[900],
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600),
                            ),
                            Text(
                              centreList[index].blockName,
                              style: GoogleFonts.notoSans(
                                  color: Colors.grey[700], fontSize: 14),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  centreList[index].feeType,
                                  style: GoogleFonts.notoSans(
                                      color:
                                          fees() ? Colors.green : Colors.orange,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                                Text("")
                              ],
                            )
                          ],
                        ),
                      ),
                    );
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
}
