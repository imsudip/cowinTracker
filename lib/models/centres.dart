// To parse this JSON data, do
//
//     final centresResponse = centresResponseFromJson(jsonString);

import 'dart:convert';

CentresResponse centresResponseFromJson(String str) =>
    CentresResponse.fromJson(json.decode(str));

String centresResponseToJson(CentresResponse data) =>
    json.encode(data.toJson());

class CentresResponse {
  CentresResponse({
    this.centers,
  });

  List<Centre> centers;

  factory CentresResponse.fromJson(Map<String, dynamic> json) =>
      CentresResponse(
        centers:
            List<Centre>.from(json["centers"].map((x) => Centre.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "centers": List<dynamic>.from(centers.map((x) => x.toJson())),
      };
}

class Centre {
  Centre({
    this.centerId,
    this.name,
    this.address,
    this.stateName,
    this.districtName,
    this.blockName,
    this.pincode,
    this.lat,
    this.long,
    this.from,
    this.to,
    this.feeType,
    this.sessions,
  });

  int centerId;
  String name;
  String address;
  String stateName;
  String districtName;
  String blockName;
  int pincode;
  int lat;
  int long;
  String from;
  String to;
  String feeType;
  List<Session> sessions;

  factory Centre.fromJson(Map<String, dynamic> json) => Centre(
        centerId: json["center_id"],
        name: json["name"],
        address: json["address"],
        stateName: json["state_name"],
        districtName: json["district_name"],
        blockName: json["block_name"],
        pincode: json["pincode"],
        lat: json["lat"],
        long: json["long"],
        from: json["from"],
        to: json["to"],
        feeType: json["fee_type"],
        sessions: List<Session>.from(
            json["sessions"].map((x) => Session.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "center_id": centerId,
        "name": name,
        "address": address,
        "state_name": stateName,
        "district_name": districtName,
        "block_name": blockName,
        "pincode": pincode,
        "lat": lat,
        "long": long,
        "from": from,
        "to": to,
        "fee_type": feeType,
        "sessions": List<dynamic>.from(sessions.map((x) => x.toJson())),
      };
}

class Session {
  Session({
    this.sessionId,
    this.date,
    this.availableCapacity,
    this.minAgeLimit,
    this.vaccine,
    this.slots,
    this.availableCapacityDose1,
    this.availableCapacityDose2,
  });

  String sessionId;
  String date;
  int availableCapacity;
  int minAgeLimit;
  String vaccine;
  List<String> slots;
  int availableCapacityDose1;
  int availableCapacityDose2;

  factory Session.fromJson(Map<String, dynamic> json) => Session(
        sessionId: json["session_id"],
        date: json["date"],
        availableCapacity: json["available_capacity"],
        minAgeLimit: json["min_age_limit"],
        vaccine: json["vaccine"],
        slots: List<String>.from(json["slots"].map((x) => x)),
        availableCapacityDose1: json["available_capacity_dose1"],
        availableCapacityDose2: json["available_capacity_dose2"],
      );

  Map<String, dynamic> toJson() => {
        "session_id": sessionId,
        "date": date,
        "available_capacity": availableCapacity,
        "min_age_limit": minAgeLimit,
        "vaccine": vaccine,
        "slots": List<dynamic>.from(slots.map((x) => x)),
        "available_capacity_dose1": availableCapacityDose1,
        "available_capacity_dose2": availableCapacityDose2,
      };
}
