/// A billing/delivery party block — the name, multi-line address,
/// attention person, and telephone number shown under "Bill To" / "Deliver To".
class OutgoingPartyModel {
  final String name;
  final List<String> addressLines;
  final String attn;
  final String tel;

  const OutgoingPartyModel({
    required this.name,
    required this.addressLines,
    this.attn = '',
    required this.tel,
  });
}