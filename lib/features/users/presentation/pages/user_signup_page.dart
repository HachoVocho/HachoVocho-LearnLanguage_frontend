import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hachovocho_learn_language/features/users/domain/entities/signup_users_params_entity.dart';
import '../../../../core/global/global_static_strings.dart';
import '../cubit/users_cubit.dart';
import '../cubit/users_state.dart';

class UserSignupPage extends StatelessWidget {
  UserSignupPage({super.key});

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _dateOfBirthController = TextEditingController();

  String? _selectedGender;

  final List<String> _genders = ['M', 'F', 'O'];
  final ValueNotifier<bool> _passwordObscureNotifier = ValueNotifier(true);


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UsersCubit, UsersState>(
      listener: (context, state) {
        if (state is SignupUsersSuccess) {
          Navigator.pushNamed(
            context,
            '/otp',
            arguments: _emailController.text.trim(), // Pass email as an argument
          );
        } else if (state is SignupUsersError) {
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
              GlobalStaticStrings.staticStrings['signup_title']!,
              style: TextStyle(
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
          body: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: constraints.maxHeight,
                  ),
                  child: IntrinsicHeight(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              GlobalStaticStrings.staticStrings['signup_subtitle']!,
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                              ),
                            ),
                            const SizedBox(height: 32),
                            _buildInputField(
                              label: GlobalStaticStrings.staticStrings['first_name_label']!,
                              hint: GlobalStaticStrings.staticStrings['first_name_hint']!,
                              controller: _firstNameController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return GlobalStaticStrings.staticStrings['first_name_required'];
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 16),
                            _buildInputField(
                              label: GlobalStaticStrings.staticStrings['last_name_label']!,
                              hint: GlobalStaticStrings.staticStrings['last_name_hint']!,
                              controller: _lastNameController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return GlobalStaticStrings.staticStrings['last_name_required'];
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 16),
                            _buildInputField(
                              label: GlobalStaticStrings.staticStrings['email_label']!,
                              hint: GlobalStaticStrings.staticStrings['email_hint']!,
                              controller: _emailController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return GlobalStaticStrings.staticStrings['email_required'];
                                } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                                  return GlobalStaticStrings.staticStrings['valid_email_required'];
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 16),
                            _buildInputField(
                              label: GlobalStaticStrings.staticStrings['password_label']!,
                              hint: GlobalStaticStrings.staticStrings['password_hint']!,
                              controller: _passwordController,
                              obscureText: true,
                              obscureNotifier: _passwordObscureNotifier,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return GlobalStaticStrings.staticStrings['password_required'];
                                } else if (value.length < 6) {
                                  return GlobalStaticStrings.staticStrings['password_min_length'];
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 16),
                            _buildDropdownField(
                              label: GlobalStaticStrings.staticStrings['gender_label']!,
                              value: _selectedGender,
                              items: _genders,
                              onChanged: (value) {
                                _selectedGender = value;
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return GlobalStaticStrings.staticStrings['gender_required'];
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 16),
                            _buildDatePickerField(
                              label: GlobalStaticStrings.staticStrings['dob_label']!,
                              controller: _dateOfBirthController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return GlobalStaticStrings.staticStrings['dob_required'];
                                }
                                return null;
                              },
                              context: context
                            ),
                            const SizedBox(height: 32),
                            ElevatedButton(
                              onPressed: state is UsersLoading
                                  ? null
                                  : () {
                                      if (_formKey.currentState!.validate()) {
                                        DateTime date = DateTime.parse(_dateOfBirthController.text.split('T')[0]);
                                        
                                        final user = SignupUsersParamsEntity(
                                          firstName: _firstNameController.text.trim(),
                                          lastName: _lastNameController.text.trim(),
                                          email: _emailController.text.trim(),
                                          password: _passwordController.text,
                                          gender: _selectedGender!,
                                          dateOfBirth: '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}'
                                        );
                                        context.read<UsersCubit>().signupUsers(user);
                                      }
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
                                        GlobalStaticStrings.staticStrings['signup_button']!,
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 1.2,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                            ),
                            const Spacer(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  GlobalStaticStrings.staticStrings['already_have_account']!,
                                  style: TextStyle(fontSize: 14, color: Colors.grey),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pushNamed(context, '/login');
                                  },
                                  child: Text(
                                    GlobalStaticStrings.staticStrings['login_button']!,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.deepPurple,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ))));
          },
              ),
            );
          }
        );
      }

      Widget _buildInputField({
        required String label,
        required String hint,
        required TextEditingController controller,
        bool obscureText = false,
        String? Function(String?)? validator,
        ValueNotifier<bool>? obscureNotifier, // Add this parameter
      }) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 8),
            ValueListenableBuilder<bool>(
              valueListenable: obscureNotifier ?? ValueNotifier(false),
              builder: (context, isObscure, child) {
                return TextFormField(
                  controller: controller,
                  obscureText: obscureText ? isObscure : false,
                  decoration: InputDecoration(
                    hintText: hint,
                    hintStyle: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Colors.deepPurple),
                    ),
                    filled: true,
                    fillColor: Colors.grey[100],
                    suffixIcon: obscureText
                        ? IconButton(
                            icon: Icon(
                              isObscure ? Icons.visibility : Icons.visibility_off,
                            ),
                            onPressed: () {
                              obscureNotifier!.value = !isObscure;
                            },
                          )
                        : null,
                  ),
                  validator: validator,
                );
              },
            ),
          ],
        );
      }


      Widget _buildDropdownField({
        required String label,
        required String? value,
        required List<String> items,
        required Function(String?) onChanged,
        String? Function(String?)? validator,
      }) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              value: value,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Colors.deepPurple),
                ),
                filled: true,
                fillColor: Colors.grey[100],
              ),
              items: items
                  .map((gender) => DropdownMenuItem<String>(
                        value: gender,
                        child: Text(gender),
                      ))
                  .toList(),
              onChanged: onChanged,
              validator: validator,
            ),
          ],
        );
      }

      Widget _buildDatePickerField({
        required String label,
        required TextEditingController controller,
        String? Function(String?)? validator,
        required BuildContext context
      }) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: controller,
              readOnly: true,
              decoration: InputDecoration(
                hintText: GlobalStaticStrings.staticStrings['select_dob_hint']!,
                hintStyle: const TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Colors.deepPurple),
                ),
                filled: true,
                fillColor: Colors.grey[100],
                suffixIcon: Icon(Icons.calendar_today, color: Colors.grey),
              ),
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1900),
                  lastDate: DateTime.now(),
                );
                if (pickedDate != null) {
                  controller.text = pickedDate.toLocal().toString().split(' ')[0];
                }
              },
              validator: validator,
            ),
          ],
        );
      }
    }
