import 'package:ctlk2/repository/chatrepository.dart';
import 'package:ctlk2/repository/userrepository.dart';
import 'package:ctlk2/services/firebase_storage_service.dart';
import 'package:ctlk2/services/firebaseauthservice.dart';
import 'package:ctlk2/services/firestore_db_service.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => FirebaseAuthService());
  locator.registerLazySingleton(() => UserRepository());
  locator.registerLazySingleton(() => ChatRepository());
  locator.registerLazySingleton(() => FireStoreDBService());
  locator.registerLazySingleton(() => FirebaseStorageService());
}
