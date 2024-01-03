import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyInputfield extends StatelessWidget {
  final String title;
  final String hinttext;
  final TextEditingController? controller;
  final Widget? widget;

  const MyInputfield({
    super.key,
    required this.title,
    required,
    required this.hinttext,
    this.controller,
    this.widget,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(left: 16),
              child: Text(
                title,
                style: GoogleFonts.lato(
                    textStyle:
                        const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 8.0, left: 16, right: 16),
              height: 52,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 1.0),
                  borderRadius: BorderRadius.circular(12)),
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16),
                      child: TextFormField(
                        readOnly: widget == null ? false : true,
                        autofocus: false,
                        cursorColor: Colors.grey,
                        controller: controller,
                        style: GoogleFonts.lato(
                          textStyle: const TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        decoration: InputDecoration(
                            hintText: hinttext,
                            hintStyle: GoogleFonts.lato(
                              textStyle: TextStyle(
                                color: Colors.grey[500],
                                fontSize: 18,
                              ),
                            ),
                            focusedBorder: const UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.white, width: 0)),
                            enabledBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(
                              color: Colors.white,
                              width: 0,
                            ))),
                      ),
                    ),
                  ),
                  widget == null ? Container() : Container(child: widget),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
