import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../models/app_role_state.dart';

class SeGrupLogo extends StatelessWidget {
  final double size;
  final bool showHalo;

  const SeGrupLogo({
    super.key,
    this.size = 76,
    this.showHalo = false,
  });

  @override
  Widget build(BuildContext context) {
    final coreLogo = Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: size,
          height: size,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            gradient: AppColors.primaryGradient,
          ),
          child: Icon(
            Icons.groups_rounded,
            color: Colors.white,
            size: size * 0.46,
          ),
        ),
        Positioned(
          right: -2,
          bottom: -2,
          child: Container(
            width: size * 0.34,
            height: size * 0.34,
            decoration: BoxDecoration(
              color: AppColors.greenBadge,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 2),
            ),
            child: Icon(
              Icons.bolt_rounded,
              color: Colors.white,
              size: size * 0.2,
            ),
          ),
        ),
      ],
    );

    if (!showHalo) return coreLogo;

    return Container(
      width: size * 2.1,
      height: size * 2.1,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Color(0xFFF1EFFE),
      ),
      alignment: Alignment.center,
      child: Container(
        width: size * 1.55,
        height: size * 1.55,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Color(0xFFE3DFFC),
        ),
        alignment: Alignment.center,
        child: coreLogo,
      ),
    );
  }
}

class SeGrupTopBar extends StatelessWidget implements PreferredSizeWidget {
  final int notificationCount;
  final VoidCallback? onNotificationTap;

  const SeGrupTopBar({
    super.key,
    this.notificationCount = 3,
    this.onNotificationTap,
  });

  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      titleSpacing: 16,
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'SeGrup',
            style: TextStyle(
              color: AppColors.primary,
              fontWeight: FontWeight.w800,
              fontSize: 20,
            ),
          ),
          const SizedBox(width: 8),
          ListenableBuilder(
            listenable: AppRoleState.instance,
            builder: (context, _) {
              final user = AppRoleState.instance.currentUser;
              final isPm = AppRoleState.instance.isManager;
              final Color badgeBg = isPm
                  ? const Color(0xFFEDE9FE)
                  : (AppRoleState.instance.isAnggota
                      ? const Color(0xFFDCFCE7)
                      : const Color(0xFFE0E7FF));
              final Color badgeFg = isPm
                  ? AppColors.primary
                  : (AppRoleState.instance.isAnggota
                      ? const Color(0xFF15803D)
                      : const Color(0xFF4F46E5));

              return InkWell(
                onTap: () => AppRoleState.instance.showRoleSwitcherModal(context),
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: badgeBg,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: badgeFg.withValues(alpha: 0.3), width: 1),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        isPm
                            ? Icons.verified_user_rounded
                            : (AppRoleState.instance.isAnggota
                                ? Icons.assignment_ind_rounded
                                : Icons.shield_rounded),
                        size: 12,
                        color: badgeFg,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        user.roleTitle,
                        style: TextStyle(
                          fontSize: 10.5,
                          fontWeight: FontWeight.w700,
                          color: badgeFg,
                        ),
                      ),
                      const SizedBox(width: 2),
                      Icon(
                        Icons.keyboard_arrow_down_rounded,
                        size: 13,
                        color: badgeFg,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
      actions: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            IconButton(
              onPressed: onNotificationTap ?? () {},
              icon: const Icon(
                Icons.notifications_none_rounded,
                color: AppColors.textPrimary,
                size: 26,
              ),
            ),
            if (notificationCount > 0)
              Positioned(
                right: 8,
                top: 8,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                    color: Color(0xFF991B1B),
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    '$notificationCount',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(width: 4),
        Padding(
          padding: const EdgeInsets.only(right: 16),
          child: InkWell(
            onTap: () => AppRoleState.instance.showRoleSwitcherModal(context),
            borderRadius: BorderRadius.circular(20),
            child: ListenableBuilder(
              listenable: AppRoleState.instance,
              builder: (context, _) {
                final user = AppRoleState.instance.currentUser;
                return Tooltip(
                  message: 'Ganti POV: ${user.name} (${user.roleTitle})',
                  child: CircleAvatar(
                    radius: 17,
                    backgroundColor: user.avatarBgColor,
                    backgroundImage: const AssetImage('assets/images/profile.png'),
                  ),
                );
              },
            ),
          ),
        ),
      ],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1),
        child: Container(color: AppColors.border, height: 1),
      ),
    );
  }
}

class SectionCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;

  const SectionCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(16),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: padding,
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
        boxShadow: const [
          BoxShadow(
            color: Color(0x080F172A),
            blurRadius: 12,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: child,
    );
  }
}