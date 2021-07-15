import 'package:cowin/models/centres.dart';
import 'package:flutter/material.dart';
import 'package:cowin/CentreList.dart';
import 'package:google_fonts/google_fonts.dart';

class CentreDetails extends StatefulWidget {
  final Session currentCentreDetails;

  CentreDetails({@required this.currentCentreDetails});

  @override
  _CentreDetailsState createState() => _CentreDetailsState();
}

class _CentreDetailsState extends State<CentreDetails> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    Session details = widget.currentCentreDetails;
    return SafeArea(
      child: Scaffold(
        body: SizedBox.expand(
          child: Padding(
            padding: EdgeInsets.only(top: height * 0.06),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.blue[900].withOpacity(0.1),
                  radius: 40,
                  child: Icon(
                    Icons.domain,
                    color: Colors.blue[700],
                    size: 40,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  details.name,
                  style: GoogleFonts.notoSans(
                      color: Colors.blue[900],
                      fontSize: 20,
                      fontWeight: FontWeight.w600),
                ),
                // SizedBox(
                //   height: 10,
                // ),
                // Text(
                //   widget.currentCentreDetails.blockName,
                //   textAlign: TextAlign.center,
                //   style: GoogleFonts.notoSans(
                //     color: Colors.grey,
                //     fontSize: 16,
                //     fontWeight: FontWeight.w600,
                //   ),
                // ),
                SizedBox(
                  height: 6,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    details.address,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.notoSans(
                      color: Colors.grey[900],
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(
                        top: height * 0.04, left: 15, right: 10),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(25),
                          topRight: Radius.circular(25),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.blueGrey[200],
                            offset: Offset(5, 0),
                            blurRadius: 8,
                            spreadRadius: 2,
                          )
                        ]),
                    child: Column(
                      children: [
                        DetailsRow(attribute: "Date", value: details.date),
                        DetailsRow(
                            attribute: "Fees",
                            value: details.feeType == "Free"
                                ? "N/A"
                                : details.fee),
                        DetailsRow(
                            attribute: "Age Limit",
                            value: details.minAgeLimit.toString()),
                        DetailsRow(
                            attribute: "Vaccine", value: details.vaccine),
                        DetailsRow(
                            attribute: "Available Capacity",
                            value: details.availableCapacity.toString()),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Slots",
                              style: GoogleFonts.notoSans(
                                  color: Colors.blue,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600),
                            ),
                            
                          ],
                          ListView.builder(
                              itemCount: details.slots.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Text(details.slots[index].toString());
                              },
                            )
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DetailsRow extends StatelessWidget {
  const DetailsRow(
      {Key key,
      //@required this.details,
      @required this.attribute,
      @required this.value})
      : super(key: key);

  //final Session details;
  final String attribute;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            attribute,
            style: GoogleFonts.notoSans(
                color: Colors.blue, fontSize: 16, fontWeight: FontWeight.w600),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              value,
              style: GoogleFonts.notoSans(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          )
          // Text(
          //   "Address",
          //   style: GoogleFonts.notoSans(
          //       color: Colors.blue,
          //       fontSize: 16,
          //       fontWeight: FontWeight.w600),
          // ),
          // Flexible(
          //   child: Padding(
          //     padding:
          //         const EdgeInsets.symmetric(horizontal: 8.0),
          //     child: Text(
          //       widget.currentCentreDetails.address,
          //       textAlign: TextAlign.left,
          //       style: GoogleFonts.notoSans(
          //         color: Colors.black,
          //         fontSize: 14,
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
