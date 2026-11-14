import 'dart:async';
import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import '../widgets/segrup_widgets.dart';
import 'splash_screen.dart';

class LaunchScreen extends StatefulWidget {
  const LaunchScreen({super.key});

  @override
  State<LaunchScreen> createState() => _LaunchScreenState();
}

class _LaunchScreenState extends State<LaunchScreen>
    with TickerProviderStateMixin {
  // Controller untuk animasi masuk (entrance)
  late final AnimationController _entranceController;
  late final Animation<double> _logoScale;
  late final Animation<double> _logoFade;
  late final Animation<double> _titleFade;
  late final Animation<Offset> _titleSlide;
  late final Animation<double> _taglineFade;
  late final Animation<Offset> _taglineSlide;
  late final Animation<double> _progressAnimation;

  // Controller untuk efek denyut/napas lingkaran halo (pulsing halo rings)
  late final AnimationController _pulseController;
  late final Animation<double> _pulseWave1;
  late final Animation<double> _pulseWave2;

  // Controller untuk kilau cahaya pada teks "SeGrup" (shimmer sweep)
  late final AnimationController _shimmerController;

  Timer? _navigationTimer;
  bool _hasNavigated = false;

  @override
  void initState() {
    super.initState();

    // 1. Setup Animasi Masuk
    _entranceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    );

    _logoScale = CurvedAnimation(
      parent: _entranceController,
      curve: const Interval(0.0, 0.55, curve: Curves.easeOutBack),
    );

    _logoFade = CurvedAnimation(
      parent: _entranceController,
      curve: const Interval(0.0, 0.4, curve: Curves.easeIn),
    );

    _titleFade = CurvedAnimation(
      parent: _entranceController,
      curve: const Interval(0.25, 0.75, curve: Curves.easeOut),
    );

    _titleSlide = Tween<Offset>(
      begin: const Offset(0, 0.25),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _entranceController,
        curve: const Interval(0.25, 0.75, curve: Curves.easeOutCubic),
      ),
    );

    _taglineFade = CurvedAnimation(
      parent: _entranceController,
      curve: const Interval(0.45, 0.95, curve: Curves.easeOut),
    );

    _taglineSlide = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _entranceController,
        curve: const Interval(0.45, 0.95, curve: Curves.easeOutCubic),
      ),
    );

    _progressAnimation = CurvedAnimation(
      parent: _entranceController,
      curve: const Interval(0.2, 1.0, curve: Curves.easeInOut),
    );

    // 2. Setup Animasi Denyut Halo (Pulsing Halo Rings)
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    )..repeat();

    _pulseWave1 = CurvedAnimation(
      parent: _pulseController,
      curve: Curves.easeOutQuad,
    );

    _pulseWave2 = CurvedAnimation(
      parent: _pulseController,
      curve: const Interval(0.3, 1.0, curve: Curves.easeOutQuad),
    );

    // 3. Setup Shimmer Sweep Controller
    _shimmerController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    )..repeat();

    // Mulai animasi masuk
    _entranceController.forward();

    // Navigasi otomatis ke Splash Menu setelah animasi selesai (2.6 detik)
    _navigationTimer = Timer(const Duration(milliseconds: 2600), _goToSplashMenu);
  }

  void _goToSplashMenu() {
    if (_hasNavigated || !mounted) return;
    _hasNavigated = true;
    _navigationTimer?.cancel();

    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 700),
        pageBuilder: (context, animation, secondaryAnimation) =>
            const SplashScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _navigationTimer?.cancel();
    _entranceController.dispose();
    _pulseController.dispose();
    _shimmerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAF8FF),
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: _goToSplashMenu,
        child: SafeArea(
          child: Stack(
            children: [
              // Konten Utama di Tengah Layar
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 28),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Area Logo dengan Animasi Denyut Halo & Scale
                      SizedBox(
                        width: 220,
                        height: 220,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            // Efek Gelombang Halo 1
                            AnimatedBuilder(
                              animation: _pulseWave1,
                              builder: (context, child) {
                                final double scale = 0.85 + (_pulseWave1.value * 0.35);
                                final double opacity = (1.0 - _pulseWave1.value).clamp(0.0, 0.45);
                                return Transform.scale(
                                  scale: scale,
                                  child: Container(
                                    width: 190,
                                    height: 190,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: const Color(0xFFC7D2FE).withValues(alpha: opacity),
                                        width: 3.5,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),

                            // Efek Gelombang Halo 2
                            AnimatedBuilder(
                              animation: _pulseWave2,
                              builder: (context, child) {
                                final double scale = 0.8 + (_pulseWave2.value * 0.4);
                                final double opacity = (1.0 - _pulseWave2.value).clamp(0.0, 0.35);
                                return Transform.scale(
                                  scale: scale,
                                  child: Container(
                                    width: 160,
                                    height: 160,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: const Color(0xFF818CF8).withValues(alpha: opacity),
                                        width: 2.5,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),

                            // Logo Gambar Asli dengan Animasi Masuk (Scale & Fade)
                            ScaleTransition(
                              scale: _logoScale,
                              child: FadeTransition(
                                opacity: _logoFade,
                                child: const SeGrupLogo(
                                  size: 88,
                                  showHalo: true,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 26),

                      // Teks "SeGrup" dengan Efek Shimmer Kilau Berjalan
                      SlideTransition(
                        position: _titleSlide,
                        child: FadeTransition(
                          opacity: _titleFade,
                          child: AnimatedBuilder(
                            animation: _shimmerController,
                            builder: (context, child) {
                              return ShaderMask(
                                blendMode: BlendMode.srcIn,
                                shaderCallback: (bounds) {
                                  return LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    stops: [
                                      (_shimmerController.value - 0.3).clamp(0.0, 1.0),
                                      _shimmerController.value.clamp(0.0, 1.0),
                                      (_shimmerController.value + 0.3).clamp(0.0, 1.0),
                                    ],
                                    colors: const [
                                      AppColors.unguUtama,
                                      Color(0xFF818CF8),
                                      AppColors.unguUtama,
                                    ],
                                  ).createShader(bounds);
                                },
                                child: const Text(
                                  'SeGrup',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 35,
                                    fontWeight: FontWeight.w800,
                                    color: AppColors.unguUtama,
                                    letterSpacing: -0.5,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 18),

                      // Teks Tagline "Your Projects, Better Organized"
                      SlideTransition(
                        position: _taglineSlide,
                        child: FadeTransition(
                          opacity: _taglineFade,
                          child: const Text(
                            'Your Projects, Better\nOrganized',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 27,
                              fontWeight: FontWeight.w800,
                              color: Color(0xFF1E1B4B),
                              height: 1.25,
                              letterSpacing: -0.3,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Indikator Loading Bar Halus di Bagian Bawah
              Positioned(
                bottom: 40,
                left: 0,
                right: 0,
                child: Center(
                  child: FadeTransition(
                    opacity: _taglineFade,
                    child: SizedBox(
                      width: 52,
                      height: 4,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: AnimatedBuilder(
                          animation: _progressAnimation,
                          builder: (context, child) {
                            return LinearProgressIndicator(
                              value: _progressAnimation.value,
                              backgroundColor: const Color(0xFFE2E8F0),
                              valueColor: const AlwaysStoppedAnimation<Color>(
                                AppColors.unguUtama,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
