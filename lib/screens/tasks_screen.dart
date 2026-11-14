import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import '../widgets/segrup_widgets.dart';
import '../models/app_role_state.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({super.key});

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  // Filter untuk Manager Proyek: 'Menunggu', 'Revisi', 'Disetujui'
  String _managerFilter = 'Menunggu';

  // Task yang sedang dibuka detail validasinya (null jika sedang di halaman list)
  Map<String, dynamic>? _selectedValidationTask;

  // Filter untuk Anggota Biasa
  bool _isTeamTabAnggota = false;
  String _selectedFilterAnggota = 'ALL';
  final List<String> _filtersAnggota = [
    'ALL',
    'DONE',
    'IN PROGRESS',
    'REVISI',
    'TO DO',
  ];

  // Data Validasi Manager Proyek (Sesuai Gambar 1 & Gambar 2)
  final List<Map<String, dynamic>> _validationTasks = [
    {
      'id': 'val_1',
      'category': 'DESAIN UI/UX',
      'badgeText': 'Revisi ke-2',
      'badgeBg': Color(0xFFF3F0FF),
      'badgeFg': Color(0xFF4F46E5),
      'title': 'Perbaikan UI registrasi',
      'projectName': 'Smart Reading Tracker • Desain UI/UX',
      'memberName': 'Nadia Putri',
      'memberRole': 'Anggota • UI/UX Designer',
      'submittedTime': 'Dikirim 13 Nov 2026, 09.40',
      'deadline': 'Tenggat: 13 Nov 2026',
      'memberNote':
          'Kontras button sekunder sudah diperbarui. Mohon ditinjau kembali.',
      'filesSummary': '1 tautan Figma • 1 PDF',
      'attachments': [
        {
          'type': 'FIG',
          'title': 'SeGrup Mobile System V2',
          'action': 'Buka Figma ↗',
        },
        {
          'type': 'PDF',
          'title': 'Catatan_Review_UI.pdf',
          'action': 'Lihat PDF ↗',
        },
      ],
      'previousAuthor': 'Dimas Arya • Manager proyek',
      'previousNote': '“Secara alur sudah rapi, tapi kontras warna pada button sekunder di layar registrasi perlu disesuaikan dengan standar WCAG AA. Lampirkan screenshot Figma yang sudah diperbarui.”',
      'status': 'Menunggu',
    },
    {
      'id': 'val_2',
      'category': 'DESAIN UI/UX',
      'badgeText': 'Terlambat',
      'badgeBg': Color(0xFFFFE4E6),
      'badgeFg': Color(0xFFE11D48),
      'title': 'Diagram sequence autentikasi',
      'projectName': 'Smart Reading Tracker • Desain UI/UX',
      'memberName': 'Rizky Pratama',
      'memberRole': 'Anggota • Backend Developer',
      'submittedTime': 'Dikirim 13 Nov 2026, 08.15',
      'deadline': 'Tenggat: 11 Nov 2026',
      'memberNote': 'Diagram JWT dan alur token expired sudah dilengkapi.',
      'filesSummary': '1 PDF • 1 DOCX',
      'attachments': [
        {
          'type': 'PDF',
          'title': 'Sequence_Diagram_Auth_V2.pdf',
          'action': 'Lihat PDF ↗',
        },
        {
          'type': 'DOC',
          'title': 'Spesifikasi_Token_Auth.docx',
          'action': 'Lihat Dokumen ↗',
        },
      ],
      'previousAuthor': 'Adinda • Manager proyek',
      'previousNote':
          '“Tambahkan fallback handling bila refresh token kadaluarsa.”',
      'status': 'Menunggu',
    },
    {
      'id': 'val_3',
      'category': 'DESAIN UI/UX',
      'badgeText': 'Kiriman pertama',
      'badgeBg': Color(0xFFF3F0FF),
      'badgeFg': Color(0xFF4F46E5),
      'title': 'Pengujian alur login',
      'projectName': 'Smart Reading Tracker • Desain UI/UX',
      'memberName': 'Alya Rahma',
      'memberRole': 'Anggota • QA Engineer',
      'submittedTime': 'Dikirim 12 Nov 2026, 16.20',
      'deadline': 'Tenggat: 13 Nov 2026',
      'memberNote':
          'Hasil pengujian dan bukti tiap skenario sudah dilampirkan.',
      'filesSummary': '1 PDF • 1 ZIP',
      'attachments': [
        {
          'type': 'PDF',
          'title': 'Test_Execution_Report_Login.pdf',
          'action': 'Lihat PDF ↗',
        },
        {
          'type': 'ZIP',
          'title': 'Screenshots_Scenario_Auth.zip',
          'action': 'Unduh ZIP ↗',
        },
      ],
      'previousAuthor': null,
      'previousNote': null,
      'status': 'Menunggu',
    },
  ];

  // Data Tugas Tim (Untuk Anggota Biasa)
  final List<Map<String, dynamic>> _teamTasks = [
    {
      'title': 'Proyek Akhir Web',
      'pj': 'Budiman',
      'deadline': '11 November 2026',
      'status': 'DONE',
    },
    {
      'title': 'Riset Kecerdasan Buatan',
      'pj': 'Yosua',
      'deadline': '11 November 2026',
      'status': 'IN PROGRESS',
    },
    {
      'title': 'Studi Kasus UI/UX Kel. B',
      'pj': 'Rizky Pratama',
      'deadline': '11 November 2026',
      'status': 'TO DO',
    },
    {
      'title': 'Dokumentasi Arsitektur Database',
      'pj': 'Siti Aisyah',
      'deadline': '14 November 2026',
      'status': 'IN PROGRESS',
    },
    {
      'title': 'Implementasi API Gateway',
      'pj': 'Dimas Saputra',
      'deadline': '15 November 2026',
      'status': 'TO DO',
    },
    {
      'title': 'Desain Wireframe & Mockup',
      'pj': 'Rizky Pratama',
      'deadline': '11 November 2026',
      'status': 'REVISI',
    },
  ];

  final TextEditingController _reviewNoteController = TextEditingController();
  final TextEditingController _newTaskTitleController = TextEditingController();
  final TextEditingController _newTaskDescriptionController =
      TextEditingController();

  @override
  void dispose() {
    _reviewNoteController.dispose();
    _newTaskTitleController.dispose();
    _newTaskDescriptionController.dispose();
    super.dispose();
  }

  Future<void> _showNewTaskDialog() async {
    _newTaskTitleController.clear();
    _newTaskDescriptionController.clear();
    final formKey = GlobalKey<FormState>();
    final currentUser = AppRoleState.instance.currentUser;
    final assignees = <String>{
      currentUser.name,
      ..._teamTasks.map((task) => task['pj'] as String),
    }.toList();
    DateTime? deadline;
    String? selectedAssignee;
    var selectedPriority = 'Sedang';
    const priorities = ['Rendah', 'Sedang', 'Tinggi'];
    const inputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(12)),
      borderSide: BorderSide(color: AppColors.border),
    );

    final task = await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (dialogContext) => Dialog(
        insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        backgroundColor: Colors.transparent,
        child: StatefulBuilder(
          builder: (context, setDialogState) => Container(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.sizeOf(context).height * 0.84,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 20, 16, 8),
                  child: Row(
                    children: [
                      const Expanded(
                        child: Text(
                          'Tambah tugas proyek',
                          style: TextStyle(
                            fontSize: 21,
                            fontWeight: FontWeight.w700,
                            color: AppColors.teksUtama,
                          ),
                        ),
                      ),
                      IconButton(
                        tooltip: 'Tutup',
                        onPressed: () => Navigator.pop(dialogContext),
                        icon: const Icon(
                          Icons.close,
                          color: AppColors.teksSekunder,
                        ),
                      ),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Atur detail tugas untuk tim proyekmu.',
                      style: TextStyle(
                        fontSize: 13,
                        color: AppColors.teksSekunder,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Form(
                    key: formKey,
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.fromLTRB(24, 18, 24, 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(14),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF3F0FF),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'PROYEK',
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.teksSekunder,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  'Smart Reading Tracker',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.unguUtama,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 18),
                          const Text(
                            'Nama tugas *',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: AppColors.teksUtama,
                            ),
                          ),
                          const SizedBox(height: 8),
                          TextFormField(
                            key: const ValueKey('new-task-title'),
                            controller: _newTaskTitleController,
                            autofocus: true,
                            decoration: const InputDecoration(
                              hintText: 'Masukkan nama tugas',
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 15,
                              ),
                              border: inputBorder,
                              enabledBorder: inputBorder,
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(12),
                                ),
                                borderSide: BorderSide(
                                  color: AppColors.unguUtama,
                                  width: 1.5,
                                ),
                              ),
                            ),
                            validator: (value) =>
                                value == null || value.trim().isEmpty
                                ? 'Nama tugas wajib diisi.'
                                : null,
                          ),
                          const SizedBox(height: 18),
                          const Text(
                            'Deskripsi (opsional)',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: AppColors.teksUtama,
                            ),
                          ),
                          const SizedBox(height: 8),
                          TextFormField(
                            controller: _newTaskDescriptionController,
                            minLines: 3,
                            maxLines: 3,
                            decoration: const InputDecoration(
                              hintText:
                                  'Tuliskan detail atau instruksi tugas...',
                              contentPadding: EdgeInsets.all(16),
                              border: inputBorder,
                              enabledBorder: inputBorder,
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(12),
                                ),
                                borderSide: BorderSide(
                                  color: AppColors.unguUtama,
                                  width: 1.5,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 18),
                          const Text(
                            'Tenggat *',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: AppColors.teksUtama,
                            ),
                          ),
                          const SizedBox(height: 8),
                          FormField<DateTime>(
                            validator: (value) =>
                                value == null ? 'Tenggat wajib dipilih.' : null,
                            builder: (field) => InkWell(
                              borderRadius: BorderRadius.circular(12),
                              onTap: () async {
                                final today = DateUtils.dateOnly(
                                  DateTime.now(),
                                );
                                final pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: today.add(
                                    const Duration(days: 7),
                                  ),
                                  firstDate: today,
                                  lastDate: DateTime(2100),
                                );
                                if (pickedDate != null) {
                                  deadline = pickedDate;
                                  field.didChange(pickedDate);
                                }
                              },
                              child: InputDecorator(
                                decoration: InputDecoration(
                                  hintText: 'Pilih tanggal',
                                  errorText: field.errorText,
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 15,
                                  ),
                                  border: inputBorder,
                                  enabledBorder: inputBorder,
                                  focusedBorder: inputBorder,
                                ),
                                child: Text(
                                  field.value == null
                                      ? 'Pilih tanggal'
                                      : _formatTaskDeadline(field.value!),
                                  style: TextStyle(
                                    color: field.value == null
                                        ? AppColors.teksSekunder
                                        : AppColors.teksUtama,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 18),
                          const Text(
                            'Penanggung jawab',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: AppColors.teksUtama,
                            ),
                          ),
                          const SizedBox(height: 8),
                          DropdownButtonFormField<String>(
                            initialValue: selectedAssignee,
                            isExpanded: true,
                            hint: const Text('Pilih Anggota Tim'),
                            decoration: const InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 14,
                              ),
                              border: inputBorder,
                              enabledBorder: inputBorder,
                              focusedBorder: inputBorder,
                            ),
                            items: assignees
                                .map(
                                  (name) => DropdownMenuItem(
                                    value: name,
                                    child: Text(name),
                                  ),
                                )
                                .toList(),
                            onChanged: (value) =>
                                setDialogState(() => selectedAssignee = value),
                          ),
                          const SizedBox(height: 18),
                          const Text(
                            'Prioritas',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: AppColors.teksUtama,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: priorities.map((priority) {
                              final isSelected = selectedPriority == priority;
                              return Expanded(
                                child: Padding(
                                  padding: EdgeInsets.only(
                                    right: priority == priorities.last ? 0 : 8,
                                  ),
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(10),
                                    onTap: () => setDialogState(
                                      () => selectedPriority = priority,
                                    ),
                                    child: Container(
                                      height: 44,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: isSelected
                                            ? const Color(0xFFF3F0FF)
                                            : Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                          color: isSelected
                                              ? AppColors.unguUtama
                                              : AppColors.border,
                                        ),
                                      ),
                                      child: Text(
                                        priority,
                                        style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: isSelected
                                              ? FontWeight.w600
                                              : FontWeight.w400,
                                          color: isSelected
                                              ? AppColors.unguUtama
                                              : AppColors.teksSekunder,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const Divider(height: 1, color: AppColors.border),
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 16, 24, 20),
                  child: Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () => Navigator.pop(dialogContext),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: AppColors.teksSekunder,
                            minimumSize: const Size.fromHeight(48),
                            shape: const StadiumBorder(),
                            side: const BorderSide(color: AppColors.border),
                          ),
                          child: const Text('Batal'),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        flex: 2,
                        child: ElevatedButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              Navigator.pop(dialogContext, {
                                'title': _newTaskTitleController.text.trim(),
                                'description': _newTaskDescriptionController
                                    .text
                                    .trim(),
                                'deadline': deadline!,
                                'assignee':
                                    selectedAssignee ?? currentUser.name,
                                'priority': selectedPriority,
                              });
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.unguUtama,
                            foregroundColor: Colors.white,
                            minimumSize: const Size.fromHeight(48),
                            shape: const StadiumBorder(),
                          ),
                          child: const Text('+ Tambah tugas'),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );

    if (task == null || !mounted) return;

    setState(() {
      _teamTasks.insert(0, {
        'title': task['title'],
        'description': task['description'],
        'pj': task['assignee'],
        'deadline': _formatTaskDeadline(task['deadline'] as DateTime),
        'priority': task['priority'],
        'status': 'TO DO',
      });
      _isTeamTabAnggota = true;
      _selectedFilterAnggota = 'ALL';
    });
  }

  String _formatTaskDeadline(DateTime date) {
    const months = [
      'Januari',
      'Februari',
      'Maret',
      'April',
      'Mei',
      'Juni',
      'Juli',
      'Agustus',
      'September',
      'Oktober',
      'November',
      'Desember',
    ];
    return '${date.day} ${months[date.month - 1]} ${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: AppRoleState.instance,
      builder: (context, _) {
        final isManager = AppRoleState.instance.isManager;

        // Jika POV Manager Proyek, tampilkan tampilan validasi (Gambar 1 & Gambar 2)
        if (isManager) {
          if (_selectedValidationTask != null) {
            return _buildDetailValidasiScreen(_selectedValidationTask!);
          }
          return _buildValidasiHasilKerjaScreen();
        }

        // Jika POV Anggota Biasa, tampilkan tampilan pengerjaan tugas anggota
        return _buildAnggotaTasksScreen();
      },
    );
  }

  // ===========================================================================
  // 1. TAMPILAN MANAGER PROYEK: DAFTAR VALIDASI (GAMBAR 1)
  // ===========================================================================
  Widget _buildValidasiHasilKerjaScreen() {
    final waitingCount = _validationTasks
        .where((t) => t['status'] == 'Menunggu')
        .length;
    final revisionCount = 2; // Sesuai desain Gambar 1: Revisi (2)
    final approvedCount = 7; // Sesuai desain Gambar 1: Disetujui (7)

    final filteredList = _validationTasks.where((task) {
      if (_managerFilter == 'Menunggu') return task['status'] == 'Menunggu';
      if (_managerFilter == 'Revisi') return task['status'] == 'Revisi';
      if (_managerFilter == 'Disetujui') return task['status'] == 'Disetujui';
      return true;
    }).toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF9F9FB),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 90),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Badge MANAGER PROYEK
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xFFF3F0FF),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text(
                'MANAGER PROYEK',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                  color: AppColors.unguUtama,
                  letterSpacing: 0.6,
                ),
              ),
            ),
            const SizedBox(height: 10),

            // Judul & Subjudul
            const Text(
              'Validasi hasil kerja',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w800,
                color: AppColors.teksUtama,
                letterSpacing: -0.5,
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              'Tinjau hasil anggota sebelum tugas dinyatakan selesai.',
              style: TextStyle(fontSize: 13, color: AppColors.teksSekunder),
            ),
            const SizedBox(height: 18),

            // Kartu PROYEK AKTIF (Smart Reading Tracker)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.unguUtama, // 0xFF3121B1
                borderRadius: BorderRadius.circular(18),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x223121B1),
                    blurRadius: 16,
                    offset: Offset(0, 6),
                  ),
                ],
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'PROYEK AKTIF',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFFC7D2FE),
                      letterSpacing: 0.8,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Smart Reading Tracker',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Desain UI/UX • 5 anggota',
                    style: TextStyle(fontSize: 12.5, color: Color(0xFFDDD6FE)),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Tab Filter: Menunggu (3), Revisi (2), Disetujui (7)
            Row(
              children: [
                _buildManagerFilterChip('Menunggu ($waitingCount)', 'Menunggu'),
                const SizedBox(width: 8),
                _buildManagerFilterChip('Revisi ($revisionCount)', 'Revisi'),
                const SizedBox(width: 8),
                _buildManagerFilterChip(
                  'Disetujui ($approvedCount)',
                  'Disetujui',
                ),
              ],
            ),
            const SizedBox(height: 22),

            // Header Daftar: Perlu ditinjau | Terbaru lebih dulu
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Perlu ditinjau',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: AppColors.teksUtama,
                  ),
                ),
                Text(
                  'Terbaru lebih dulu',
                  style: TextStyle(fontSize: 12, color: AppColors.teksSekunder),
                ),
              ],
            ),
            const SizedBox(height: 14),

            // Daftar Kartu Tugas yang Perlu Ditinjau
            if (filteredList.isEmpty)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(28),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.garisLembut),
                ),
                child: const Column(
                  children: [
                    Icon(
                      Icons.check_circle_outline_rounded,
                      color: AppColors.hijau,
                      size: 40,
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Tidak ada tugas di status ini.',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: AppColors.teksSekunder,
                      ),
                    ),
                  ],
                ),
              )
            else
              ...filteredList.map((task) => _buildValidationTaskCard(task)),
          ],
        ),
      ),
    );
  }

  Widget _buildManagerFilterChip(String label, String value) {
    final bool isSelected = _managerFilter == value;

    return Expanded(
      child: InkWell(
        onTap: () => setState(() => _managerFilter = value),
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isSelected ? AppColors.unguUtama : Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected ? AppColors.unguUtama : AppColors.garisLembut,
            ),
          ),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: isSelected ? Colors.white : AppColors.teksSekunder,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildValidationTaskCard(Map<String, dynamic> task) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.garisLembut),
        boxShadow: const [
          BoxShadow(
            color: Color(0x060F172A),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Kartu: Kategori & Status Badge
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                task['category'] as String,
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                  color: AppColors.unguUtama,
                  letterSpacing: 0.5,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: task['badgeBg'] as Color,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  task['badgeText'] as String,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: task['badgeFg'] as Color,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),

          // Judul Tugas
          Text(
            task['title'] as String,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: AppColors.teksUtama,
            ),
          ),
          const SizedBox(height: 6),

          // Nama Anggota
          Text(
            task['memberName'] as String,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: AppColors.teksUtama,
            ),
          ),
          const SizedBox(height: 2),

          // Waktu Pengiriman
          Text(
            task['submittedTime'] as String,
            style: const TextStyle(fontSize: 12, color: AppColors.teksSekunder),
          ),
          const SizedBox(height: 12),

          // Kotak Catatan / Feedback Anggota
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            decoration: BoxDecoration(
              color: const Color(0xFFF8F7FF),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              task['memberNote'] as String,
              style: const TextStyle(
                fontSize: 12,
                color: AppColors.teksUtama,
                height: 1.35,
              ),
            ),
          ),
          const SizedBox(height: 12),

          // Lampiran Berkas & Tenggat
          Text(
            task['filesSummary'] as String,
            style: const TextStyle(
              fontSize: 12.5,
              fontWeight: FontWeight.w700,
              color: AppColors.unguUtama,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            task['deadline'] as String,
            style: const TextStyle(fontSize: 12, color: AppColors.teksSekunder),
          ),
          const SizedBox(height: 16),

          // Tombol Tinjau Hasil
          SizedBox(
            width: double.infinity,
            height: 46,
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  _selectedValidationTask = task;
                  _reviewNoteController.clear();
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.unguUtama,
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Tinjau hasil',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // 2. TAMPILAN MANAGER PROYEK: DETAIL VALIDASI (GAMBAR 2)
  // ===========================================================================
  Widget _buildDetailValidasiScreen(Map<String, dynamic> task) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9FB),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 90),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Tombol < Kembali ke daftar validasi
            InkWell(
              onTap: () => setState(() => _selectedValidationTask = null),
              borderRadius: BorderRadius.circular(8),
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.chevron_left_rounded,
                      size: 20,
                      color: AppColors.unguUtama,
                    ),
                    SizedBox(width: 4),
                    Text(
                      'Kembali ke daftar validasi',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: AppColors.unguUtama,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),

            // Judul & Subjudul
            const Text(
              'Detail validasi',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w800,
                color: AppColors.teksUtama,
                letterSpacing: -0.5,
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              'Periksa hasil, lalu berikan keputusan.',
              style: TextStyle(fontSize: 13, color: AppColors.teksSekunder),
            ),
            const SizedBox(height: 18),

            // KARTU 1: Detail Tugas & Anggota
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: AppColors.garisLembut),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Badges: Menunggu validasi & Revisi ke-2
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFEEF2FF),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Text(
                          'Menunggu validasi',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF4F46E5),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFEDD5),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Text(
                          'Revisi ke-2',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFFEA580C),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // Judul & Subjudul Tugas
                  Text(
                    task['title'] as String,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w800,
                      color: AppColors.teksUtama,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    task['projectName'] as String,
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.teksSekunder,
                    ),
                  ),
                  const SizedBox(height: 14),

                  // Kotak Info Anggota
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF8F7FF),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          task['memberName'] as String,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: AppColors.teksUtama,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          task['memberRole'] as String,
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppColors.teksSekunder,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 14),

                  // Meta waktu
                  Text(
                    task['submittedTime'] as String,
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.teksSekunder,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    task['deadline'] as String,
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.teksSekunder,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // KARTU 2: Hasil yang dikirim
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: AppColors.garisLembut),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Hasil yang dikirim',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: AppColors.teksUtama,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'CATATAN ANGGOTA',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w800,
                      color: AppColors.unguUtama,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    task['memberNote'] as String,
                    style: const TextStyle(
                      fontSize: 13,
                      color: AppColors.teksUtama,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'LAMPIRAN • 2 BERKAS',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: AppColors.teksSekunder,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Lampiran 1: Figma
                  _buildAttachmentCard(
                    badge: 'FIG',
                    title: 'SeGrup Mobile System V2',
                    actionLabel: 'Buka Figma ↗',
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Membuka tautan Figma: SeGrup Mobile System V2',
                          ),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 10),

                  // Lampiran 2: PDF
                  _buildAttachmentCard(
                    badge: 'PDF',
                    title: 'Catatan_Review_UI.pdf',
                    actionLabel: 'Lihat PDF ↗',
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Membuka berkas Catatan_Review_UI.pdf'),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // KARTU 3: Catatan sebelumnya
            if (task['previousNote'] != null) ...[
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: AppColors.garisLembut),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Catatan sebelumnya',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: AppColors.teksUtama,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      task['previousAuthor'] as String? ?? 'Manager proyek',
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: AppColors.unguUtama,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF8F7FF),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        task['previousNote'] as String,
                        style: const TextStyle(
                          fontSize: 12.5,
                          color: AppColors.teksUtama,
                          height: 1.4,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
            ],

            // KARTU 4: Keputusan validasi
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: AppColors.garisLembut),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Keputusan validasi',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: AppColors.teksUtama,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Catatan untuk anggota',
                    style: TextStyle(
                      fontSize: 12.5,
                      fontWeight: FontWeight.w600,
                      color: AppColors.teksUtama,
                    ),
                  ),
                  const SizedBox(height: 8),

                  // TextField Catatan
                  TextField(
                    controller: _reviewNoteController,
                    maxLines: 4,
                    decoration: InputDecoration(
                      hintText: 'Tulis Catatan',
                      hintStyle: const TextStyle(
                        color: AppColors.teksRedup,
                        fontSize: 13,
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.all(14),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                          color: AppColors.garisLembut,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                          color: AppColors.garisLembut,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                          color: AppColors.unguUtama,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'Wajib diisi jika meminta revisi.',
                    style: TextStyle(
                      fontSize: 11.5,
                      color: AppColors.teksSekunder,
                    ),
                  ),
                  const SizedBox(height: 18),

                  // Dua Tombol Aksi: Minta revisi & Setujui hasil
                  Row(
                    children: [
                      // Tombol Minta revisi
                      Expanded(
                        child: SizedBox(
                          height: 48,
                          child: ElevatedButton(
                            onPressed: () {
                              if (_reviewNoteController.text.trim().isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      'Catatan wajib diisi jika meminta revisi!',
                                    ),
                                    backgroundColor: AppColors.merahError,
                                    behavior: SnackBarBehavior.floating,
                                  ),
                                );
                                return;
                              }

                              setState(() {
                                task['status'] = 'Revisi';
                                task['badgeText'] = 'Revisi';
                                task['badgeBg'] = const Color(0xFFFFEDD5);
                                task['badgeFg'] = const Color(0xFFEA580C);
                                task['previousNote'] =
                                    '“${_reviewNoteController.text.trim()}”';
                                task['previousAuthor'] =
                                    'Adinda • Manager proyek';
                                _selectedValidationTask = null;
                              });

                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'Catatan revisi berhasil dikirim ke ${task['memberName']}!',
                                  ),
                                  backgroundColor: AppColors.warningText,
                                  behavior: SnackBarBehavior.floating,
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFF3F0FF),
                              foregroundColor: AppColors.unguUtama,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: const Text(
                              'Minta revisi',
                              style: TextStyle(
                                fontSize: 13.5,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),

                      // Tombol Setujui hasil
                      Expanded(
                        child: SizedBox(
                          height: 48,
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                task['status'] = 'Disetujui';
                                task['badgeText'] = 'Selesai';
                                task['badgeBg'] = AppColors.successBg;
                                task['badgeFg'] = AppColors.successText;
                                _selectedValidationTask = null;
                              });

                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'Tugas "${task['title']}" disetujui dan dinyatakan selesai (DONE)!',
                                  ),
                                  backgroundColor: AppColors.successText,
                                  behavior: SnackBarBehavior.floating,
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.unguUtama,
                              foregroundColor: Colors.white,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: const Text(
                              'Setujui hasil',
                              style: TextStyle(
                                fontSize: 13.5,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAttachmentCard({
    required String badge,
    required String title,
    required String actionLabel,
    required VoidCallback onTap,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F7FF),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.garisLembut),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFFEDE9FE),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              badge,
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w800,
                color: AppColors.unguUtama,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: AppColors.teksUtama,
              ),
            ),
          ),
          InkWell(
            onTap: onTap,
            child: Text(
              actionLabel,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: AppColors.unguUtama,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // 3. TAMPILAN ANGGOTA BIASA (PENGERJAAN & PENGUNGGAHAN)
  // ===========================================================================
  Widget _buildAnggotaTasksScreen() {
    final filteredTeamTasks = _selectedFilterAnggota == 'ALL'
        ? _teamTasks
        : _teamTasks
              .where((t) => t['status'] == _selectedFilterAnggota)
              .toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF9F9FB),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 90),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Badge ANGGOTA
            Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xFFDCFCE7),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text(
                'ANGGOTA TIM',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF15803D),
                  letterSpacing: 0.6,
                ),
              ),
            ),

            // Top Segmented Switch: Tugas Kamu vs Tugas Tim
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: AppColors.garisLembut),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => _isTeamTabAnggota = false),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          color: !_isTeamTabAnggota
                              ? AppColors.unguUtama
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          'Tugas Kamu',
                          style: TextStyle(
                            color: !_isTeamTabAnggota
                                ? Colors.white
                                : AppColors.teksUtama,
                            fontWeight: FontWeight.w700,
                            fontSize: 13.5,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => _isTeamTabAnggota = true),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          color: _isTeamTabAnggota
                              ? AppColors.unguUtama
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          'Tugas Tim',
                          style: TextStyle(
                            color: _isTeamTabAnggota
                                ? Colors.white
                                : AppColors.teksUtama,
                            fontWeight: FontWeight.w700,
                            fontSize: 13.5,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),

            // Filter Pills
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: _filtersAnggota.map((filter) {
                  final active = _selectedFilterAnggota == filter;
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: ChoiceChip(
                      label: Text(filter),
                      selected: active,
                      showCheckmark: false,
                      selectedColor: AppColors.unguUtama,
                      backgroundColor: Colors.white,
                      labelStyle: TextStyle(
                        color: active ? Colors.white : AppColors.teksUtama,
                        fontWeight: FontWeight.w700,
                        fontSize: 11.5,
                      ),
                      shape: StadiumBorder(
                        side: BorderSide(
                          color: active
                              ? AppColors.unguUtama
                              : AppColors.garisLembut,
                        ),
                      ),
                      onSelected: (_) =>
                          setState(() => _selectedFilterAnggota = filter),
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 16),

            if (_isTeamTabAnggota)
              ...filteredTeamTasks.map(
                (task) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: _TeamTaskCardAnggota(
                    title: task['title']!,
                    pj: task['pj']!,
                    deadline: task['deadline']!,
                    status: task['status']!,
                  ),
                ),
              )
            else
              Column(
                children: [
                  if (_selectedFilterAnggota == 'ALL' ||
                      _selectedFilterAnggota == 'TO DO') ...[
                    _MyTaskToDoCard(
                      onUpload: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Laporan tugas berhasil dikirim ke Manager Proyek (Adinda) untuk divalidasi!',
                            ),
                            backgroundColor: AppColors.successText,
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 16),
                  ],
                  if (_selectedFilterAnggota == 'ALL' ||
                      _selectedFilterAnggota == 'REVISI') ...[
                    _MyTaskRevisionCard(
                      onUploadRevision: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Berkas revisi berhasil diunggah! Menunggu validasi ulang dari Adinda.',
                            ),
                            backgroundColor: AppColors.unguUtama,
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 16),
                  ],
                  if (_selectedFilterAnggota == 'ALL' ||
                      _selectedFilterAnggota == 'DONE')
                    const _MyTaskCompletedCard(),
                ],
              ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showNewTaskDialog,
        backgroundColor: AppColors.unguUtama,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.check_circle_outline_rounded, size: 20),
        label: const Text(
          'Tugas Baru',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}

// Widget Penunjang Tampilan Anggota
class _TeamTaskCardAnggota extends StatelessWidget {
  final String title;
  final String pj;
  final String deadline;
  final String status;

  const _TeamTaskCardAnggota({
    required this.title,
    required this.pj,
    required this.deadline,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    Color bg = AppColors.primarySoft;
    Color fg = AppColors.unguUtama;

    if (status == 'DONE') {
      bg = AppColors.successBg;
      fg = AppColors.successText;
    } else if (status == 'TO DO') {
      bg = AppColors.warningBg;
      fg = AppColors.warningText;
    } else if (status == 'REVISI') {
      bg = AppColors.dangerBg;
      fg = AppColors.dangerText;
    }

    return SectionCard(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Penanggung Jawab : $pj',
                  style: const TextStyle(
                    fontSize: 12.5,
                    color: AppColors.teksSekunder,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'Tenggat : $deadline',
                  style: const TextStyle(
                    fontSize: 12.5,
                    color: AppColors.teksSekunder,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: bg,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              status,
              style: TextStyle(
                color: fg,
                fontSize: 11,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MyTaskToDoCard extends StatelessWidget {
  final VoidCallback? onUpload;
  const _MyTaskToDoCard({this.onUpload});

  @override
  Widget build(BuildContext context) {
    return SectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'DESAIN UI/UX',
                style: TextStyle(
                  color: AppColors.unguUtama,
                  fontWeight: FontWeight.w800,
                  fontSize: 11.5,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFE4E6),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '● TO DO',
                      style: TextStyle(
                        color: Color(0xFFE11D48),
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          const Row(
            children: [
              Icon(
                Icons.access_time_rounded,
                size: 15,
                color: AppColors.teksSekunder,
              ),
              SizedBox(width: 6),
              Text(
                'Tenggat : 11 November 2026',
                style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w600),
              ),
            ],
          ),
          const SizedBox(height: 14),
          const Text(
            'LAPORAN PENGERJAAN',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: AppColors.teksSekunder,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: const Color(0xFFF8F7FF),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: const Color(0xFFEDE9FE)),
            ),
            child: Column(
              children: [
                const CircleAvatar(
                  backgroundColor: Color(0xFFEDE9FE),
                  child: Icon(
                    Icons.cloud_upload_outlined,
                    color: AppColors.unguUtama,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Ketuk untuk Mengunggah Berkas',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13.5),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Format PDF, DOCX, ZIP, atau Screenshot\n(Maks. 25MB)',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 11.5,
                    color: AppColors.teksSekunder,
                  ),
                ),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 7,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: const Color(0xFFEDE9FE)),
                  ),
                  child: const Text(
                    'Pilih Dari Penyimpanan HP',
                    style: TextStyle(
                      color: AppColors.unguUtama,
                      fontSize: 11.5,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'Link (Opsional)',
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12.5),
          ),
          const SizedBox(height: 6),
          const TextField(
            decoration: InputDecoration(
              hintText: 'Tempel tautan di sini (https://...)',
              hintStyle: TextStyle(color: AppColors.teksRedup, fontSize: 13),
              filled: true,
              fillColor: Colors.white,
              contentPadding: EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 12,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(12)),
                borderSide: BorderSide(color: AppColors.border),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(12)),
                borderSide: BorderSide(color: AppColors.border),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFF8F7FF),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.chat_bubble_outline_rounded,
                      size: 15,
                      color: AppColors.unguUtama,
                    ),
                    SizedBox(width: 6),
                    Text(
                      'Catatan (Opsional) :',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 6),
                Text(
                  '“Diagram sequence di Bab 3 halaman 24 masih belum sinkron dengan endpoint API autentikasi JWT. Harap perbaiki diagram sequence dan tambahkan fallback handling bila token expired sebelum validasi final.”',
                  style: TextStyle(
                    fontSize: 12,
                    fontStyle: FontStyle.italic,
                    color: AppColors.teksSekunder,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            height: 46,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.unguUtama,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              onPressed: onUpload ?? () {},
              icon: const Icon(Icons.upload_file_rounded, size: 18),
              label: const Text(
                'Unggah',
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MyTaskRevisionCard extends StatelessWidget {
  final VoidCallback? onUploadRevision;
  const _MyTaskRevisionCard({this.onUploadRevision});

  @override
  Widget build(BuildContext context) {
    return SectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'DESAIN UI/UX',
                style: TextStyle(
                  color: AppColors.unguUtama,
                  fontWeight: FontWeight.w800,
                  fontSize: 11.5,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFEDD5),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  'Revisi',
                  style: TextStyle(
                    color: Color(0xFFEA580C),
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Text(
            'LAPORAN PENGERJAAN',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: AppColors.teksSekunder,
            ),
          ),
          const SizedBox(height: 8),
          const _AnggotaAttachmentTile(
            iconBg: Color(0xFFEDE9FE),
            iconColor: AppColors.unguUtama,
            icon: Icons.design_services_rounded,
            title: 'Figma: Smart Reading Tracker',
            subtitle: 'figma.com/file/segrup-v2-main',
            trailingIcon: Icons.open_in_new_rounded,
          ),
          const SizedBox(height: 8),
          const _AnggotaAttachmentTile(
            iconBg: Color(0xFFFFE4E6),
            iconColor: Color(0xFFE11D48),
            icon: Icons.picture_as_pdf_rounded,
            title: 'Catatan_Review_UI.pdf',
            subtitle: '850 KB • Dianotasi 3 halaman',
            trailingIcon: Icons.download_rounded,
          ),
          const SizedBox(height: 14),

          // UPLOAD REVISI
          const Text(
            'UPLOAD REVISI',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: AppColors.teksSekunder,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: const Color(0xFFF8F7FF),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: const Color(0xFFEDE9FE)),
            ),
            child: Column(
              children: [
                const CircleAvatar(
                  backgroundColor: Color(0xFFEDE9FE),
                  child: Icon(
                    Icons.cloud_upload_outlined,
                    color: AppColors.unguUtama,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Ketuk untuk Mengunggah Berkas',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13.5),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Format PDF, DOCX, ZIP, atau Screenshot\n(Maks. 25MB)',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 11.5,
                    color: AppColors.teksSekunder,
                  ),
                ),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 7,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: const Color(0xFFEDE9FE)),
                  ),
                  child: const Text(
                    'Pilih Dari Penyimpanan HP',
                    style: TextStyle(
                      color: AppColors.unguUtama,
                      fontSize: 11.5,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),

          // Catatan dari Dimas Arya
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFF8F7FF),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.chat_bubble_outline_rounded,
                      size: 15,
                      color: AppColors.unguUtama,
                    ),
                    SizedBox(width: 6),
                    Text(
                      'Catatan dari Dimas Arya :',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 12,
                        color: AppColors.teksUtama,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 6),
                Text(
                  '“Secara alur sudah rapi, tapi kontras warna pada button sekunder di layar registrasi perlu disesuaikan dengan standar WCAG AA. Lampirkan screenshot Figma yang sudah diperbarui.”',
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.teksUtama,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            height: 46,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.unguUtama,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              onPressed: onUploadRevision ?? () {},
              icon: const Icon(Icons.send_rounded, size: 18),
              label: const Text(
                'Kirim Pembaruan Revisi',
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MyTaskCompletedCard extends StatelessWidget {
  const _MyTaskCompletedCard();

  @override
  Widget build(BuildContext context) {
    return SectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'DESAIN UI/UX',
                style: TextStyle(
                  color: AppColors.unguUtama,
                  fontWeight: FontWeight.w800,
                  fontSize: 11.5,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFDCFCE7),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.check_rounded,
                      size: 13,
                      color: Color(0xFF15803D),
                    ),
                    SizedBox(width: 4),
                    Text(
                      'Selesai',
                      style: TextStyle(
                        color: Color(0xFF15803D),
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          const Row(
            children: [
              Icon(
                Icons.access_time_rounded,
                size: 15,
                color: AppColors.teksSekunder,
              ),
              SizedBox(width: 6),
              Text(
                'Tenggat : 11 November 2026 • Selesai 100%',
                style: TextStyle(
                  fontSize: 12.5,
                  fontWeight: FontWeight.w600,
                  color: AppColors.teksSekunder,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Text(
            'LAPORAN PENGERJAAN',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: AppColors.teksSekunder,
            ),
          ),
          const SizedBox(height: 8),
          const _AnggotaAttachmentTile(
            iconBg: Color(0xFFEDE9FE),
            iconColor: AppColors.unguUtama,
            icon: Icons.design_services_rounded,
            title: 'Figma: Smart Reading Tracker',
            subtitle: 'figma.com/file/segrup-v2-main',
            trailingIcon: Icons.open_in_new_rounded,
          ),
          const SizedBox(height: 8),
          const _AnggotaAttachmentTile(
            iconBg: Color(0xFFFFE4E6),
            iconColor: Color(0xFFE11D48),
            icon: Icons.picture_as_pdf_rounded,
            title: 'Catatan_Review_UI.pdf',
            subtitle: '850 KB • Dianotasi 3 halaman',
            trailingIcon: Icons.download_rounded,
          ),
        ],
      ),
    );
  }
}

class _AnggotaAttachmentTile extends StatelessWidget {
  final Color iconBg;
  final Color iconColor;
  final IconData icon;
  final String title;
  final String subtitle;
  final IconData trailingIcon;

  const _AnggotaAttachmentTile({
    required this.iconBg,
    this.iconColor = Colors.white,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.trailingIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.inputFill,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: iconBg,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: iconColor, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 11.5,
                    color: AppColors.teksSekunder,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Icon(trailingIcon, size: 19, color: AppColors.teksSekunder),
        ],
      ),
    );
  }
}
