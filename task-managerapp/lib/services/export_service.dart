import 'dart:io';

import 'package:csv/csv.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:share_plus/share_plus.dart';

import 'package:task_app/data/models/task.dart';



class ExportService {
  Future<File> exportTasksToCsv(List<Task> tasks) async {
    final rows = <List<dynamic>>[
      ['ID', 'Title', 'Description', 'Due date', 'Completed', 'Repeated'],
      ...tasks.map(
        (t) => [
          t.id,
          t.title,
          t.description,
          t.dueDate?.toIso8601String() ?? '',
          t.isCompleted,
          t.isRepeated,
        ],
      ),
    ];

    final csv = const ListToCsvConverter().convert(rows);
    final dir = await getTemporaryDirectory();
    final file = File('${dir.path}/tasks.csv');
    await file.writeAsString(csv);
    return file;
  }

  Future<File> exportTasksToPdf(List<Task> tasks) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (context) => pw.Table.fromTextArray(
          headers: ['ID', 'Title', 'Description', 'Due date', 'Completed', 'Repeated'],
          data: tasks
              .map(
                (t) => [
                  t.id,
                  t.title,
                  t.description,
                  t.dueDate?.toIso8601String() ?? '',
                  t.isCompleted,
                  t.isRepeated,
                ],
              )
              .toList(),
        ),
      ),
    );

    final dir = await getTemporaryDirectory();
    final file = File('${dir.path}/tasks.pdf');
    await file.writeAsBytes(await pdf.save());
    return file;
  }

  Future<void> shareFile(File file, {String? text}) async {
    await Share.shareXFiles(
      [XFile(file.path)],
      text: text,
    );
  }
}
