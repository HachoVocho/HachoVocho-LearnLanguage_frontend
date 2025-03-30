import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hachovocho_learn_language/features/users/presentation/cubit/users_cubit.dart';

import '../../../../core/global/global_static_strings.dart';
import '../../domain/entities/verify_email_users_params_entity.dart';
import '../cubit/users_state.dart';


class UserOtpPage extends StatelessWidget {
  final String email;

  UserOtpPage({super.key, required this.email});

  final TextEditingController _otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UsersCubit, UsersState>(
      listener: (context, state) {
        if (state is VerifyEmailUsersSuccess) {
          Navigator.pushNamed(context, '/dashboard');
        } else if (state is VerifyEmailUsersError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            centerTitle: true,
            title: Text(
              GlobalStaticStrings.staticStrings["otp_title"]!,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  GlobalStaticStrings.staticStrings["otp_subtitle"]!,
                  style: const TextStyle(fontSize: 16, color: Colors.grey),
                ),
                const SizedBox(height: 16),
                TextField(
                  readOnly: true,
                  controller: TextEditingController(text: email),
                  decoration: InputDecoration(
                    labelText: GlobalStaticStrings.staticStrings["email_label"]!,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    filled: true,
                    fillColor: Colors.grey[100],
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _otpController,
                  keyboardType: TextInputType.number,
                  maxLength: 6,
                  decoration: InputDecoration(
                    labelText: GlobalStaticStrings.staticStrings["otp_label"]!,
                    hintText: GlobalStaticStrings.staticStrings["otp_hint"]!,
                    counterText: '',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    filled: true,
                    fillColor: Colors.grey[100],
                  ),
                ),
                const SizedBox(height: 32),
                ElevatedButton(
                  onPressed: state is UsersLoading
                      ? null
                      : () {
                          final otp = _otpController.text.trim();

                          if (otp.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  GlobalStaticStrings.staticStrings["otp_required"]!,
                                ),
                              ),
                            );
                            return;
                          }

                          final verifyParams = VerifyEmailUsersParamsEntity(
                            email: email,
                            code: otp,
                          );

                          context.read<UsersCubit>().verifyEmailUsers(verifyParams);
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    elevation: 8,
                    minimumSize: const Size.fromHeight(50),
                  ),
                  child: state is UsersLoading
                      ? const CircularProgressIndicator(
                          color: Colors.white,
                        )
                      : Center(
                          child: Text(
                            GlobalStaticStrings.staticStrings["otp_title"]!,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.2,
                              color: Colors.white,
                            ),
                          ),
                        ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
