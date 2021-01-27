import 'package:firebase_storage/firebase_storage.dart';

class StorageService {
  StorageService._instantiate();

  static final StorageService instance = StorageService._instantiate();

  Future<List<String>> findAllFilesReferenceByUserEmail(String email) async {
    var references = await FirebaseStorage.instance.ref('certificados/$email').listAll().then((result) => result.items);
    return references.map((reference) => reference.fullPath).toList();
  }

  Future<FullMetadata> findFileMetadataByFilePath(String path) {
    return FirebaseStorage.instance.ref(path).getMetadata();
  }
}