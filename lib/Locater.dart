import 'package:get_it/get_it.dart';
import 'Screen/AcademicYear/ViewModel/CrudViewModel.dart';
import 'Service/FirebaseApi.dart';

GetIt academicLocator =GetIt.instance;
GetIt classLocator =GetIt.instance;

void setupLocator() {
 // academicLocator.registerLazySingleton(() => Api('AcademicYear'));
  academicLocator.registerLazySingleton(() => AcademicYearViewModel()) ;
  academicLocator.registerLazySingleton(() => Api('Class'));
}

