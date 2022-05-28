import 'dart:typed_data';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth_tut/utils/ext/string_ext.dart';
import 'package:meta/meta.dart';

part 'pick_image_display_state.dart';

class PickImageDisplayCubit extends Cubit<PickImageDisplayState> {
  PickImageDisplayCubit() : super(PickImageDisplayInitial());


  start(dynamic image){
    if(image == null) return;
    switch(image.runtimeType){
      case String:
        emit(ImageUrlState(image));
        break;
      case Uint8List:
        emit(FileImageState(image));
        break;
      default:
        throw ArgumentError("image is not Uint8List of file or string instead oof it is: ${image.runtimeType}");
    }
  }


  pickImage() async {
    final xFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if(xFile == null) return;
    emit(FileImageState(await xFile.readAsBytes()));
  }
}
