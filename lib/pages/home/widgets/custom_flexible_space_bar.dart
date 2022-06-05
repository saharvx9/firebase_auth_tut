import 'package:firebase_auth_tut/utils/ext/string_ext.dart';
import 'package:firebase_auth_tut/widgets/pickimagedisplay/pick_display_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CustomFlexibleSpaceBar extends StatefulWidget {
  final double collapsedHeight;
  final double expandedHeight;
  final double maxSizeImage;
  final double minSizeImage;
  final Color? backgroundColor;
  final String? title;
  final TextStyle? style;
  final Widget? action;
  final String? imageUrl;
  final bool innerBoxIsScrolled;
  final Function(double ratio)? onRatioChange;

  const CustomFlexibleSpaceBar(
      {Key? key,
      required this.imageUrl,
      this.collapsedHeight = 60.0,
      this.expandedHeight = 200.0,
      this.maxSizeImage = 130,
      this.minSizeImage = 30,
      this.title,
      this.style,
      this.action,
      this.innerBoxIsScrolled = false,
      this.onRatioChange,
      this.backgroundColor})
      : assert(expandedHeight > maxSizeImage && collapsedHeight > minSizeImage),
        super(key: key);

  @override
  State<CustomFlexibleSpaceBar> createState() => _CustomFlexibleSpaceBarState();
}

class _CustomFlexibleSpaceBarState extends State<CustomFlexibleSpaceBar> {
  double extYAxisOff = 30.0;
  Color? _color;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: widget.expandedHeight,
      centerTitle: true,
      floating: false,
      elevation: 0,
      pinned: true,
      backgroundColor: widget.backgroundColor,
      forceElevated: widget.innerBoxIsScrolled,
      flexibleSpace: LayoutBuilder(builder: (ctx, constraints) {
        final diff = widget.maxSizeImage - widget.minSizeImage;

        double extentRatio = (constraints.biggest.height - widget.collapsedHeight) / (widget.expandedHeight - widget.collapsedHeight);
        var ratio = extentRatio;
        if (extentRatio < 0.17) {
          ratio = 0;
        } else if (extentRatio >= 1) {
          ratio = 1;
        }
        widget.onRatioChange?.call(ratio);
        double xAxisOffset1 = (ratio * 160) - 160;
        double yAxisOffset1 = (ratio * -30) + 5;
        return FlexibleSpaceBar(
          collapseMode: CollapseMode.pin,
          centerTitle: true,
          title: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Container(
                transform: Matrix4(1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, xAxisOffset1, yAxisOffset1, 0, 1),
                decoration:  const BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black45,
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ]
                ),
                child: PickDisplayImage(
                  image: widget.imageUrl,
                  pickImage: false,
                  size: (ratio * diff) + widget.minSizeImage,
                ),
              ),

              if(widget.title.isNotNullOrEmpty)...[
                Container(
                  transform: Matrix4(1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0,
                      xAxisOffset1 + 70, yAxisOffset1, 0, 1),
                  child: Opacity(
                    opacity: (ratio) * -1 + 1,
                    child: Text(widget.title!,style: widget.style,)
                  ),
                ),
              ],

              if(widget.action != null)...[
                Align(
                  alignment: AlignmentDirectional.bottomEnd,
                  child: Opacity(
                    opacity: (ratio) * -1 + 1,
                    child: Padding(
                      padding: const EdgeInsetsDirectional.only(end: 20),
                      child: widget.action,
                    ),
                  ),
                )
              ],
            ],
          ),
        );
      }),
    );
  }
}
