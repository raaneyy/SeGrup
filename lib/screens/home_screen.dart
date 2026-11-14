import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import '../models/app_role_state.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: AppRoleState.instance,
      builder: (context, _) {
        final roleState = AppRoleState.instance;
        final user = roleState.currentUser;
        final isPm = roleState.isManager;

        // Jika POV Manager Proyek (Adinda)
        if (isPm) {
          return _buildManagerHomeScreen(context, user);
        }

        // TAMPILAN ANGGOTA (Cheesy Esterani / Rizky Pratama - Sesuai Gambar 4)
        return _buildAnggotaHomeScreen(context, user);
      },
    );
  }

  // ===========================================================================
  // TAMPILAN HOME UNTUK ANGGOTA (SESUAI GAMBAR 4)
  // ===========================================================================
  Widget _buildAnggotaHomeScreen(BuildContext context, AppUser user) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9FC),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 90),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Banner Ungu: Halo, Cheesy Esterani! 🙌
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: AppColors.unguUtama,
                borderRadius: BorderRadius.circular(18),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x223121B1),
                    blurRadius: 14,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Halo, ${user.name}!🙌',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Project : Smart Reading Tracker - Visualisasi Membaca',
                    style: TextStyle(fontSize: 12, color: Color(0xFFDDD6FE)),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // 3. Kartu PROYEK AKTIF (Smart Reading Tracker & Donut Progress 68%)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: const Color(0xFFE5E7EB)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '📁 PROYEK AKTIF',
                    style: TextStyle(
                      fontSize: 10.5,
                      fontWeight: FontWeight.w800,
                      color: AppColors.teksSekunder,
                      letterSpacing: 0.6,
                    ),
                  ),
                  const SizedBox(height: 8),

                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Smart Reading\nTracker',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w800,
                                color: AppColors.teksUtama,
                                height: 1.2,
                              ),
                            ),
                            SizedBox(height: 6),
                            Text(
                              '📅 12 September 2026 - 10 Januari 2027',
                              style: TextStyle(
                                fontSize: 11.5,
                                color: AppColors.teksSekunder,
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Donut Chart 68% Selesai
                      SizedBox(
                        width: 68,
                        height: 68,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            const SizedBox(
                              width: 68,
                              height: 68,
                              child: CircularProgressIndicator(
                                value: 0.68,
                                strokeWidth: 6,
                                backgroundColor: Color(0xFFEEF2FF),
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  Color(0xFF0F2B5C),
                                ),
                              ),
                            ),
                            const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '68%',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w800,
                                    color: AppColors.teksUtama,
                                  ),
                                ),
                                Text(
                                  'Selesai',
                                  style: TextStyle(
                                    fontSize: 9,
                                    color: AppColors.teksSekunder,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),

                  // Linear Progress Bar
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: const LinearProgressIndicator(
                      value: 0.68,
                      minHeight: 6,
                      backgroundColor: Color(0xFFEDE9FE),
                      valueColor: AlwaysStoppedAnimation<Color>(
                        AppColors.unguUtama,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),

                  const Text(
                    'Fase 2: Perancangan',
                    style: TextStyle(
                      fontSize: 11.5,
                      color: AppColors.teksSekunder,
                    ),
                  ),
                  const SizedBox(height: 14),

                  // 4 Status Pills Grid: Done (14), In Progres (5), Review (3), To Do (2)
                  Row(
                    children: [
                      Expanded(
                        child: _buildMetricTile(
                          dotColor: const Color(0xFF0284C7),
                          label: 'Done',
                          count: '14',
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: _buildMetricTile(
                          dotColor: const Color(0xFFF59E0B),
                          label: 'In Progres',
                          count: '5',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: _buildMetricTile(
                          dotColor: const Color(0xFF4F46E5),
                          label: 'Review',
                          count: '3',
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: _buildMetricTile(
                          dotColor: const Color(0xFF9CA3AF),
                          label: 'To Do',
                          count: '2',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 22),

            // 4. Section: ⏰ Deadline & Lihat Semua
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Row(
                  children: [
                    Text('⏰', style: TextStyle(fontSize: 16)),
                    SizedBox(width: 6),
                    Text(
                      'Deadline',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        color: AppColors.teksUtama,
                      ),
                    ),
                  ],
                ),
                InkWell(
                  onTap: () {},
                  child: const Text(
                    'Lihat Semua',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: AppColors.unguUtama,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Item Deadline 1: Penyusunan Dokumen SRS & Arsitektur
            _buildDeadlineCard(
              title: 'Penyusunan Dokumen SRS & Arsitektur',
              assignee: 'Cheesy Esterani',
              deadline: '12 November 2026',
            ),
            const SizedBox(height: 10),

            // Item Deadline 2: Design UI/UX
            _buildDeadlineCard(
              title: 'Design UI/UX',
              assignee: 'Budi Pratama',
              deadline: '12 November 2026',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMetricTile({
    required Color dotColor,
    required String label,
    required String count,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFFF9FAFB),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 7,
                height: 7,
                decoration: BoxDecoration(
                  color: dotColor,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: AppColors.teksUtama,
                ),
              ),
            ],
          ),
          Text(
            count,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w800,
              color: AppColors.teksUtama,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDeadlineCard({
    required String title,
    required String assignee,
    required String deadline,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 14.5,
              fontWeight: FontWeight.w700,
              color: AppColors.teksUtama,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              CircleAvatar(
                radius: 10,
                backgroundColor: const Color(0xFF0284C7),
                child: Text(
                  assignee.isNotEmpty ? assignee[0] : 'B',
                  style: const TextStyle(
                    fontSize: 10,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 6),
              Text(
                'PIC: $assignee',
                style: const TextStyle(
                  fontSize: 12,
                  color: AppColors.teksSekunder,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            'Deadline : $deadline',
            style: const TextStyle(fontSize: 12, color: AppColors.teksSekunder),
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // TAMPILAN HOME UNTUK MANAGER PROYEK (ADINDA)
  // ===========================================================================
  Widget _buildManagerHomeScreen(BuildContext context, AppUser user) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9FC),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Greeting Manager Proyek
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: AppColors.unguUtama,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Halo, ${user.name}! 🎯',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Peran: Manager Proyek • 3 tugas anggota menunggu validasi Anda.',
                    style: TextStyle(fontSize: 12, color: Color(0xFFDDD6FE)),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),

            // Quick Stats
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: const Color(0xFFE5E7EB)),
                    ),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.fact_check_rounded,
                          color: AppColors.unguUtama,
                          size: 26,
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Menunggu Validasi',
                          style: TextStyle(
                            fontSize: 11.5,
                            color: AppColors.teksSekunder,
                          ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          '3 Tugas',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                            color: AppColors.teksUtama,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: const Color(0xFFE5E7EB)),
                    ),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.rate_review_outlined,
                          color: Color(0xFFEA580C),
                          size: 26,
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Dalam Revisi',
                          style: TextStyle(
                            fontSize: 11.5,
                            color: AppColors.teksSekunder,
                          ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          '2 Tugas',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                            color: AppColors.teksUtama,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Banner Aksi Cepat
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: const Color(0xFFF3F0FF),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: const Color(0xFFDDD6FE)),
              ),
              child: const Row(
                children: [
                  Icon(
                    Icons.info_outline_rounded,
                    color: AppColors.unguUtama,
                    size: 20,
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'Buka tab "Tugas" di menu navigasi bawah untuk meninjau hasil kiriman anggota dan memberikan keputusan validasi.',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.unguUtama,
                        height: 1.35,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
