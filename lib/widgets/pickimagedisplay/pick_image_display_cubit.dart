import 'dart:typed_data';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../utils/imageapppicker/image_app_picker.dart';

part 'pick_image_display_state.dart';

class PickImageDisplayCubit extends Cubit<PickImageDisplayState> {
  PickImageDisplayCubit() : super(PickImageDisplayInitial());


  start(dynamic image){
    if(image == null) return;
    else if(image is String) emit(ImageUrlState(image));
    else if(image is Uint8List) emit(FileImageState(image));
    else throw ArgumentError("image is not Uint8List of file or string instead of it is: ${image.runtimeType}");
  }


  pickImage() async {
    try{
      final bytes = await ImageAppPicker().pickFile();
      if(bytes == null) return;
      emit(FileImageState(bytes));
    }catch(e,s){
      print("failed pick image error: $e\nstackTrace: $s");
    }
  }
}
