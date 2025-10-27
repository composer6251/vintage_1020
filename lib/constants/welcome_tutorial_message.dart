import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

Center quickAddIcon () => Center(
  child: IconButton.filled(
    style: ButtonStyle(
      backgroundColor: WidgetStatePropertyAll<Color>(Colors.blue),),
      color: Colors.white, 
      isSelected: false, 
      onPressed: (){}, 
      icon: FaIcon(FontAwesomeIcons.camera)
      ));

const String welcomeTutorialMessage = 'Welcome! \nYou do not have any inventory items yet. You can quick add one with just taking a photo by pressing the "+ Quick" button';
const String welcomeTutorialMessageTwo = ' or you can select the add item tile to add item details and create a booth and add the item to that booth';


class WelcomeTutorialMessage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              style: GoogleFonts.lato(
                textStyle: Theme.of(context).textTheme.displayLarge,
                fontSize: 24,
                fontWeight: FontWeight.w700,
                fontStyle: FontStyle.italic,
              ),
              welcomeTutorialMessage,
            ),
          ],
        ),
        Text(
          style: GoogleFonts.lato(
            textStyle: Theme.of(context).textTheme.displayLarge,
            fontSize: 24,
            fontWeight: FontWeight.w700,
            fontStyle: FontStyle.italic,
          ),
          welcomeTutorialMessageTwo,
        ),
      ],
    );
  }
}
