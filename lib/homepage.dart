import 'package:cowin/CentreList.dart';
import 'package:cowin/cowinServices.dart';
import 'package:cowin/models/district.dart';
import 'package:cowin/models/states.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedState, selectedDistrict;

  Future<List<District>> districts;
  fetchDistricts(int id) {
    districts = CowinService.getAllDistricts(id);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              child: Image(
                image: AssetImage('assets/cowinLogo.png'),
                filterQuality: FilterQuality.high,
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 1),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                      color: borderColor, width: 2, style: BorderStyle.solid),
                ),
                child: DropdownButton<int>(
                  style:
                      GoogleFonts.openSans(fontSize: 16, color: Colors.black),
                  icon: Icon(
                    Icons.keyboard_arrow_down,
                    size: 30,
                  ),
                  underline: SizedBox(),
                  hint: Text(
                    'Select State',
                    style: GoogleFonts.openSans(fontSize: 16),
                  ),
                  isExpanded: true,
                  value: selectedState,
                  items: stateList
                      .map(
                        (state) => DropdownMenuItem<int>(
                          value: stateList.indexOf(state),
                          child: Text(state),
                        ),
                      )
                      .toList(),
                  onChanged: (int value) {
                    setState(() {
                      selectedState = value;
                      selectedDistrict = null;
                    });
                    fetchDistricts(value);
                    print(value);
                  },
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            FutureBuilder<List<District>>(
              future: districts,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var list = snapshot.data;
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 1),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                            color: borderColor,
                            width: 2,
                            style: BorderStyle.solid),
                      ),
                      child: DropdownButton<int>(
                        style: GoogleFonts.openSans(
                            fontSize: 16, color: Colors.black),
                        icon: Icon(
                          Icons.keyboard_arrow_down,
                          size: 30,
                        ),
                        underline: SizedBox(),
                        hint: Text(
                          'Select District',
                          style: GoogleFonts.openSans(fontSize: 16),
                        ),
                        value: selectedDistrict,
                        isExpanded: true,
                        items: list
                            .map(
                              (district) => DropdownMenuItem<int>(
                                value: district.districtId,
                                child: Text(district.districtName),
                              ),
                            )
                            .toList(),
                        onChanged: (int value) {
                          setState(() {
                            selectedDistrict = value;
                            print(selectedDistrict);
                          });
                        },
                      ),
                    ),
                  );
                }
                if (snapshot.connectionState == ConnectionState.waiting)
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 1),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                            color: borderColor,
                            width: 2,
                            style: BorderStyle.solid),
                      ),
                      child: DropdownButton(
                        icon: Icon(
                          Icons.keyboard_arrow_down,
                          size: 30,
                        ),
                        underline: SizedBox(),
                        isExpanded: true,
                        hint: Text(
                          'Select District',
                          style: GoogleFonts.openSans(fontSize: 16),
                        ),
                        items: [],
                      ),
                    ),
                  );
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 1),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                          color: borderColor,
                          width: 2,
                          style: BorderStyle.solid),
                    ),
                    child: DropdownButton(
                      icon: Icon(
                        Icons.keyboard_arrow_down,
                        size: 30,
                      ),
                      underline: SizedBox(),
                      isExpanded: true,
                      hint: Text(
                        'Select District',
                        style: GoogleFonts.openSans(fontSize: 16),
                      ),
                      items: [],
                    ),
                  ),
                );
              },
            ),
            SizedBox(
              height: 40,
            ),
            GestureDetector(
              child: FractionallySizedBox(
                widthFactor: 0.6,
                child: Container(
                  padding: EdgeInsets.all(12),
                  child: Center(
                    child: Text(
                      'Search Centre',
                      style: GoogleFonts.openSans(
                          color: Colors.white,
                          fontSize: 20,
                          letterSpacing: 1,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  decoration: BoxDecoration(
                      color: Color(0xff001B58),
                      borderRadius: BorderRadius.circular(30)),
                ),
              ),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => CentreList(
                      districtId: selectedDistrict,
                    ),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}

Color borderColor = Color(0xff001B58);
