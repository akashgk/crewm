import 'package:flutter/material.dart';
import '../../../domain/entities/absence.dart';


class AbsenceFilter extends StatelessWidget {
  final AbsenceType? selectedType;
  final void Function(AbsenceType?) onChanged;

  const AbsenceFilter({
    super.key,
    required this.selectedType,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButton<AbsenceType?>(
      value: selectedType,
      hint: const Text('Filter by Type'),
      items: [
        const DropdownMenuItem(value: null, child: Text('All')),
        ...AbsenceType.values.map(
          (type) => DropdownMenuItem(
            value: type,
            child: Text(type.name[0].toUpperCase() + type.name.substring(1)),
          ),
        ),
      ],
      onChanged: onChanged,
    );
  }
}