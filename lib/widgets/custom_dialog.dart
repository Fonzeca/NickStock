import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stock_app/home/home.dart';

class CustomDialog extends StatelessWidget {
  const CustomDialog(
      {Key? key,
      required this.firstTabText,
      required this.secondTabText,
      required this.tabTitle,
      required this.bodyInputs,
      required this.onAcceptPressed,
      required this.isFirstTabSelected})
      : super(key: key);

  final bool isFirstTabSelected;
  final String firstTabText;
  final String secondTabText;
  final String tabTitle;
  final List<Widget> bodyInputs;
  final void Function() onAcceptPressed;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: SizedBox(
        height: 380,
        width: 400,
        child: Column(
          children: [
            _HeaderDialog(firstTabText: firstTabText, secondTabText: secondTabText, isFirstTabSelected: isFirstTabSelected),
            _BodyDialog(
              tabTitle: tabTitle,
              bodyInputs: bodyInputs,
              onAcceptPressed: onAcceptPressed,
            )
          ],
        ),
      ),
    );
  }
}

class _HeaderDialog extends StatelessWidget {
  final bool isFirstTabSelected;
  final String firstTabText;
  final String secondTabText;

  const _HeaderDialog({
    Key? key,
    required this.isFirstTabSelected,
    required this.firstTabText,
    required this.secondTabText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.zero,
      padding: EdgeInsets.zero,
      height: 40,
      color: Colors.transparent,
      child: Row(children: [
        _ConfirmCreationButton(tabText: firstTabText, isFirstTabSelected: isFirstTabSelected, isFirstTab: true),
        _ConfirmCreationButton(tabText: secondTabText, isFirstTabSelected: !isFirstTabSelected, isFirstTab: false),
      ]),
    );
  }
}

class _ConfirmCreationButton extends StatelessWidget {
  final bool isFirstTabSelected;
  final String tabText;
  final bool isFirstTab;

  const _ConfirmCreationButton({
    Key? key,
    required this.isFirstTabSelected,
    required this.tabText,
    required this.isFirstTab,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () {
          (isFirstTabSelected && isFirstTab) || (!isFirstTabSelected && isFirstTab)
              ? BlocProvider.of<CreateDialogBloc>(context).add(ChangeDialogTabEvent(isFirstTabSelected: true))
              : BlocProvider.of<CreateDialogBloc>(context).add(ChangeDialogTabEvent(isFirstTabSelected: false));
        },
        style: ButtonStyle(
            minimumSize: MaterialStateProperty.all(const Size(100, 40)),
            padding: MaterialStateProperty.all(EdgeInsets.zero),
            overlayColor: MaterialStateProperty.all(Colors.white),
            shape: MaterialStateProperty.all(const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
            )),
            foregroundColor: MaterialStateProperty.all(Colors.black54),
            backgroundColor: MaterialStateProperty.all(isFirstTab
                ? (isFirstTabSelected ? Colors.white : const Color.fromARGB(255, 235, 235, 235))
                : (!isFirstTabSelected ? const Color.fromARGB(255, 235, 235, 235) : Colors.white))),
        child: Text(tabText));
  }
}

class _BodyDialog extends StatelessWidget {
  _BodyDialog({
    Key? key,
    required this.tabTitle,
    required this.bodyInputs,
    required this.onAcceptPressed,
  }) : super(key: key);

  final String tabTitle;
  final List<Widget> bodyInputs;
  final void Function() onAcceptPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(topRight: Radius.circular(10), bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10))),
      margin: EdgeInsets.zero,
      padding: const EdgeInsets.only(top: 20, left: 20, bottom: 5, right: 20),
      height: 320,
      child: Form(
        child: Column(
          children: [
            Text(
              tabTitle,
              textAlign: TextAlign.center,
              style: GoogleFonts.roboto(fontSize: 20, color: Colors.indigo, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 20),
            ...bodyInputs,
            Align(
              alignment: Alignment.bottomRight,
              child: TextButton(
                  style: ButtonStyle(overlayColor: MaterialStateProperty.all(Colors.indigo[50])),
                  onPressed: onAcceptPressed,
                  child: Text(
                    "Aceptar",
                    textAlign: TextAlign.end,
                    style: GoogleFonts.roboto(color: Colors.indigo, fontWeight: FontWeight.w500),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
