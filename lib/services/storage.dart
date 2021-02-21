import 'package:firebase_storage/firebase_storage.dart';

class StorageService {
  StorageService._instantiate();

  static final StorageService instance = StorageService._instantiate();

  Future<List<String>> findAllFilesReferenceByUserEmail(String email) async {
    final references = await FirebaseStorage.instance.ref('certificados/$email').listAll().then((result) => result.items);
    return references.map((reference) => reference.fullPath).toList();
  }

  Future<FullMetadata> findFileMetadataByFilePath(String path) {
    return FirebaseStorage.instance.ref(path).getMetadata();
  }

  Future<String> findDownloadUrlByFilePath(String path) {
    return FirebaseStorage.instance.ref(path).getDownloadURL().catchError((err) => print(err));
  }
  
  Future<String> findImageUrlByName(String name) async {
    return FirebaseStorage.instance
      .ref('imagens/$name')
      .getDownloadURL()
      .then((url) => url.replaceFirst(RegExp('imagens/'), 'imagens%2F'))
      .catchError((err) => print(err));
  }
}