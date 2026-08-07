import 'package:flutter/material.dart';

/// Modal dialog shown when the user clicks "Assign Location" after
/// selecting one or more rows on the Transfer & Putaway page.
///
/// For now, pressing "Assign Location" just closes the dialog — wiring it
/// up to actually update the table rows will come later.
class AssignLocationDialog extends StatefulWidget {
  final List<String> partNos;

  const AssignLocationDialog({super.key, required this.partNos});

  @override
  State<AssignLocationDialog> createState() => _AssignLocationDialogState();
}

class _AssignLocationDialogState extends State<AssignLocationDialog> {
  static const Color _accent = Color(0xFFFDB553);

  final TextEditingController _locationController = TextEditingController();

  @override
  void dispose() {
    _locationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 420),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Assign Location',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 20),

              // ---------- Part No (read-only) ----------
              const Text(
                'Part No',
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 6),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  widget.partNos.join(', '),
                  style: TextStyle(fontSize: 13, color: Colors.grey.shade700),
                ),
              ),
              const SizedBox(height: 16),

              // ---------- Location (editable) ----------
              const Text(
                'Location',
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 6),
              TextField(
                controller: _locationController,
                decoration: InputDecoration(
                  hintText: 'Location here',
                  isDense: true,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 10,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                    borderSide: BorderSide(color: Colors.grey.shade400),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                    borderSide: const BorderSide(color: _accent),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // ---------- Action ----------
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    // TODO: apply the location to the selected Part Nos and
                    // reflect it in the table — behaviour to be defined.
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _accent,
                    foregroundColor: Colors.black87,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 28,
                      vertical: 14,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                  child: const Text(
                    'Assign Location',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}