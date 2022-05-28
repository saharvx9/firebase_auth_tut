import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth_tut/widgets/pickimagedisplay/pick_image_display_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PickDisplayImage extends StatelessWidget {
  final PickImageDisplayCubit _cubit;
  final dynamic image;
  final double size;
  final bool pickImage;
  final Function(Uint8List image)? onPickImage;

  PickDisplayImage(
      {Key? key,
      required this.size,
      this.image,
      this.pickImage = true,
      this.onPickImage})
      : _cubit = PickImageDisplayCubit()..start(image),
        assert(
            pickImage == false && image != null ||
            pickImage == true && onPickImage != null, true),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PickImageDisplayCubit, PickImageDisplayState>(
      listener: (prev, state) {
        if(state is FileImageState == false) return;
        final image = (state as FileImageState).image;
        onPickImage?.call(image);
      },
      bloc: _cubit,
      builder: (context, state) {
        switch (state.runtimeType) {
          case ImageUrlState:
            final imageUrl = (state as ImageUrlState).imageUrl;
            return _imageNetwork(imageUrl);
          case FileImageState:
            final image = (state as FileImageState).image;
            return _fileImage(image, context);
          default:
            return _pickImage(context);
        }
      },
    );
  }

  Widget _pickImage(BuildContext context) {
    final theme = Theme.of(context);
    return _circleParent(
        Stack(
          children: [
            Icon(Icons.person, size: size),
            PositionedDirectional(
                end: 5,
                bottom: 0,
                child: Container(
                  height: size * 0.3,
                  width: size * 0.3,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: theme.colorScheme.primary,
                      border: Border.all(color: theme.colorScheme.secondary)),
                  child: IconButton(
                      icon: const Icon(
                        Icons.camera_alt,
                        color: Colors.white,
                      ),
                      onPressed: () => _cubit.pickImage()),
                ))
          ],
        ),
        size,
        context);
  }

  Widget _fileImage(Uint8List image, BuildContext context) {
    return PhysicalModel(
        color: Colors.transparent,
        shape: BoxShape.circle,
        elevation: 5,
        child: ClipOval(
            child: Image.memory(
          image,
          fit: BoxFit.fill,
          height: size,
          width: size,
        )));
  }

  Widget _imageNetwork(String imageUrl) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      imageBuilder: (context, imageProvider) =>
          _circleParent(Image(image: imageProvider), size, context),
      progressIndicatorBuilder: (context, url, progress) => Center(
        child: CircularProgressIndicator(
          value: progress.progress != 1 ? progress.progress : null,
          valueColor: AlwaysStoppedAnimation<Color>(
              Theme.of(context).colorScheme.secondary),
        ),
      ),
    );
  }

  Widget _circleParent(Widget child, double size, BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: theme.colorScheme.secondary)),
      child: child,
    );
  }
}
