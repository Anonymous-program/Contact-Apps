const String tblContact = 'tbl_contact';
const String tblContactColId = 'id';
const String tblContactColName = 'name';
const String tblContactColCompanyName = 'company_name';
const String tblContactColDesignation = 'designation';
const String tblContactColAddress = 'address';
const String tblContactColMobile = 'mobile';
const String tblContactColEmail = 'email';
const String tblContactColWebsite = 'website';
const String tblContactColFavorite = 'favorite';

class ContactModel {
  int? id;
  String name;
  String companyName;
  String designation;
  String address;
  String email;
  String mobile;
  String? image;
  String website;
  bool isFavorite;

  ContactModel(
      {this.id,
      this.name = '',
      this.companyName = '',
      this.designation = '',
      this.address = '',
      this.email = '',
      this.mobile = '',
      this.image,
      this.website = '',
      this.isFavorite = false});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      tblContactColName: name,
      tblContactColCompanyName: companyName,
      tblContactColDesignation: designation,
      tblContactColAddress: address,
      tblContactColMobile: mobile,
      tblContactColEmail: email,
      tblContactColWebsite: website,
      tblContactColFavorite: isFavorite ? 1 : 0,
    };
    if (id != null) {
      map[tblContactColId] = id;
    }
    return map;
  }

  factory ContactModel.fromMap(Map<String, dynamic> map) => ContactModel(
        id: map[tblContactColId],
        name: map[tblContactColName],
        companyName: map[tblContactColCompanyName],
        designation: map[tblContactColDesignation],
        address: map[tblContactColAddress],
        mobile: map[tblContactColMobile],
        email: map[tblContactColEmail],
        website: map[tblContactColWebsite],
        isFavorite: map[tblContactColFavorite] == 0 ? false : true,
      );
  @override
  String toString() {
    return 'ContactModel{id: $id, name: $name, companyName: $companyName, designation: $designation, address: $address, email: $email, mobile: $mobile, website: $website, isFavorite: $isFavorite}';
  }
}
