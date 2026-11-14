import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/segrup_widgets.dart';

// Import layar yang sudah ada
import 'home_screen.dart';
import 'tasks_screen.dart';
import 'kelola_anggota_screen.dart';
import 'profil_screen.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  // Default mulai dari Tab Home (Index 0) setelah login
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    // Array ini menampung keempat screen sesuai urutan tab bar
    final List<Widget> pages = [
      const HomeScreen(),
      const TasksScreen(),
      const KelolaAnggotaScreen(),
      const ProfilScreen(),
    ];

    return Scaffold(
      appBar: const SeGrupTopBar(),
      body: pages[_selectedIndex], // Menampilkan halaman sesuai tab aktif
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: AppColors.surface,
          border: Border(top: BorderSide(color: AppColors.border, width: 1)),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildNavItem(0, Icons.home_rounded, Icons.home_outlined, 'Home'),
                _buildNavItem(1, Icons.check_circle, Icons.check_circle_outline, 'Tugas'),
                _buildNavItem(2, Icons.groups_rounded, Icons.groups_outlined, 'Grup'),
                _buildNavItem(3, Icons.account_circle, Icons.account_circle_outlined, 'Profil'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(int index, IconData activeIcon, IconData inactiveIcon, String label) {
    final bool isSelected = _selectedIndex == index;

    return InkWell(
      onTap: () => setState(() => _selectedIndex = index),
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: isSelected ? const Color(0x1A3121B1) : Colors.transparent,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                isSelected ? activeIcon : inactiveIcon,
                color: isSelected ? AppColors.primary : AppColors.textMuted,
                size: 24,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                color: isSelected ? AppColors.primary : AppColors.textMuted,
              ),
            ),
          ],
        ),
      ),
    );
  }
}