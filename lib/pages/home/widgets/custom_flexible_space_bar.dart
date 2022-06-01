import 'package:firebase_auth_tut/utils/ext/string_ext.dart';
import 'package:firebase_auth_tut/widgets/pickimagedisplay/pick_display_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CustomFlexibleSpaceBar extends StatefulWidget {
  final double collapsedHeight;
  final double expandedHeight;
  final double maxSizeImage;
  final double minSizeImage;
  final String? title;
  final TextStyle? style;
  final Widget? action;
  final String? imageUrl;

  const CustomFlexibleSpaceBar(
      {Key? key,
      required this.imageUrl,
      this.collapsedHeight = 60.0,
      this.expandedHeight = 200.0,
      this.maxSizeImage = 130,
      this.minSizeImage = 30,
      this.title,
      this.style,
      this.action})
      : assert(expandedHeight > maxSizeImage && collapsedHeight > minSizeImage),
        super(key: key);

  @override
  State<CustomFlexibleSpaceBar> createState() => _CustomFlexibleSpaceBarState();
}

class _CustomFlexibleSpaceBarState extends State<CustomFlexibleSpaceBar> {
  double _extentRatio = 0;
  double extYAxisOff = 30.0;
  Color? _color;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: widget.expandedHeight,
      elevation: 5,
      centerTitle: true,
      floating: false,
      pinned: true,
      flexibleSpace: LayoutBuilder(builder: (ctx, constraints) {
        final diff = widget.maxSizeImage - widget.minSizeImage;

        _extentRatio = (constraints.biggest.height - widget.collapsedHeight) / (widget.expandedHeight - widget.collapsedHeight);
        var ratio = _extentRatio;
        if (_extentRatio < 0.17) {
          ratio = 0;
        } else if (_extentRatio >= 1) {
          ratio = 1;
        }
        double xAxisOffset1 = (ratio * 160) - 160;
        return FlexibleSpaceBar(
          collapseMode: CollapseMode.pin,
          centerTitle: true,
          title: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                transform: Matrix4(1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, xAxisOffset1, 5, 0, 1),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white),
                  shape: BoxShape.circle,
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
                      xAxisOffset1 + 70, 5, 0, 1),
                  child: Opacity(
                    opacity: (ratio) * -1 + 1,
                    child: Text(widget.title!,style: widget.style,)
                  ),
                ),
              ],

              if(widget.action != null)...[
                Container(
                  transform: Matrix4(1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, kIsWeb ? 210 :160, 5, 0, 1),
                  child: SizedBox(
                    child: Opacity(
                      opacity: (ratio) *-1 + 1,
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
