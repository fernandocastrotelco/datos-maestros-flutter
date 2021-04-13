import 'package:flutter/material.dart';

import '../../../../constants.dart';

class SideMenuItem extends StatelessWidget {
  const SideMenuItem({
    Key key,
    this.isActive,
    this.isHover = false,
    this.itemCount,
    this.showBorder = true,
    @required this.iconSrc,
    @required this.title,
    @required this.press,
  }) : super(key: key);

  final bool isActive, isHover, showBorder;
  final int itemCount;
  final IconData iconSrc;
  final String title;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: kDefaultPadding),
      child: InkWell(
        onTap: press,
        child: Row(
          children: [
            (isActive || isHover)
                ? Icon(
                    Icons.chevron_right_rounded,
                    size: 18,
                  )
                : SizedBox(width: 18),
            SizedBox(width: kDefaultPadding / 4),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(bottom: 15, right: 5),
                decoration: showBorder
                    ? BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: Color(0xFFDFE2EF)),
                        ),
                      )
                    : null,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      iconSrc,
                      size: 24,
                      color: (isActive || isHover) ? kPrimaryColor : kGrayColor,
                    ),
                    SizedBox(width: kDefaultPadding * 0.75),
                    Text(
                      title,
                      style: Theme.of(context).textTheme.button.copyWith(
                            color:
                                (isActive || isHover) ? kTextColor : kGrayColor,
                          ),
                    ),
                    // Spacer(),
                    // Text(
                    //   "#",
                    //   style: Theme.of(context).textTheme.caption.copyWith(
                    //         fontWeight: FontWeight.w500,
                    //         color: Colors.white,
                    //       ),
                    // ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
