import 'package:usdol/app/core.dart';

class FileAttachmentInputController extends FormFieldInputController {
  FileAttachmentInputController({
    required super.definitionAttribute,
    required super.onChangedValue,
  });

  final _filesPathSelected = <String>[].obs;
  // ignore: invalid_use_of_protected_member
  List<String> get filesPathSelected => _filesPathSelected.value;
  set filesPathSelected(List<String> value) => _filesPathSelected.value = value;

  @override
  AttributeRequest getValue() {
    if (filesPathSelected.isNotEmpty) {
      return super.getValue()..setValue(value: filesPathSelected);
    } else {
      return super.getValue();
    }
  }

  @override
  bool isValid() {
    return filesPathSelected.isNotEmpty || isOptional();
  }

  void pickFile(String path) {
    filesPathSelected.add(path);
    _filesPathSelected.refresh();
    onChangedValue?.call();
  }

  void removeFile(String path) {
    filesPathSelected.removeWhere((element) => element == path);
    _filesPathSelected.refresh();
    onChangedValue?.call();
  }

  @override
  void reset() {
    filesPathSelected = [];
    _filesPathSelected.refresh();
  }
}
