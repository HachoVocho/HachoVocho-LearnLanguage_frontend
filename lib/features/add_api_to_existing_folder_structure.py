import os

def to_camel_case(snake_str):
        components = snake_str.split('_')
        return components[0] + ''.join(x.capitalize() for x in components[1:])
def add_new_api(parent_folder, feature_name, api_endpoint, request_params, response_structure):
    """
    Add a new API (e.g., 'add_language_testing') to the existing folder structure (data, domain, and presentation).
    
    :param parent_folder: The parent folder path where changes are required (e.g., "/path/to/features/someFeature").
    :param feature_name: The feature name in snake_case (e.g., "add_language_testing").
    :param api_endpoint: API endpoint (e.g., "/some_app/add_users_details/").
    :param request_params: Dictionary of request parameters (e.g., {"id": "123"}).
    :param response_structure: Dictionary of response structure (keys/values you expect from API response).
    """
    # Extract core feature name (everything after the first underscore)
    if '_' in feature_name:
        feature_core_snake = feature_name.split('_')[-1]
    else:
        feature_core_snake = feature_name
    feature_core_camel = "".join([word.capitalize() for word in feature_core_snake.split('_')])
    
    # Convert full feature name to various naming formats
    feature_name_camel = "".join([word.capitalize() for word in feature_name.split('_')])
    feature_name_snake = "_".join([word for word in feature_name.split('_')])

    # Paths to respective layers
    data_path = os.path.join(parent_folder, "data")
    domain_path = os.path.join(parent_folder, "domain")
    presentation_path = os.path.join(parent_folder, "presentation")

    # Ensure required folders exist
    assert os.path.exists(data_path), f"Data folder not found: {data_path}"
    assert os.path.exists(domain_path), f"Domain folder not found: {domain_path}"
    # Uncomment if needed to ensure the presentation folder exists
    # assert os.path.exists(presentation_path), f"Presentation folder not found: {presentation_path}"
    print(feature_core_camel)
    print(feature_core_snake)
    print(feature_name_camel)
    print(feature_name_snake)
    feature_name_lower_camel = feature_name_camel[0].lower() + feature_name_camel[1:]
    # Add files and updates
    #update_dependency_injection_file(feature_core_camel,feature_core_snake,parent_folder, feature_name_snake, feature_name_camel, feature_name_snake, feature_name_camel)
    #update_network_source(data_path, feature_core_camel, feature_core_snake, feature_name_camel, feature_name_snake, api_endpoint, request_params,feature_name_lower_camel)
    #update_repository(data_path, domain_path, feature_core_camel, feature_core_snake, feature_name_camel, feature_name_snake,feature_name_lower_camel)
    update_domain_entities(domain_path, feature_core_camel, feature_core_snake, feature_name_camel, feature_name_snake, request_params, response_structure)
    models_path = os.path.join(data_path, "models")
    add_model_file(models_path, feature_name_snake, feature_name_camel,response_structure)
    usecases_path = os.path.join(domain_path, "usecases")
    #add_use_case_file(feature_core_camel,usecases_path, feature_name_snake, feature_name_camel, feature_core_snake,feature_name_lower_camel)
    # (Optional) If you have a Cubit/Bloc, uncomment and adjust the file name, class name, etc.:
    #update_cubit(os.path.join(presentation_path, "cubit"), feature_core_camel, feature_core_snake, feature_name_camel, feature_name_snake,feature_name_lower_camel)
    #update_state_file(os.path.join(presentation_path, "cubit", f"{feature_core_snake}_state.dart"),feature_core_camel,feature_name_camel)


def update_network_source(data_path, feature_core_camel, feature_core_snake, feature_name_camel, feature_name_snake, api_endpoint, request_params,feature_name_lower_camel):
    """
    Update network_source.dart (class LanguageTestingNetworkSource) and
    network_source_imp.dart (class LanguageTestingNetworkSourceImp) with the new API.
    """
    network_source_path = os.path.join(data_path, "datasource", "network_source.dart")
    network_source_imp_path = os.path.join(data_path, "datasource", "network_source_imp.dart")
    # -- 1) Update `network_source.dart` ----------------------------------
    # Insert a new method in the class LanguageTestingNetworkSource, e.g.:
    #   Future<AddLanguageTestingResponseEntity> addLanguageTesting(AddLanguageTestingParamsEntity addLanguageTestingParamsEntity);
    with open(network_source_path, "r+", encoding="utf-8") as file:
        content = file.read()
        new_imports = [
            f"import '../../domain/entities/{feature_name_snake}_params_entity.dart';",
            f"import '../../domain/entities/{feature_name_snake}_response_entity.dart';",
        ]
        content = "\n".join(new_imports) + "\n\n" + content

        method_signature = (
            f"Future<{feature_name_camel}ResponseEntity> "
            f"{feature_name_lower_camel}({feature_name_camel}ParamsEntity {feature_name_lower_camel}ParamsEntity);"
        )

        if method_signature not in content:
            # Locate the class definition
            class_name = f"class {feature_core_camel}NetworkSource"
            class_position = content.find(class_name)
            if class_position == -1:
                raise ValueError(
                    f"Could not find 'class {feature_core_camel}NetworkSource' in {network_source_path}"
                )

            # Find the opening brace of the class
            insert_position = content.find("{", class_position) + 1
            new_method_snippet = f"\n  {method_signature}"
            updated_content = (
                content[:insert_position] + new_method_snippet + content[insert_position:]
            )

            file.seek(0)
            file.write(updated_content)
            file.truncate()

    # -- 2) Update `network_source_imp.dart` ------------------------------
    # Insert an override in class LanguageTestingNetworkSourceImp,
    # e.g.:
    #
    #   @override
    #   Future<AddLanguageTestingResponseEntity> addLanguageTesting(AddLanguageTestingParamsEntity addLanguageTestingParamsEntity) async {
    #       ...
    #   }
    #
    with open(network_source_imp_path, "r+", encoding="utf-8") as file:
        content = file.read()
        new_imports = [
            f"import '../../domain/entities/{feature_name_snake}_params_entity.dart';",
            f"import '../../domain/entities/{feature_name_snake}_response_entity.dart';",
            f"import '../models/{feature_name_snake}_model.dart';",
        ]
        content = "\n".join(new_imports) + content

        override_signature = (
            f"Future<{feature_name_camel}ResponseEntity> "
            f"{feature_name_lower_camel}({feature_name_camel}ParamsEntity {feature_name_lower_camel}ParamsEntity)"
        )

        new_method = f"""
      @override
      {override_signature} async {{
        var params = {{
{generate_request_params_snippet(feature_name_lower_camel, request_params)}
        }};
    
        var _responseFromApi = await ApiHelperDio().postDioMethod(
          endpoint: '{api_endpoint}',
          params: params,
          isInFormData: false,
        );
    
        // If you have a model {feature_name_snake}_model.dart with fromMap(), use that here:
        return {feature_name_camel}ResponseModel.fromMap(_responseFromApi);
      }}
    """

        # Locate the class definition
        class_name = f"class {feature_core_camel}NetworkSourceImp"
        class_position = content.find(class_name)
        if class_position == -1:
            raise ValueError(
                f"Could not find 'class {feature_core_camel}NetworkSourceImp' in {network_source_imp_path}"
            )

        # Find the opening brace of the class
        insert_position = content.find("{", class_position) + 1
        updated_content = content[:insert_position] + new_method + content[insert_position:]

        file.seek(0)
        file.write(updated_content)
        file.truncate()


def update_repository(data_path, domain_path, feature_core_camel, feature_core_snake, feature_name_camel, feature_name_snake,feature_name_lower_camel):
    """
    Update the repository interface (class LanguageTestingRepository in language_testing_repository.dart)
    and the repository implementation (class LanguageTestingRepositoryImp in language_testing_repository_imp.dart).
    """
    # e.g., path: domain/repositories/language_testing_repository.dart
    repository_interface_path = find_file(
        domain_path, "repositories", f"{feature_core_snake}_repository.dart"
    )
    # e.g., path: data/repositories/language_testing_repository_imp.dart
    repository_implementation_path = find_file(
        data_path, "repositories", f"{feature_core_snake}_repository_imp.dart"
    )

    if repository_interface_path:
        with open(repository_interface_path, "r+", encoding="utf-8") as file:
            content = file.read()
            new_imports = [
                f"import '../entities/{feature_name_snake}_params_entity.dart';",
                f"import '../entities/{feature_name_snake}_response_entity.dart';",
            ]
            content = "\n".join(new_imports) + content

            # Method signature to insert:
            # Stream<Either<Failure, AddLanguageTestingResponseEntity>> addLanguageTesting(AddLanguageTestingParamsEntity addLanguageTestingParamsEntity);
            interface_signature = (
                f"Stream<Either<Failure, {feature_name_camel}ResponseEntity>> "
                f"{feature_name_lower_camel}({feature_name_camel}ParamsEntity {feature_name_lower_camel}ParamsEntity);"
            )

            if interface_signature not in content:
                # Locate the class definition
                class_name = f"class {feature_core_camel}Repository"
                class_position = content.find(class_name)
                if class_position == -1:
                    raise ValueError(
                        f"Could not find 'class {feature_core_camel}Repository' in {repository_interface_path}"
                    )

                # Find the opening brace of the class
                insert_position = content.find("{", class_position) + 1
                new_method = f"\n  {interface_signature}"
                updated_content = (
                    content[:insert_position] + new_method + content[insert_position:]
                )

                file.seek(0)
                file.write(updated_content)
                file.truncate()

    if repository_implementation_path:
        with open(repository_implementation_path, "r+", encoding="utf-8") as file:
            content = file.read()
            new_imports = [
                f"import '../../domain/entities/{feature_name_snake}_params_entity.dart';",
                f"import '../../domain/entities/{feature_name_snake}_response_entity.dart';",
            ]
            content = "\n".join(new_imports) + content

            # Method signature to insert:
            # @override
            # Stream<Either<Failure, AddLanguageTestingResponseEntity>> addLanguageTesting(AddLanguageTestingParamsEntity addLanguageTestingParamsEntity) async* { ... }
            implementation_signature = (
                f"Stream<Either<Failure, {feature_name_camel}ResponseEntity>> "
                f"{feature_name_lower_camel}({feature_name_camel}ParamsEntity {feature_name_lower_camel}ParamsEntity) async*"
            )

            if implementation_signature not in content:
                new_method = f"""
      @override
      {implementation_signature} {{
        try {{
          final responseFromNetwork = await _networkSource.{feature_name_lower_camel}({feature_name_lower_camel}ParamsEntity);
          yield Right(responseFromNetwork);
        }} on Failure catch (failure) {{
          yield Left(failure);
        }} catch (e) {{
          yield Left(FailureMessage());
        }}
      }}
    """

                # Locate the class definition
                class_name = f"class {feature_core_camel}RepositoryImp"
                class_position = content.find(class_name)
                if class_position == -1:
                    raise ValueError(
                        f"Could not find 'class {feature_core_camel}RepositoryImp' in {repository_implementation_path}"
                    )

                # Find the opening brace of the class
                insert_position = content.find("{", class_position) + 1
                # Skip the important lines
                important_lines_end = content.find(";", insert_position) + 1  # Find the end of the first semicolon
                important_lines_end = content.find(";", important_lines_end) + 1  # Find the end of the second semicolon
                updated_content = content[:important_lines_end] + new_method + content[important_lines_end:]

                file.seek(0)
                file.write(updated_content)
                file.truncate()


def update_domain_entities(domain_path, feature_core_camel, feature_core_snake, feature_name_camel, feature_name_snake, request_params, response_structure):
    """
    Create/overwrite the ParamsEntity and ResponseEntity files 
    in domain/entities for this new API.
    """
    def to_camel_case(snake_str):
        components = snake_str.split('_')
        return components[0] + ''.join(x.capitalize() for x in components[1:])
    # e.g. add_language_testing_params_entity.dart, add_language_testing_response_entity.dart
    params_entity_filename = f"{feature_name_snake}_params_entity.dart"
    response_entity_filename = f"{feature_name_snake}_response_entity.dart"

    params_entity_path = os.path.join(domain_path, "entities", params_entity_filename)
    # Generate the fields for the constructor (all strings for simplicity)
    # If you have typed data (e.g., int?), adapt as needed.
    fields_declaration = "\n    ".join(
    [f"final String {to_camel_case(key)};" for key in request_params.keys()]
)
    constructor_params = ", ".join([f"required this.{to_camel_case(key)}" for key in request_params.keys()])
    props_list = ", ".join(to_camel_case(key) for key in request_params.keys())

    # -- Write the Params Entity File -------------------------------------
    with open(params_entity_path, "w", encoding="utf-8") as file:
        file.write(f"""
import 'package:equatable/equatable.dart';

class {feature_name_camel}ParamsEntity extends Equatable {{
    {fields_declaration}

    const {feature_name_camel}ParamsEntity({{{constructor_params}}});

    @override
    List<Object?> get props => [{props_list}];
}}
""".strip())

    # -- Write the Response Entity File -----------------------------------
    # Adjust fields as needed based on your actual response structure.
    # Here, assuming success (bool), data (Map<String, dynamic>), message (String)
    response_entity_path = os.path.join(domain_path, "entities", f"{feature_name_snake}_response_entity.dart")

    # Utility to generate nested entities
    def generate_nested_entities(json_data, parent_name):
        nested_entities = []
        for key, value in json_data.items():
            parent_key = to_camel_case(f"{parent_name}{key.capitalize()}")
            if isinstance(value, dict):
                nested_entity_name = f"{parent_key}Entity"
                print('nested_entity_name')
                print(nested_entity_name)
                nested_entities.append(f"""
class {nested_entity_name} extends Equatable {{
{generate_entity_fields(f"{parent_name}{key.capitalize()}",value)}

const {nested_entity_name}({{{generate_constructor_params(value)}}});

@override
List<Object?> get props => [{generate_props_list(value)}];
}}
""")
                nested_entities += generate_nested_entities(value, f"{parent_name}{key.capitalize()}")
            elif isinstance(value, list) and value and isinstance(value[0], dict):
                nested_entity_name = f"{parent_name}{key.capitalize()}Entity"
                nested_entities.append(f"""
class {nested_entity_name} extends Equatable {{
{generate_entity_fields(f"{parent_name}{key.capitalize()}",value[0])}

const {nested_entity_name}({{{generate_constructor_params(value[0])}}});

@override
List<Object?> get props => [{generate_props_list(value[0])}];
}}
""")
                nested_entities += generate_nested_entities(value[0], f"{parent_name}{key.capitalize()}")
        return "".join(nested_entities)
    def to_camel_case(snake_str):
        components = snake_str.split('_')
        return components[0] + ''.join(x.capitalize() for x in components[1:])
    def generate_entity_fields(parent_name,json_data):
        return "\n  ".join(
            f"final {get_dart_type(parent_name,value, key)} {to_camel_case(key)};"
            for key, value in json_data.items()
        )
    def generate_constructor_params(json_data):
        return ", ".join(
            f"required this.{to_camel_case(key)}" for key in json_data.keys()
        )
    def generate_props_list(json_data):
        return ", ".join(to_camel_case(key) for key in json_data.keys())

    def get_dart_type(parent_name,value, key):
        pre_camel = to_camel_case(f"{parent_name}{key.capitalize()}")
        if isinstance(value, dict):
            return f"{pre_camel}Entity"
        elif isinstance(value, list):
            if value and isinstance(value[0], dict):
                return f"List<{pre_camel}Entity>"
            return "List<dynamic>"
        elif isinstance(value, bool):
            return "bool"
        elif isinstance(value, int):
            return "int"
        elif isinstance(value, float):
            return "double"
        else:
            return "String"

    # Generate nested entities for the `data` key if it's a dictionary or list
    nested_entities = ""
    data_field = ""
    data_constructor = ""
    data_props = ""

    if "data" in response_structure and isinstance(response_structure["data"], (dict, list)):
        # Generate nested entities if 'data' exists
        nested_entities = generate_nested_entities({"data": response_structure["data"]}, feature_name_camel)
        if isinstance(response_structure["data"], dict):
            data_field = f"  final {feature_name_camel}DataEntity? data;\n"
        elif isinstance(response_structure["data"], list):
            data_field = f"  final List<{feature_name_camel}DataEntity>? data;\n"
        data_constructor = "    this.data,\n"
        data_props = "data, "

    # Define the main entity
    response_entity_content = f"""
    import 'package:equatable/equatable.dart';

    class {feature_name_camel}ResponseEntity extends Equatable {{
    final bool success;
    {data_field}  final String message;

    const {feature_name_camel}ResponseEntity({{
        required this.success,
    {data_constructor}    required this.message,
    }});

    @override
    List<Object?> get props => [success, {data_props}message];
    }}

    {nested_entities}
    """

    # Write the file
    with open(response_entity_path, "w", encoding="utf-8") as file:
        file.write(response_entity_content.strip())

    print(f"Response entity file created: {response_entity_path}")

def update_cubit(presentation_path, feature_core_camel, feature_core_snake, feature_name_camel, feature_name_snake, feature_name_lower_camel):
    """
    Add the new API method and associated use case to an existing Cubit file.

    :param presentation_path: Path to the presentation folder.
    :param feature_core_camel: Core feature name in CamelCase (e.g., "User").
    :param feature_core_snake: Core feature name in snake_case (e.g., "user").
    :param feature_name_camel: New API name in CamelCase (e.g., "SignupUser").
    :param feature_name_snake: New API name in snake_case (e.g., "signup_user").
    :param feature_name_lower_camel: New API name in lowerCamelCase (e.g., "signupUser").
    """
    cubit_file = os.path.join(presentation_path, f"{feature_core_snake}_cubit.dart")
    if not os.path.exists(cubit_file):
        print(f"Cubit file not found: {cubit_file}, skipping cubit update.")
        return

    with open(cubit_file, "r+", encoding="utf-8") as file:
        content = file.read()

        # Add required imports
        new_imports = [
            f"import '../../domain/usecases/{feature_name_snake}_usecase.dart';",
            f"import '../../domain/entities/{feature_name_snake}_params_entity.dart';",
        ]
        for imp in new_imports:
            if imp not in content:
                content = imp + "\n" + content

        # Add constructor injection for the use case
        constructor_injection = f"final {feature_name_camel}UseCase _{feature_name_lower_camel}UseCase;"
        if constructor_injection not in content:
            content = content.replace("// Initialize use cases or repository here",
                                       constructor_injection + "\n\n  // Initialize use cases or repository here")

        # Update the constructor dynamically
        constructor_start = f"{feature_core_camel}Cubit("
        constructor_end = f") : super(Initial{feature_core_camel}State());"
        start_position = content.find(constructor_start)
        end_position = content.find(constructor_end, start_position)

        if start_position != -1 and end_position != -1:
            current_constructor = content[start_position + len(constructor_start):end_position].strip()
            new_use_case_param = f"this._{feature_name_lower_camel}UseCase,"
            if new_use_case_param not in current_constructor:
                updated_constructor = f"{constructor_start}{current_constructor} {new_use_case_param}{constructor_end}"
                content = content[:start_position] + updated_constructor + content[end_position + len(constructor_end):]

        # Add the method for the new API
        method_signature = f"Future<void> {feature_name_lower_camel}({feature_name_camel}ParamsEntity params)"
        if method_signature not in content:
            new_method = f"""
  {method_signature} async {{
    emit({feature_core_camel}Loading());
    _{feature_name_lower_camel}UseCase.call(params).listen((event) {{
      event.fold((fail) {{
        emit({feature_name_camel}Error(fail.toString()));
      }}, (success) {{
        print('success');
        print(success.message);
        emit({feature_name_camel}Success(success.message));
      }});
    }});
  }}
"""
            class_keyword = f"class {feature_core_camel}Cubit"
            class_position = content.find(class_keyword)
            if class_position == -1:
                print(
                    f"Could not find 'class {feature_core_camel}Cubit' in {cubit_file}, skipping cubit update."
                )
                return

            # Find the opening brace of the class
            insert_position = content.find("{", class_position) + 1
            content = content[:insert_position] + new_method + content[insert_position:]

        # Write the updated content back to the file
        file.seek(0)
        file.write(content)
        file.truncate()

    print(f"Cubit file updated: {cubit_file}")

def update_state_file(state_path, feature_core_camel, feature_name_camel):
    """
    Dynamically add new states to the existing State file.

    :param state_path: Path to the State file (e.g., "/path/to/language_testing_state.dart").
    :param feature_core_camel: Core feature name in CamelCase (e.g., "LanguageTesting").
    :param feature_name_camel: New API name in CamelCase (e.g., "SignupUser").
    """
    if not os.path.exists(state_path):
        print(f"State file not found: {state_path}, skipping state update.")
        return

    with open(state_path, "r+", encoding="utf-8") as file:
        content = file.read()

        # Define new states for success and error
        new_states = f"""
class {feature_name_camel}Success extends {feature_core_camel}State {{
  final String message;

  {feature_name_camel}Success(this.message);

  @override
  List<Object?> get props => [message];
}}

class {feature_name_camel}Error extends {feature_core_camel}State {{
  final String message;

  {feature_name_camel}Error(this.message);

  @override
  List<Object?> get props => [message];
}}
"""

        # Check if the states already exist
        if f"class {feature_name_camel}Success" not in content:
            content += "\n" + new_states

        # Write the updated content back to the State file
        file.seek(0)
        file.write(content)
        file.truncate()

    print(f"State file updated: {state_path}")



def find_file(base_path, subfolder, filename):
    """
    Utility to locate a file in `base_path/subfolder` that matches `filename` exactly.
    Returns None if not found.
    """
    folder_path = os.path.join(base_path, subfolder)
    if not os.path.isdir(folder_path):
        return None

    for f in os.listdir(folder_path):
        if f == filename:
            return os.path.join(folder_path, f)
    return None


def generate_request_params_snippet(feature_name_snake: str, request_params: dict) -> str:
    print('entered_here')
    """
    Utility to generate a Dart map snippet for request_params.
    Example output for request_params={'id': '123'} and feature_name_snake='add_language_testing':
       'id': add_language_testingParamsEntity.id,
    """
    def to_camel_case(snake_str):
        components = snake_str.split('_')
        return components[0] + ''.join(x.capitalize() for x in components[1:])
    lines = []
    for key in request_params.keys():
        print(key)
        lines.append(f"      '{key}': {feature_name_snake}ParamsEntity.{to_camel_case(key)},")
    return "\n".join(lines)

def add_model_file(models_path, feature_name_snake, feature_name_camel, json_response):
    """
    Add a new model file to the models folder for the given feature.
    
    :param models_path: Path to the models folder.
    :param feature_name_snake: Feature name in snake_case (e.g., "add_language_testing").
    :param feature_name_camel: Feature name in CamelCase (e.g., "AddLanguageTesting").
    :param json_response: JSON response structure to generate the model.
    """
    model_file_path = os.path.join(models_path, f"{feature_name_snake}_model.dart")
    
    def generate_nested_models(json_data, parent_name):
        nested_models = []
        for key, value in json_data.items():
            parent_key = to_camel_case(f"{parent_name}{key.capitalize()}")
            if isinstance(value, dict):
                print('parent_key')
                print(parent_key)
                nested_model_name = f"{parent_key}Model"
                print('nested_model_name')
                print(nested_model_name)
                print('value')
                print(value)
                nested_models.append(f"""
class {nested_model_name} extends {str(nested_model_name).replace('Model','Entity')}{{
{nested_model_name}({{{generate_constructor_params(value)}}}) : super(
    {generate_super_params(value)}
);
{generate_model_fields(f"{parent_key}",value)}
    
factory {nested_model_name}.fromMap(Map<String, dynamic> map) {{
    return {nested_model_name}(
    {generate_from_map_assignments(f"{parent_key}",value)}
    );
}}

factory {nested_model_name}.fromJson(String str) => {nested_model_name}.fromMap(json.decode(str));

String toJson() => json.encode(toMap());

Map<String, dynamic> toMap() => {{
    {generate_to_map_body(parent_key,value)}
}};
}}
""")
                nested_models += generate_nested_models(value, f"{parent_name}{key.capitalize()}")
            elif isinstance(value, list) and value and isinstance(value[0], dict):
                print('parent_key_list')
                print(parent_key)
                nested_model_name = f"{parent_key}Model"
                nested_models.append(f"""
class {nested_model_name} extends {str(nested_model_name).replace('Model','Entity')}{{
{generate_model_fields(f"{parent_key}",value[0])}

{nested_model_name}({{{generate_constructor_params(value[0])}}}): super(
    {generate_super_params(value[0])}
);

factory {nested_model_name}.fromMap(Map<String, dynamic> map) {{
    return {nested_model_name}(
    {generate_from_map_assignments(f"{parent_key}",value[0])}
    );
}}

factory {nested_model_name}.fromJson(String str) => {nested_model_name}.fromMap(json.decode(str));

String toJson() => json.encode(toMap());

Map<String, dynamic> toMap() => {{
    {generate_to_map_body(parent_key,value[0])}
}};
}}
""")
                nested_models += generate_nested_models(value[0], f"{parent_name}{key.capitalize()}")
        return "".join(nested_models)
    
    def to_camel_case(snake_str):
        components = snake_str.split('_')
        return components[0] + ''.join(x.capitalize() for x in components[1:])
    def generate_super_params(json_data):
        return ", ".join(
            f"{to_camel_case(key)}: {to_camel_case(key)}" for key in json_data.keys()
        )
    def generate_model_fields(parent_name,json_data):
        return "\n  ".join(
            f"final {get_dart_type(parent_name,value, key)} {to_camel_case(key)};"
            for key, value in json_data.items()
        )
    
    def generate_constructor_params(json_data):
        return ", ".join(
            f"required this.{to_camel_case(key)}" for key in json_data.keys()
        )
    
    def generate_from_map_assignments(parent_name,json_data):
        return ",\n      ".join(
            f"{to_camel_case(key)}: {get_dart_type_from_map(parent_name,value, key)}"
            for key, value in json_data.items()
        )
    
    def generate_to_map_body(parent_key,json_data):
        return ",\n    ".join(
            f"'{key}': {to_camel_case(key)}{generate_to_map_suffix(value)}"
            for key, value in json_data.items()
        )
    
    def generate_to_map_suffix(value):
        if isinstance(value, dict):
            return ".toMap()"
        elif isinstance(value, list) and value and isinstance(value[0], dict):
            return ".map((item) => item.toMap()).toList()"
        return ""
    
    def get_dart_type(parent_name,value, key):
        if isinstance(value, dict):
            pre_camel = to_camel_case(f"{parent_name}{key.capitalize()}")
            return to_camel_case(f"{pre_camel}Model")
        elif isinstance(value, list):
            if value and isinstance(value[0], dict):
                return (f"List<{pre_camel}Model>")
            return "List<dynamic>"
        elif isinstance(value, bool):
            return "bool"
        elif isinstance(value, int):
            return "int"
        elif isinstance(value, float):
            return "double"
        else:
            return "String"
    
    def get_dart_type_from_map(parent_name,value, key):
        pre_camel = to_camel_case(f"{parent_name}{key.capitalize()}")
        if isinstance(value, dict):
            return f"{pre_camel}Model.fromMap(map['{key}'] ?? {{}})"
        elif isinstance(value, list):
            if value and isinstance(value[0], dict):
                return f"(map['{key}'] as List).map((item) => {pre_camel}Model.fromMap(item)).toList()"
            return f"List<dynamic>.from(map['{key}'] ?? [])"
        return f"map['{key}']"

    # Generate nested models for the `data` key if it's a dictionary or list
    nested_models = ""
    if "data" in json_response and isinstance(json_response["data"], (dict, list)):
        nested_models = generate_nested_models({"data": json_response["data"]}, f"{feature_name_camel}")
        if isinstance(json_response["data"], dict):
            data_field_in_map = "'data': data.toMap()," if "data" in json_response else ""
            data_field = f"""
        final {feature_name_camel}DataModel data;
        
        {feature_name_camel}ResponseModel({{
            required bool success,
            required this.data,
            required String message,
        }}) : super(
                success: success,
                data: data,
                message: message,
            );
        
        factory {feature_name_camel}ResponseModel.fromMap(Map<String, dynamic> map) {{
            return {feature_name_camel}ResponseModel(
            success: map['success'] ?? false,
            data: {feature_name_camel}DataModel.fromMap(map['data'] ?? {{}}),
            message: map['message'] ?? '',
            );
        }}
        """
        elif isinstance(json_response["data"], list):
            data_field_in_map = "'data': data.map((item) => item.toMap()).toList()," if "data" in json_response else ""
            data_field = f"""
        final List<{feature_name_camel}DataModel> data;
        
        {feature_name_camel}ResponseModel({{
            required bool success,
            required this.data,
            required String message,
        }}) : super(
                success: success,
                data: data,
                message: message,
            );
        
        factory {feature_name_camel}ResponseModel.fromMap(Map<String, dynamic> map) {{
            return {feature_name_camel}ResponseModel(
            success: map['success'] ?? false,
            data: List<{feature_name_camel}DataModel>.from(
                (map['data'] ?? []).map((item) => {feature_name_camel}DataModel.fromMap(item))
            ),
            message: map['message'] ?? '',
            );
        }}
        """
    else:
        # If 'data' key does not exist, create a generic structure
        data_field_in_map = None
        nested_models = ""  # No nested models
        data_field = f"""
    {feature_name_camel}ResponseModel({{
        required bool success,
        required String message,
    }}) : super(
            success: success,
            message: message,
        );
    
    factory {feature_name_camel}ResponseModel.fromMap(Map<String, dynamic> map) {{
        return {feature_name_camel}ResponseModel(
        success: map['success'] ?? false,
        message: map['message'] ?? '',
        );
    }}
    """
    # Define the main model
    model_file_content = f"""
import 'dart:convert';

import '../../domain/entities/{feature_name_snake}_response_entity.dart';

class {feature_name_camel}ResponseModel extends {feature_name_camel}ResponseEntity {{
  {data_field}

  factory {feature_name_camel}ResponseModel.fromJson(String str) =>
      {feature_name_camel}ResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {{
    'success': success,
    {data_field_in_map if data_field_in_map is not None else None}
    'message': message,
  }};
}}

{nested_models}
"""

    # Write the file
    with open(model_file_path, "w", encoding="utf-8") as file:
        file.write(model_file_content)

    print(f"Model file created: {model_file_path}")

def add_use_case_file(feature_core_camel,usecases_path, feature_name_snake, feature_name_camel, feature_core_snake,feature_name_lower_camel):
    """
    Add a new use case file to the usecases folder for the given feature.

    :param usecases_path: Path to the usecases folder.
    :param feature_name_snake: Feature name in snake_case (e.g., "signup_user").
    :param feature_name_camel: Feature name in CamelCase (e.g., "SignupUser").
    :param repository_name_camel: Repository name in CamelCase (e.g., "UserRepository").
    """
    use_case_file_path = os.path.join(usecases_path, f"{feature_name_snake}_usecase.dart")

    # Define the content of the new use case file
    use_case_content = f"""
import 'package:dartz/dartz.dart';
import '../../../../core/failures/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/{feature_name_snake}_params_entity.dart';
import '../entities/{feature_name_snake}_response_entity.dart';
import '../repositories/{feature_core_snake}_repository.dart';

class {feature_name_camel}UseCase extends UseCase<{feature_name_camel}ResponseEntity, {feature_name_camel}ParamsEntity?> {{
  final {feature_core_camel}Repository _repository;

  {feature_name_camel}UseCase(this._repository);

  @override
  Stream<Either<Failure, {feature_name_camel}ResponseEntity>> call({feature_name_camel}ParamsEntity? params) {{
    return _repository.{feature_name_lower_camel}(params!);
  }}
}}
"""

    # Create the usecases folder if it doesn't exist
    os.makedirs(usecases_path, exist_ok=True)

    # Write the use case file content
    with open(use_case_file_path, "w", encoding="utf-8") as file:
        file.write(use_case_content)

    print(f"Use case file created: {use_case_file_path}")

def update_dependency_injection_file(feature_core_camel,feature_core_snake,parent_folder, feature_name_snake, feature_name_camel, usecase_name_snake, usecase_name_camel):
    """
    Update the dependency injection file to add a new use case and inject it into the Cubit.

    :param parent_folder: Path to the parent folder where the feature is located.
    :param feature_name_snake: Feature name in snake_case (e.g., "users").
    :param feature_name_camel: Feature name in CamelCase (e.g., "Users").
    :param usecase_name_snake: Use case name in snake_case (e.g., "signup_users").
    :param usecase_name_camel: Use case name in CamelCase (e.g., "SignupUsers").
    """
    print(parent_folder)
    di_file_path = os.path.join(parent_folder, f"{feature_core_snake}_dependency_injection.dart")

    if not os.path.exists(di_file_path):
        print(f"Dependency injection file not found: {di_file_path}")
        return

    with open(di_file_path, "r+", encoding="utf-8") as file:
        content = file.read()

        # Add the use case import
        usecase_import = f"import 'domain/usecases/{usecase_name_snake}_usecase.dart';"
        if usecase_import not in content:
            content = usecase_import + "\n" + content

        # Register the use case in the DI container
        usecase_registration = f"  {feature_core_camel}Instance.registerLazySingleton(() => {usecase_name_camel}UseCase({feature_core_camel}Instance<{feature_core_camel}Repository>()));"
        if usecase_registration not in content:
            insert_position = content.find("// Use Cases")
            content = (
                content[:insert_position + len("// Use Cases")] +
                f"\n{usecase_registration}" +
                content[insert_position + len("// Use Cases"):]
            )

        # Inject the use case into the Cubit
        # Define the new cubit registration line
        cubit_registration = f"{feature_core_camel}Instance<{feature_name_camel}UseCase>()"

        # Find the existing Cubit registration
        cubit_section_start = content.find(f"{feature_core_camel}Instance.registerFactory(() => {feature_core_camel}Cubit(")
        if cubit_section_start != -1:
            # Find the closing parenthesis of the Cubit registration
            cubit_section_end = content.find("));", cubit_section_start)
            if cubit_section_end != -1:
                # Extract the existing Cubit section
                cubit_section = content[cubit_section_start:cubit_section_end + 2]

                # Check if the new registration is already present
                if cubit_registration not in cubit_section:
                    # Remove the closing "));", append the new registration, and re-add "));"
                    updated_cubit_section = cubit_section.rstrip("));") + f"{cubit_registration},))"
                    content = content.replace(cubit_section, updated_cubit_section)
        else:
            # If no existing Cubit registration, add a new one
            updated_cubit = f"{feature_core_camel}Instance.registerFactory(() => {feature_core_camel}Cubit({cubit_registration}));"
            content += f"\n{updated_cubit}\n"



        file.seek(0)
        file.write(content)
        file.truncate()

    print(f"Dependency injection file updated: {di_file_path}")

#
# Example usage:
#
if __name__ == "__main__":
    parent_folder = "/Users/anirudhchawla/hachovocho_learn_language/lib/features/speakingPracticeHub"
    feature_name = "getFaceToFaceConversations_speakingPracticeHub"  # Feature name in snake_case
    api_endpoint = "/api/speaking/get_face_to_face_conversations/"
    request_params = {
        "user_id": 4,
    }
    response_structure = {
    "success": True,
    "data": [
        {
            "date": "11 January 2025",
            "conversations": [
                {
                    "id": 2,
                    "user_id": "4",
                    "preferred_language": "English",
                    "learning_language": "German",
                    "learning_language_level": "Beginner",
                    "transcription": "hallo wie geht's",
                    "translation": "Hello, how are you",
                    "suggested_response_preferred": "I'm fine, thank you! And you?",
                    "suggested_response_learning": "Mir geht es gut, danke! Und dir?",
                    "created_at": "2025-01-11T22:40:53.147313Z"
                }
            ]
        },
    ],
    "message": "Conversations fetched successfully."
}

    add_new_api(parent_folder, feature_name, api_endpoint, request_params, response_structure)
    print(f"Finished adding new API method for {feature_name}.")
