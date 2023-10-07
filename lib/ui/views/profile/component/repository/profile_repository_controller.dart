import 'package:skybase/core/base/base_controller.dart';
import 'package:skybase/data/models/repo/repo.dart';
import 'package:skybase/data/repositories/auth/auth_repository.dart';
import 'package:skybase/data/sources/local/cached_key.dart';

class ProfileRepositoryController extends BaseController<Repo> {
  final AuthRepository repository;
  ProfileRepositoryController({required this.repository});

  @override
  void onInit() {
    getCache(() => getRepository());
    super.onInit();
  }

  @override
  void refreshPage() {
    getRepository();
    super.refreshPage();
  }

  @override
  String get cachedId => throw UnimplementedError();

  @override
  String get cachedKey => CachedKey.USER_REPOSITORY;

  void getRepository() async {
    showLoading();
    try {
      final response = await repository.getProfileRepository(username: 'nandakista');
      saveCacheAndFinish(list: response);
      dismissLoading();
    } catch (e) {
      dismissLoading();
      showError(e.toString());
    }
  }

}