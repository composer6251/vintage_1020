import 'package:vintage_1020/domain/my_booth/my_booth.dart';

String? validateNewBoothName(String? boothName, List<MyBooth> userBooths) {
        // Check if created booth already exists
       return userBooths.any((booth) => booth.boothName == boothName) ? 'Booth already exists' : null;
    }