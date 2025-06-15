import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/options/localization/l10n.dart';

class TaskCard extends StatelessWidget {
  final String title;
  final String description;
  final DateTime dueDate;

  const TaskCard({
    super.key,
    required this.title,
    required this.description,
    required this.dueDate,
  });

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat.yMd();
    final formattedDate = dateFormat.format(dueDate);

    return Card(
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 6),
            Text(description, overflow: TextOverflow.ellipsis),
            const SizedBox(height: 4),
            Text(S.of(context).dueFormattedDate(formattedDate)),
          ],
        ),
      ),
    );
  }
}
