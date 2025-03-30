import os

def initialize_feature_structure(parent_folder, feature_name):
    """
    Initialize the folder and file structure for a main feature.

    :param parent_folder: The parent folder where the feature is added.
    :param feature_name: Name of the main feature (e.g., 'userProfile').
    """
    # Convert feature name to various naming formats
    feature_name_camel = "".join([word.capitalize() for word in feature_name.split('_')])
    feature_name_snake = "_".join([word for word in feature_name.split('_')])

    # Define paths for data, domain, and presentation layers
    data_path = os.path.join(parent_folder, "data")
    domain_path = os.path.join(parent_folder, "domain")
    presentation_path = os.path.join(parent_folder, "presentation")

    # Create folder structure
    os.makedirs(os.path.join(data_path, "datasource"), exist_ok=True)
    os.makedirs(os.path.join(data_path, "repositories"), exist_ok=True)
    os.makedirs(os.path.join(data_path, "models"), exist_ok=True)

    os.makedirs(os.path.join(domain_path, "repositories"), exist_ok=True)
    os.makedirs(os.path.join(domain_path, "usecases"), exist_ok=True)
    os.makedirs(os.path.join(domain_path, "entities"), exist_ok=True)

    os.makedirs(os.path.join(presentation_path, "cubit"), exist_ok=True)
    di_file_path = os.path.join(parent_folder, f"{feature_name}_dependency_injection.dart")
    dependency_injection_content = f"""
    import 'package:get_it/get_it.dart';

    import 'data/datasource/network_source.dart';
    import 'data/datasource/network_source_imp.dart';
    import 'data/repositories/{feature_name}_repository_imp.dart';
    import 'domain/repositories/{feature_name}_repository.dart';
    import 'presentation/cubit/{feature_name}_cubit.dart';

    final {feature_name.capitalize()}Instance = GetIt.instance;

    Future<void> init() async {{
    // Data Sources
    {feature_name.capitalize()}Instance.registerLazySingleton<{feature_name.capitalize()}NetworkSource>(
        () => {feature_name.capitalize()}NetworkSourceImp(),
    );

    // Repositories
    {feature_name.capitalize()}Instance.registerLazySingleton<{feature_name.capitalize()}Repository>(
        () => {feature_name.capitalize()}RepositoryImp({feature_name.capitalize()}Instance<{feature_name.capitalize()}NetworkSource>()),
    );
    
    // Use Cases

    // Cubits
    {feature_name.capitalize()}Instance.registerFactory(() => {feature_name.capitalize()}Cubit());
    }}
    """
    with open(di_file_path, "w", encoding="utf-8") as file:
        file.write(dependency_injection_content)
    # Create network_source.dart
    network_source_path = os.path.join(data_path, "datasource", "network_source.dart")
    if not os.path.exists(network_source_path):
        with open(network_source_path, "w") as file:
            file.write(f"""
abstract class {feature_name_camel}NetworkSource {{
  // Define abstract methods here
}}
""")

    # Create network_source_imp.dart
    network_source_imp_path = os.path.join(data_path, "datasource", "network_source_imp.dart")
    if not os.path.exists(network_source_imp_path):
        with open(network_source_imp_path, "w") as file:
            file.write(f"""
import 'network_source.dart';
import '../../../../core/utils/api_service/api_helper_dio.dart';
                       
class {feature_name_camel}NetworkSourceImp extends {feature_name_camel}NetworkSource {{
  // Implement methods here
}}
""")

    # Create repository interface
    repository_interface_path = os.path.join(domain_path, "repositories", f"{feature_name_snake}_repository.dart")
    if not os.path.exists(repository_interface_path):
        with open(repository_interface_path, "w") as file:
            file.write(f"""
import 'package:dartz/dartz.dart';
import '../../../../core/failures/failures.dart';
                       
abstract class {feature_name_camel}Repository {{
  // Define repository methods here
}}
""")

    # Create repository implementation
    repository_implementation_path = os.path.join(data_path, "repositories", f"{feature_name_snake}_repository_imp.dart")
    if not os.path.exists(repository_implementation_path):
        with open(repository_implementation_path, "w") as file:
            file.write(f"""
import 'package:dartz/dartz.dart';
import '../../../../core/failures/failures.dart';
import '../../domain/repositories/{feature_name_snake}_repository.dart';
import '../datasource/network_source.dart';

class {feature_name_camel}RepositoryImp extends {feature_name_camel}Repository {{
  final {feature_name_camel}NetworkSource _networkSource;

  {feature_name_camel}RepositoryImp(this._networkSource);

  // Implement repository methods here
}}
""")

    # Create cubit file
    cubit_file_path = os.path.join(presentation_path, "cubit", f"{feature_name_snake}_cubit.dart")
    if not os.path.exists(cubit_file_path):
        with open(cubit_file_path, "w") as file:
            file.write(f"""
import 'package:flutter_bloc/flutter_bloc.dart';
import './{feature_name_snake}_state.dart';

class {feature_name_camel}Cubit extends Cubit<{feature_name_camel}State> {{
  // Initialize use cases or repository here

  {feature_name_camel}Cubit() : super(Initial{feature_name_camel}State());

  // Add methods here
}}
""")

    # Create state file
    state_file_path = os.path.join(presentation_path, "cubit", f"{feature_name_snake}_state.dart")
    if not os.path.exists(state_file_path):
        with open(state_file_path, "w") as file:
            file.write(f"""
import 'package:equatable/equatable.dart';
                       
abstract class {feature_name_camel}State extends Equatable {{
    @override
    List<Object?> get props => [];
}}

class {feature_name_camel}Loading extends {feature_name_camel}State {{}}

class Initial{feature_name_camel}State extends {feature_name_camel}State {{}}

// Add other states as needed
""")

    print(f"Initialized structure for feature: {feature_name}")


# Example Usage
if __name__ == "__main__":
    parent_folder = "/Users/anirudhchawla/hachovocho_learn_language/lib/features/testing"
    feature_name = "testing"  # Feature name in snake_case
    initialize_feature_structure(parent_folder, feature_name)
