class ModifyProfileInfo{
  final bool managerCheck;
  final String password;
  final String manager_code;
  final String new_password;
  final String phoneNumber;
  final int id;

  static String resultMsg = "";
  ModifyProfileInfo(
       this.managerCheck, this.password , this.new_password , this.phoneNumber  , this.id , this.manager_code,
      );
}