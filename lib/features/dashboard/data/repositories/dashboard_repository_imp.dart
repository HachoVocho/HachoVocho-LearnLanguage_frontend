
import '../../domain/repositories/dashboard_repository.dart';
import '../datasource/network_source_imp.dart';

class DashboardRepositoryImp extends DashboardRepository {
  final DashboardNetworkSourceImp _networkSource;

  DashboardRepositoryImp(this._networkSource);

  // Implement repository methods here
}
