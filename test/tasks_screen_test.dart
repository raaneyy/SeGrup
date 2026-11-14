import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:segrup/models/app_role_state.dart';
import 'package:segrup/screens/tasks_screen.dart';

void main() {
  testWidgets('new task dialog opens and adds a task to the team list', (
    tester,
  ) async {
    final roleState = AppRoleState.instance;
    roleState.switchRole(UserRoleType.anggota);
    addTearDown(() => roleState.switchRole(UserRoleType.managerProyek));

    await tester.pumpWidget(const MaterialApp(home: TasksScreen()));

    await tester.tap(find.text('Tugas Baru'));
    await tester.pumpAndSettle();

    expect(find.text('Tambah tugas proyek'), findsOneWidget);
    expect(find.text('Deskripsi (opsional)'), findsOneWidget);
    expect(find.text('Penanggung jawab'), findsOneWidget);
    expect(find.text('Prioritas'), findsOneWidget);

    await tester.enterText(
      find.byKey(const ValueKey('new-task-title')),
      'Tugas Uji',
    );
    await tester.ensureVisible(find.text('Pilih tanggal').first);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Pilih tanggal').first);
    await tester.pumpAndSettle();
    await tester.tap(find.text('OK'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('+ Tambah tugas'));
    await tester.pumpAndSettle();

    expect(find.text('Tugas Uji'), findsOneWidget);
  });
}
