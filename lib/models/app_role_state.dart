import 'package:flutter/material.dart';

enum UserRoleType {
  managerProyek,
  anggota,
}

class AppUser {
  final String id;
  final String name;
  final String roleTitle;
  final UserRoleType roleType;
  final String initials;
  final String avatarAsset;
  final Color avatarBgColor;
  final String email;
  final String groupName;

  const AppUser({
    required this.id,
    required this.name,
    required this.roleTitle,
    required this.roleType,
    required this.initials,
    required this.avatarAsset,
    required this.avatarBgColor,
    required this.email,
    this.groupName = 'Kelompok 4 - Rekayasa Perangkat Lunak',
  });
}

class AppRoleState extends ChangeNotifier {
  static final AppRoleState instance = AppRoleState._();
  AppRoleState._();

  static const AppUser managerProyekUser = AppUser(
    id: 'user_pm',
    name: 'Adinda',
    roleTitle: 'Manager Proyek',
    roleType: UserRoleType.managerProyek,
    initials: 'AN',
    avatarAsset: 'assets/images/profile.png',
    avatarBgColor: Color(0xFFEDE9FE),
    email: 'adinda.pm@segrup.ac.id',
  );

  static const AppUser anggotaUser = AppUser(
    id: 'user_member',
    name: 'Cheesy Esterani',
    roleTitle: 'Anggota',
    roleType: UserRoleType.anggota,
    initials: 'CE',
    avatarAsset: 'assets/images/profile.png',
    avatarBgColor: Color(0xFFE0E7FF),
    email: 'cheesy.esterani@segrup.ac.id',
  );

  // Default ke Manager Proyek
  AppUser _currentUser = managerProyekUser;

  AppUser get currentUser => _currentUser;
  UserRoleType get currentRole => _currentUser.roleType;

  bool get isManager => _currentUser.roleType == UserRoleType.managerProyek;
  bool get isAnggota => _currentUser.roleType == UserRoleType.anggota;

  void switchRole(UserRoleType roleType) {
    if (roleType == UserRoleType.managerProyek) {
      _currentUser = managerProyekUser;
    } else {
      _currentUser = anggotaUser;
    }
    notifyListeners();
  }

  void showRoleSwitcherModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 22),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Pilih Role',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF1F2937),
                          ),
                        ),
                      ],
                    ),
                    IconButton(
                      icon: const Icon(Icons.close, color: Color(0xFF9CA3AF), size: 20),
                      onPressed: () => Navigator.pop(ctx),
                    ),
                  ],
                ),
                const SizedBox(height: 18),
                _buildRoleOption(
                  context: ctx,
                  roleType: UserRoleType.managerProyek,
                  title: 'Manager Proyek (Adinda)',
                  subtitle: 'Wewenang: Validasi tugas, beri revisi, pantau progres anggota',
                  icon: Icons.verified_user_rounded,
                  iconBg: const Color(0xFFEDE9FE),
                  iconColor: const Color(0xFF3121B1),
                ),
                const SizedBox(height: 10),
                _buildRoleOption(
                  context: ctx,
                  roleType: UserRoleType.anggota,
                  title: 'Anggota (Cheesy Esterani)',
                  subtitle: 'Wewenang: Buat tugas, pantau progres anggota',
                  icon: Icons.shield_rounded,
                  iconBg: const Color(0xFFE0E7FF),
                  iconColor: const Color(0xFF4F46E5),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildRoleOption({
    required BuildContext context,
    required UserRoleType roleType,
    required String title,
    required String subtitle,
    required IconData icon,
    required Color iconBg,
    required Color iconColor,
  }) {
    final bool isSelected = _currentUser.roleType == roleType;

    return InkWell(
      onTap: () {
        switchRole(roleType);
        Navigator.pop(context);
      },
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFF3F0FF) : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? const Color(0xFF3121B1) : const Color(0xFFE5E7EB),
            width: isSelected ? 1.8 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: iconBg,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: iconColor, size: 24),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: isSelected ? const Color(0xFF3121B1) : const Color(0xFF1F2937),
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    subtitle,
                    style: const TextStyle(fontSize: 11.5, color: Color(0xFF6B7280), height: 1.25),
                  ),
                ],
              ),
            ),
            if (isSelected)
              const Icon(Icons.check_circle_rounded, color: Color(0xFF3121B1), size: 22)
            else
              const Icon(Icons.radio_button_unchecked_rounded, color: Color(0xFF9CA3AF), size: 20),
          ],
        ),
      ),
    );
  }
}

