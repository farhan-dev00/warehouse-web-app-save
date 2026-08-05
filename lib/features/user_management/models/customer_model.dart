/// Domain model for a single customer row.
class Customer {
  final String custId;
  final String custCode;
  final String custName;
  final String custContactNo;
  final String custEmail;
  final String custRemarks;
  final String custStatus; // Active / Inactive (adjust to your actual values)
  final String custCD; // Created Date
  final String custCB; // Created By
  final String roleCode; 

  const Customer({
    required this.custId,
    required this.custCode,
    required this.custName,
    required this.custContactNo,
    required this.custEmail,
    required this.custRemarks,
    required this.custStatus,
    required this.custCD,
    required this.custCB,
    required this.roleCode,
  });

  /// Initials derived from custName, for the avatar (SQL doesn't provide this).
  String get avatarInitials {
    final parts = custName.trim().split(RegExp(r'\s+'));
    if (parts.isEmpty || parts.first.isEmpty) return '?';
    if (parts.length == 1) return parts.first.substring(0, 1).toUpperCase();
    return (parts.first.substring(0, 1) + parts.last.substring(0, 1)).toUpperCase();
  }

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      custId: json['CustID'].toString(),
      custCode: json['CustCode'] ?? '',
      custName: json['CustName'] ?? '',
      custContactNo: json['CustContactNo'] ?? '',
      custEmail: json['CustEmail'] ?? '',
      custRemarks: json['CustRemarks'] ?? '',
      custStatus: json['CustStatus'] ?? '',
      custCD: json['CustCD']?.toString() ?? '',
      custCB: json['CustCB'] ?? '',
      roleCode: json['RoleCode'] ?? '',
    );
  }
}