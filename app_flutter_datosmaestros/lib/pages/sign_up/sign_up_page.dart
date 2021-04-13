import 'package:app_flutter_datosmaestros/pages/sign_up/body.dart';
import 'package:flutter/material.dart';

import '../../color_style.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    bool _titleAvailable = _size.width >= 1200.0 ? false : true;
    double _widthValue = _size.width >= 1200.0 ? 0.35 : 0.1;
    double _sizeBetween = _size.width >= 1200.0 ? 50.0 : 20.0;
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            color: Colors.blueAccent,
          ),
          _titleAvailable
              ? SizedBox()
              : Positioned(
                  top: 30.0,
                  left: 30.0,
                  child: Text(
                    'Personas',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 48.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
          Container(
            margin: EdgeInsets.only(left: _size.width * _widthValue),
            decoration: BoxDecoration(
                color: BrandColors.colorBgSignIn,
                borderRadius:
                    BorderRadius.only(topLeft: Radius.circular(24.0))),
            child: SafeArea(
                child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(
                    height: _sizeBetween,
                  ),
                  _size.width >= 1200.0
                      ? Padding(
                          padding: const EdgeInsets.only(top: 80.0),
                          child: Container(
                            height: _size.height * 0.8,
                            child: Body(),
                          ),
                        )
                      : Body()
                ],
              ),
            )),
          )
        ],
      ),
    );
  }
}
