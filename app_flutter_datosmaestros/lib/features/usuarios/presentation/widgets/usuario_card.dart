import 'package:app_flutter_datosmaestros/features/usuarios/domain/entities/usuario.dart';
import 'package:flutter/material.dart';

import '../../../../constants.dart';

class UsuarioCard extends StatelessWidget {
  const UsuarioCard({Key key, this.isActive, this.usuario, this.press})
      : super(key: key);
  final bool isActive;
  final Usuario usuario;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(
            horizontal: kDefaultPadding, vertical: kDefaultPadding / 2),
        child: InkWell(
          onTap: press,
          child: Stack(
            children: [
              Container(
                padding: EdgeInsets.all(kDefaultPadding),
                decoration: BoxDecoration(
                  color: isActive ? kPrimaryColor : kBgDarkColor,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: 32,
                        ),
                        SizedBox(width: kDefaultPadding / 2),
                        Expanded(
                          child: Text.rich(
                            TextSpan(
                              text: "${usuario.id} - ${usuario.user} \n",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: isActive ? Colors.white : kTextColor,
                              ),
                              children: [
                                TextSpan(
                                  text: usuario.nombre,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2
                                      .copyWith(
                                        color: isActive
                                            ? Colors.white
                                            : kTextColor,
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Column(
                          children: [
                            Text(
                              usuario.createdAt,
                              style:
                                  Theme.of(context).textTheme.caption.copyWith(
                                        color: isActive ? Colors.white70 : null,
                                      ),
                            ),
                            SizedBox(height: 5),
                            Icon(usuario.activo == 1
                                ? Icons.check_circle_outline_outlined
                                : Icons.cancel_outlined)
                          ],
                        )
                      ],
                    ),
                    // SizedBox(height: kDefaultPadding / 2),
                    // Text(
                    //   "    Id: " + usuario.id.toString(),
                    //   maxLines: 2,
                    //   overflow: TextOverflow.ellipsis,
                    //   style: Theme.of(context).textTheme.caption.copyWith(
                    //         height: 1.5,
                    //         color: isActive ? Colors.white70 : null,
                    //       ),
                    // ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
