class PictureNames {

  static Map<num, String> picsFurniture = <num, String>{
    // 0: one,
    1: two,
    // 2: three,
    3: four,
    4: five,
    5: six,
    6: seven,
    // 8: nine,
    // 9: ten,
    10: eleven,
    11: twelve,
    // 12: thirteen,
    13: lampOne,
    14: fifteen,
    // 15: sixteen,
    // 16: seventeen,
    // 18: nineteen,
    19: twenty,
    // 20: lampTwo,
  };

  static String wateree = 'resources/branding/wateree.jpeg';

  static String two = 'resources/images-furniture/two.jpeg';
  static String four = 'resources/images-furniture/four.jpeg';
  static String five = 'resources/images-furniture/five.jpeg';
  static String six = 'resources/images-furniture/six.jpeg';
  static String seven = 'resources/images-furniture/seven.jpeg';
  static String nine = 'resources/images-furniture/9.jpeg';
  static String ten = 'resources/images-furniture/10.jpeg';
  static String eleven = 'resources/images-furniture/11.jpeg';
  static String twelve = 'resources/images-furniture/12.jpeg';
  static String thirteen = 'resources/images-furniture/13.jpeg';
  static String fifteen = 'resources/images-furniture/15.jpeg';
  static String sixteen = 'resources/images-furniture/16.jpeg';
  static String seventeen = 'resources/images-furniture/17.jpeg';
  static String nineteen = 'resources/images-furniture/19.jpeg';
  static String twenty = 'resources/images-furniture/20.jpeg';

  static String lampTwo = 'resources/images-lamps/21.jpeg';
  static String lampOne = 'resources/images-lamps/14.jpeg';

  static String lunaFurnitureOne = 'resources/images-furniture/lunaFurnitureOne.jpeg';
  static String lunaFurnitureTwo = 'resources/images-furniture/lunaFurnitureTwo.jpeg';
  static String lunaFurnitureThree = 'resources/images-furniture/lunaFurnitureThree.jpeg';


  static Map<num, String> picsLunaFurniture = <num, String>{
    0: lunaFurnitureOne,
    1: lunaFurnitureTwo,
    2: lunaFurnitureThree,
  };

  static List<String> picListFurniture = picsFurniture.entries.map((e) {
    return e.value;
  }).toList();

}
