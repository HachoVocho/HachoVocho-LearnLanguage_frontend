import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardState {
  final int currentIndex;

  const DashboardState(this.currentIndex);
}

class DashboardCubit extends Cubit<DashboardState> {
  DashboardCubit() : super(const DashboardState(0)); // Default to the first tab (Modules)

  void updateIndex(int index) {
    emit(DashboardState(index));
  }
}
