import 'package:app_flutter_datosmaestros/features/usuarios/domain/entities/usuario.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class DetallePage extends StatelessWidget {
  const DetallePage({
    Key key,
    this.usuario,
  }) : super(key: key);

  final Usuario usuario;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: SafeArea(
          child: Column(
            children: [
              //Header(),
              Divider(thickness: 1),
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(kDefaultPadding),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(width: kDefaultPadding),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text.rich(
                                        TextSpan(
                                          text: "prueba",
                                          style: Theme.of(context)
                                              .textTheme
                                              .button,
                                          children: [
                                            TextSpan(
                                                text:
                                                    "  <elvia.atkins@gmail.com> to Jerry Torp",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .caption),
                                          ],
                                        ),
                                      ),
                                      Text(
                                        "Inspiration for our new home",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline6,
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(width: kDefaultPadding / 2),
                                Text(
                                  "Today at 15:32",
                                  style: Theme.of(context).textTheme.caption,
                                ),
                              ],
                            ),
                            SizedBox(height: kDefaultPadding),
                            LayoutBuilder(
                              builder: (context, constraints) => SizedBox(
                                width: constraints.maxWidth > 850
                                    ? 800
                                    : constraints.maxWidth,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Hello my love, \n \nSunt architecto voluptatum esse tempora sint nihil minus incidunt nisi. Perspiciatis natus quo unde magnam numquam pariatur amet ut. Perspiciatis ab totam. Ut labore maxime provident. Voluptate ea omnis et ipsum asperiores laborum repellat explicabo fuga. Dolore voluptatem praesentium quis eos laborum dolores cupiditate nemo labore. \n \nLove you, \n\nElvia",
                                      style: TextStyle(
                                        height: 1.5,
                                        color: Color(0xFF4D5875),
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                    SizedBox(height: kDefaultPadding),
                                    Row(
                                      children: [
                                        Text(
                                          "6 attachments",
                                          style: TextStyle(fontSize: 12),
                                        ),
                                        Spacer(),
                                        Text(
                                          "Download All",
                                          style: Theme.of(context)
                                              .textTheme
                                              .caption,
                                        ),
                                        SizedBox(width: kDefaultPadding / 4),
                                        // WebsafeSvg.asset(
                                        //   "assets/Icons/Download.svg",
                                        //   height: 16,
                                        //   color: kGrayColor,
                                        // ),
                                      ],
                                    ),
                                    Divider(thickness: 1),
                                    SizedBox(height: kDefaultPadding / 2),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
