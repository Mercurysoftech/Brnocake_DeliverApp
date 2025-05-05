import 'dart:io';
import 'package:dio/dio.dart';

class UserFormData {
  static final UserFormData _instance = UserFormData._internal();
  String? name;
  String? middlename;
  String? lastname;
  String? gender;
  String? phone;
  String? houuseNo;
  String? buildingNo;
  String? landmark;
  String? city;
  String? state;
  String? location;

  File? aadhaarFront;
  File? aadhaarBack;

  File? dervingFront;
  File? dervingBack;

  File? profile;

  factory UserFormData() {
    return _instance;
  }

  UserFormData._internal();

  Map<String, dynamic> data() {
    Map<String, dynamic> dataMap = {
      "first_name": name.toString(),
      "middle_name": middlename.toString(),
      "last_name": lastname.toString(),
      "gender": gender.toString(),
      "mobile": phone.toString(),
      "house_number": houuseNo.toString(),
      "building_name": buildingNo.toString(),
      "landmark": landmark.toString(),
      "city": city.toString(),
      "state": state.toString(),
      "location": location.toString(),
    };

    // Check if aadhaarFront is not null and add to map
    if (aadhaarFront != null) {
      dataMap["aadhar_front"] = MultipartFile.fromFileSync(
        aadhaarFront!.path,
        filename: "front.jpg",
      );
    }

    // Check if aadhaarBack is not null and add to map
    if (aadhaarBack != null) {
      dataMap["aadhar_back"] = MultipartFile.fromFileSync(
        aadhaarBack!.path,
        filename: "back.jpg",
      );
    }

    if (dervingFront != null) {
      dataMap["dl_front"] = MultipartFile.fromFileSync(
        dervingFront!.path,
        filename: "front.jpg",
      );
    }

    if (dervingBack != null) {
      dataMap["dl_back"] = MultipartFile.fromFileSync(
        dervingBack!.path,
        filename: "back.jpg",
      );
    }

    if (profile != null) {
      dataMap["profile_photo"] = MultipartFile.fromFileSync(
        profile!.path,
        filename: "profile.jpg",
      );
    }

    return dataMap;
  }

  getdata() {
    print('Phone number: $phone');
  }
}
