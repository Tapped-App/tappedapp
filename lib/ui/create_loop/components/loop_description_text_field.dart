import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intheloopapp/ui/create_loop/cubit/create_loop_cubit.dart';

class LoopDescriptionTextField extends StatelessWidget {
   LoopDescriptionTextField({super.key, TextEditingController? controller}) : controller = controller ?? TextEditingController();
final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateLoopCubit, CreateLoopState>(
      builder: (context, state) {
        return TextFormField(
          controller: controller,
          keyboardType: TextInputType.multiline,
          maxLines: null,
          decoration: const InputDecoration.collapsed(
            hintText: "What's on your mind?",
          ),
          style: const TextStyle(
            letterSpacing: 0,
          ),
          maxLength: 512,
          minLines: 6,
          validator: (value) =>
              value!.isEmpty ? 'Description cannot be empty' : null,
          onChanged: (input) =>
              context.read<CreateLoopCubit>().onDescriptionChange(
                    input.trim(),
                  ),
        );
      },
    );
  }
}
