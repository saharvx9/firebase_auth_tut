part of 'pick_image_display_cubit.dart';

@immutable
abstract class PickImageDisplayState {}

class PickImageDisplayInitial extends PickImageDisplayState {}

class ImageUrlState extends PickImageDisplayState {
  final String imageUrl;
  ImageUrlState(this.imageUrl);
}

class FileImageState extends PickImageDisplayState {
  final Uint8List image;
  FileImageState(this.image);
}
