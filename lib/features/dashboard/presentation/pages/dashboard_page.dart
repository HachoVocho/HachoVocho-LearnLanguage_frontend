import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/widgets/globally_used_widgets.dart';
import '../../../users/presentation/pages/user_profile_page.dart';
import 'modules_page.dart'; // New ModulesPage
import '../cubit/dashboard_cubit.dart';

class UserDashboardPage extends StatelessWidget {
  UserDashboardPage({super.key});

  final List<Widget> _pages = [
    ModulesPage(), // New ModulesPage
    const UserProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => DashboardCubit(),
      child: BlocBuilder<DashboardCubit, DashboardState>(
        builder: (context, state) {
          final cubit = context.read<DashboardCubit>();

          return Scaffold(
            appBar: AppBar(
              title: const Text(
                'HV Learn Language',
                style: TextStyle(color: Colors.white),
              ),
              backgroundColor: Colors.deepPurple,
              actions: [
                IconButton(
                  icon: const Icon(Icons.logout),
                  color: Colors.white,
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('Logout'),
                          content: const Text('Are you sure you want to log out?'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () async {
                                await storeBoolInSharedPreference('is_user_logged_in',false);
                                Navigator.of(context).pushNamedAndRemoveUntil(
                                  '/login',
                                  (route) => false,
                                );
                              },
                              child: const Text('Logout'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              ],
            ),
            body: _pages[state.currentIndex], // Show the selected page
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: state.currentIndex,
              onTap: (index) {
                cubit.updateIndex(index); // Update the index using Cubit
              },
              selectedItemColor: Colors.deepPurple,
              unselectedItemColor: Colors.grey,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.layers), // Changed icon to represent modules
                  label: 'Modules',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.account_circle),
                  label: 'Profile',
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
