class ModifyAddressInfo{
  final String city;
  final String street;
  final String addressDetail;
  final String zipcode;
  final String token;

  static bool modifyAddressResult = false;

  ModifyAddressInfo(
      this.city, this.street, this.addressDetail, this.zipcode, this.token
      );
}