
import 'package:equatable/equatable.dart';
                       
abstract class DashboardState extends Equatable {
    @override
    List<Object?> get props => [];
}

class DashboardLoading extends DashboardState {}

class InitialDashboardState extends DashboardState {}

// Add other states as needed
