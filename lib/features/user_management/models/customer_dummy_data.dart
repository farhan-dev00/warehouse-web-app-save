import 'customer_model.dart';

/// Generates a realistic dummy list of ~30 customers.
class CustomerDummyData {
  CustomerDummyData._();

  static const _firstNames = [
    'John', 'Sarah', 'Michael', 'Aisha', 'David', 'Emily', 'Wei Ling', 'Ahmad',
    'Priya', 'James', 'Nur', 'Kevin', 'Chloe', 'Daniel', 'Farah', 'Ryan',
    'Grace', 'Hassan', 'Melissa', 'Kenji', 'Olivia', 'Suresh', 'Hannah',
    'Zul', 'Natalie', 'Arjun', 'Sophia', 'Ben', 'Yasmin', 'Marcus',
  ];
  static const _lastNames = [
    'Tan', 'Lee', 'Rahman', 'Kumar', 'Wong', 'Ibrahim', 'Chong', 'Fernandez',
    'Lim', 'Ong', 'Abdullah', 'Chan', 'Singh', 'Yap', 'Hassan', 'Goh',
  ];
  static const _remarks = [
    'Preferred customer, fast payment history.',
    'Requested bulk discount on next order.',
    'Follow up on outstanding invoice.',
    'Interested in premium package upgrade.',
    'Complained about delivery delay in Q1.',
    'VIP account, handle with priority.',
    'New sign-up, pending KYC verification.',
    'Requested change of contact details.',
    'Long-term client since onboarding.',
    'Referred by another customer.',
  ];
  static const _statuses = ['Active', 'Active', 'Active', 'Inactive', 'Active'];
  static const _createdBy = ['admin', 'jtan', 'slee', 'system', 'mrahman'];

  static List<Customer> generate({int count = 30}) {
    return List.generate(count, (i) {
      final first = _firstNames[i % _firstNames.length];
      final last = _lastNames[(i * 3) % _lastNames.length];
      final name = '$first $last';
      final status = _statuses[i % _statuses.length];
      final remark = _remarks[i % _remarks.length];
      final createdBy = _createdBy[i % _createdBy.length];
      final year = 2019 + (i % 6);
      final month = (i % 12) + 1;
      final day = (i % 27) + 1;

      // Simple local Malaysian-style mobile number pattern for demo purposes.
      final contactSuffix = ((10000000 + i * 137) % 100000000).toString().padLeft(8, '0');

      return Customer(
        custId: (1000 + i).toString(),
        custCode: 'CUST${(1000 + i).toString()}',
        custName: name,
        custContactNo: '01$contactSuffix', // '01' + 8 digits = 10 chars total
        custEmail: '${first.toLowerCase()}.${last.toLowerCase()}@example.com',
        custRemarks: remark,
        custStatus: status,
        custCD: '$year-${month.toString().padLeft(2, '0')}-${day.toString().padLeft(2, '0')}',
        custCB: createdBy, roleCode: '12',
      );
    });
  }
}