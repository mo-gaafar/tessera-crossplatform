import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tessera/features/organizers_view/event_creation/cubit/createEvent_cubit.dart';

class MyImagePicker extends StatefulWidget {
  const MyImagePicker({super.key});

  @override
  State<MyImagePicker> createState() => _MyImagePickerState();
}

class _MyImagePickerState extends State<MyImagePicker> {
  XFile? image;
  ImagePicker picker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        image != null
            ? Image.file(
                File(image!.path),
                height: 200,
                fit: BoxFit.cover,
              )
            : const Icon(
                Icons.disabled_by_default_outlined,
                size: 100,
              ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            GestureDetector(
              child: const Icon(
                Icons.camera_alt_outlined,
                semanticLabel: "Take a photo",
              ),
              onTap: () async {
                XFile? tempImage =
                    await picker.pickImage(source: ImageSource.camera);
                setState(() {
                  image = tempImage;
                  context.read<CreateEventCubit>().currentEvent.eventImage =
                      File(image!.path);
                });
              },
            ),
            GestureDetector(
              child: const Icon(
                Icons.vrpano_outlined,
                semanticLabel: "Choose a photo",
              ),
              onTap: () async {
                XFile? tempImage =
                    await picker.pickImage(source: ImageSource.gallery);
                setState(() {
                  image = tempImage;
                  context.read<CreateEventCubit>().currentEvent.eventImage =
                      File(image!.path);
                });
              },
            ),
          ],
        ),
      ],
    );
  }
}
