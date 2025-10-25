import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

IconButton quickAddIcon () => IconButton.outlined(isSelected: false, onPressed: (){}, icon: Icon(Icons.add));

const String welcomeTutorialMessage = 'Welcome! \nYou do not have any inventory items yet. You can quick add one with just taking a photo by pressing the ';
const String welcomeTutorialMessageTwo = ' or you can select the add item tile to add item details and create a booth and add the item to that booth';


class WelcomeTutorialMessage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          style: GoogleFonts.lato(
            textStyle: Theme.of(context).textTheme.displayLarge,
            fontSize: 48,
            fontWeight: FontWeight.w700,
            fontStyle: FontStyle.italic,
          ),
          welcomeTutorialMessage,
        ),
        quickAddIcon(),
        Text(
          style: GoogleFonts.lato(
            textStyle: Theme.of(context).textTheme.displayLarge,
            fontSize: 48,
            fontWeight: FontWeight.w700,
            fontStyle: FontStyle.italic,
          ),
          welcomeTutorialMessageTwo,
        ),
      ],
    );
  }
}
