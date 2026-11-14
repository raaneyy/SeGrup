import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import '../widgets/segrup_widgets.dart';
import 'login_screen.dart';
import 'register_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _entranceController;
  late final Animation<double> _logoAnimation;
  late final Animation<double> _titleAnimation;
  late final Animation<double> _headlineAnimation;
  late final Animation<double> _descriptionAnimation;
  late final Animation<double> _loginButtonAnimation;
  late final Animation<double> _registerButtonAnimation;

  @override
  void initState() {
    super.initState();
    _entranceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    _logoAnimation = CurvedAnimation(
      parent: _entranceController,
      curve: const Interval(0, 0.42, curve: Curves.easeOutBack),
    );
    _titleAnimation = _entrance(0.12, 0.5);
    _headlineAnimation = _entrance(0.22, 0.62);
    _descriptionAnimation = _entrance(0.32, 0.72);
    _loginButtonAnimation = _entrance(0.48, 0.86);
    _registerButtonAnimation = _entrance(0.6, 1);
    _entranceController.forward();
  }

  Animation<double> _entrance(double begin, double end) {
    return CurvedAnimation(
      parent: _entranceController,
      curve: Interval(begin, end, curve: Curves.easeOutCubic),
    );
  }

  Widget _fadeAndSlide(Animation<double> animation, Widget child) {
    return FadeTransition(
      opacity: animation,
      child: SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0, 0.14),
          end: Offset.zero,
        ).animate(animation),
        child: child,
      ),
    );
  }

  @override
  void dispose() {
    _entranceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9FC),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(flex: 2),

              // Logo dengan Halo Lingkaran (Sesuai Gambar 1)
              ScaleTransition(
                scale: _logoAnimation,
                child: FadeTransition(
                  opacity: _logoAnimation,
                  child: const SeGrupLogo(size: 78, showHalo: true),
                ),
              ),
              const SizedBox(height: 28),

              // Judul Aplikasi
              _fadeAndSlide(
                _titleAnimation,
                const Text(
                  'SeGrup',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w800,
                    color: AppColors.unguUtama,
                    letterSpacing: -0.5,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Headline "Your Projects, Better Organized"
              _fadeAndSlide(
                _headlineAnimation,
                const Text(
                  'Your Projects, Better\nOrganized',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w800,
                    color: AppColors.teksUtama,
                    height: 1.25,
                  ),
                ),
              ),
              const SizedBox(height: 14),

              // Deskripsi
              _fadeAndSlide(
                _descriptionAnimation,
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    'Bagi tugas, pantau progres, dan wujudkan proyek hebat bersama kelompokmu.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 13.5,
                      color: AppColors.teksSekunder,
                      height: 1.45,
                    ),
                  ),
                ),
              ),

              const Spacer(flex: 3),

              // Tombol Masuk ke Akun (Solid Ungu)
              _fadeAndSlide(
                _loginButtonAnimation,
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginScreen(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.unguUtama,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: const Text(
                      'Masuk ke Akun',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),

              // Tombol Daftar Akun Baru (Outlined Putih)
              _fadeAndSlide(
                _registerButtonAnimation,
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const RegisterScreen(),
                        ),
                      );
                    },
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: AppColors.unguUtama,
                      side: const BorderSide(color: Color(0xFFE5E7EB)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: const Text(
                      'Daftar Akun Baru',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: AppColors.unguUtama,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
