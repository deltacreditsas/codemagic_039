abstract class PushRepository {
  Future<void> initialize();

  Future<String?> getToken();

  //Checking if there is a pending credit flag
  bool consumePendingCreditFlag();
}
