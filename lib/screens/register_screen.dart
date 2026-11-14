import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'main_navigation_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _inviteCodeController = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _agreeTerms = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _inviteCodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9FC),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        titleSpacing: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded, color: AppColors.teksUtama),
          onPressed: () => Navigator.pop(context),
        ),
        title: Row(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: AppColors.unguUtama,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.groups_rounded, color: Colors.white, size: 20),
            ),
            const SizedBox(width: 8),
            const Text(
              'SeGrup',
              style: TextStyle(
                color: AppColors.unguUtama,
                fontWeight: FontWeight.w800,
                fontSize: 18,
              ),
            ),
          ],
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(color: const Color(0xFFE5E7EB), height: 1),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        child: Column(
          children: [
            // KARTU 1: Data (Nama Lengkap & Email)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFE5E7EB)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Icon(Icons.badge_outlined, size: 20, color: AppColors.unguUtama),
                      SizedBox(width: 8),
                      Text(
                        'Data',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: AppColors.teksUtama),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Nama Lengkap (Wajib)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Nama Lengkap',
                        style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: AppColors.teksUtama),
                      ),
                      Text(
                        'Wajib',
                        style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: AppColors.unguUtama),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      hintText: 'Nama Lengkap',
                      hintStyle: const TextStyle(color: AppColors.teksRedup, fontSize: 13.5),
                      filled: true,
                      fillColor: const Color(0xFFF3F3FA),
                      prefixIcon: const Icon(Icons.person_outline_rounded, color: AppColors.teksSekunder, size: 20),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppColors.unguUtama, width: 1.5)),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Email
                  const Text(
                    'Email',
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: AppColors.teksUtama),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      hintText: 'email',
                      hintStyle: const TextStyle(color: AppColors.teksRedup, fontSize: 13.5),
                      filled: true,
                      fillColor: const Color(0xFFF3F3FA),
                      prefixIcon: const Icon(Icons.alternate_email_rounded, color: AppColors.teksSekunder, size: 20),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppColors.unguUtama, width: 1.5)),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // KARTU 2: Password (Kata Sandi Baru & Konfirmasi)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFE5E7EB)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Icon(Icons.lock_clock_outlined, size: 20, color: AppColors.unguUtama),
                      SizedBox(width: 8),
                      Text(
                        'Password',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: AppColors.teksUtama),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Kata Sandi Baru
                  const Text(
                    'Kata Sandi Baru',
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: AppColors.teksUtama),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _passwordController,
                    obscureText: _obscurePassword,
                    decoration: InputDecoration(
                      hintText: 'Minimal 8 karakter',
                      hintStyle: const TextStyle(color: AppColors.teksRedup, fontSize: 13.5),
                      filled: true,
                      fillColor: const Color(0xFFF3F3FA),
                      prefixIcon: const Icon(Icons.lock_outline_rounded, color: AppColors.teksSekunder, size: 20),
                      suffixIcon: IconButton(
                        icon: Icon(_obscurePassword ? Icons.visibility_outlined : Icons.visibility_off_outlined, color: AppColors.teksSekunder, size: 20),
                        onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                      ),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppColors.unguUtama, width: 1.5)),
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Indikator Kekuatan Sandi
                  const Text(
                    'Kekuatan Sandi: Belum diisi',
                    style: TextStyle(fontSize: 11, color: AppColors.teksSekunder),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Expanded(child: Container(height: 4, decoration: BoxDecoration(color: const Color(0xFFE0E7FF), borderRadius: BorderRadius.circular(2)))),
                      const SizedBox(width: 4),
                      Expanded(child: Container(height: 4, decoration: BoxDecoration(color: const Color(0xFFE0E7FF), borderRadius: BorderRadius.circular(2)))),
                      const SizedBox(width: 4),
                      Expanded(child: Container(height: 4, decoration: BoxDecoration(color: const Color(0xFFE0E7FF), borderRadius: BorderRadius.circular(2)))),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.info_outline_rounded, size: 14, color: AppColors.teksSekunder),
                      SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          'Gunakan kombinasi huruf, angka, dan simbol untuk keamanan maksimal',
                          style: TextStyle(fontSize: 11, color: AppColors.teksSekunder, height: 1.3),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Konfirmasi Kata Sandi
                  const Text(
                    'Konfirmasi Kata Sandi',
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: AppColors.teksUtama),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _confirmPasswordController,
                    obscureText: _obscureConfirmPassword,
                    decoration: InputDecoration(
                      hintText: 'Ulangi kata sandi Anda',
                      hintStyle: const TextStyle(color: AppColors.teksRedup, fontSize: 13.5),
                      filled: true,
                      fillColor: const Color(0xFFF3F3FA),
                      prefixIcon: const Icon(Icons.check_circle_outline_rounded, color: AppColors.teksSekunder, size: 20),
                      suffixIcon: IconButton(
                        icon: Icon(_obscureConfirmPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined, color: AppColors.teksSekunder, size: 20),
                        onPressed: () => setState(() => _obscureConfirmPassword = !_obscureConfirmPassword),
                      ),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppColors.unguUtama, width: 1.5)),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // KARTU 3: Kode Undangan Tim (Opsional)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: const Color(0xFFEEF2FF),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFC7D2FE)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Icon(Icons.group_add_outlined, size: 20, color: AppColors.unguUtama),
                      SizedBox(width: 8),
                      Text(
                        'Kode Undangan Tim (Opsional)',
                        style: TextStyle(fontSize: 14.5, fontWeight: FontWeight.w800, color: AppColors.teksUtama),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Dapat kode? Masukkan di sini agar langsung tergabung ke ruang kolaborasi.',
                    style: TextStyle(fontSize: 12, color: AppColors.teksSekunder, height: 1.35),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: _inviteCodeController,
                    decoration: InputDecoration(
                      hintText: 'SEGRUP-XXXX',
                      hintStyle: const TextStyle(color: AppColors.teksRedup, fontSize: 13.5, fontWeight: FontWeight.w600),
                      filled: true,
                      fillColor: Colors.white,
                      suffixIcon: const Icon(Icons.tag_rounded, color: Color(0xFF059669), size: 22),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFFC7D2FE))),
                      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFFC7D2FE))),
                      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppColors.unguUtama, width: 1.5)),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Checkbox Persetujuan Layanan
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 24,
                  height: 24,
                  child: Checkbox(
                    value: _agreeTerms,
                    activeColor: AppColors.unguUtama,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                    onChanged: (val) => setState(() => _agreeTerms = val ?? false),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: RichText(
                    text: const TextSpan(
                      text: 'Saya menyetujui ',
                      style: TextStyle(fontSize: 12.5, color: AppColors.teksUtama),
                      children: [
                        TextSpan(
                          text: 'Ketentuan Layanan',
                          style: TextStyle(color: AppColors.unguUtama, fontWeight: FontWeight.w700, decoration: TextDecoration.underline),
                        ),
                        TextSpan(text: ' & '),
                        TextSpan(
                          text: 'Kebijakan Privasi',
                          style: TextStyle(color: AppColors.unguUtama, fontWeight: FontWeight.w700, decoration: TextDecoration.underline),
                        ),
                        TextSpan(text: ' SeGrup.'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Tombol Daftar Akun Baru →
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const MainNavigationScreen()),
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
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Daftar Akun Baru',
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
                    ),
                    SizedBox(width: 8),
                    Icon(Icons.arrow_forward_rounded, size: 18),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 22),

            // Divider ATAU MASUK INSTAN
            Row(
              children: [
                const Expanded(child: Divider(color: Color(0xFFE5E7EB))),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    'ATAU MASUK INSTAN',
                    style: TextStyle(
                      fontSize: 10.5,
                      fontWeight: FontWeight.w700,
                      color: AppColors.teksRedup,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
                const Expanded(child: Divider(color: Color(0xFFE5E7EB))),
              ],
            ),
            const SizedBox(height: 16),

            // Tombol Daftar Cepat dengan Google
            SizedBox(
              width: double.infinity,
              height: 48,
              child: OutlinedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const MainNavigationScreen()),
                  );
                },
                style: OutlinedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: AppColors.teksUtama,
                  side: const BorderSide(color: Color(0xFFE5E7EB)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 22,
                      height: 22,
                      alignment: Alignment.center,
                      child: const Text(
                        'G',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w900,
                          color: Color(0xFF4285F4),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    const Text(
                      'Daftar Cepat dengan Google',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.teksUtama,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Footer: Sudah punya akun? Masuk di sini>
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Sudah punya akun? ',
                  style: TextStyle(fontSize: 13, color: AppColors.teksSekunder),
                ),
                InkWell(
                  onTap: () => Navigator.pop(context),
                  child: const Text(
                    'Masuk di sini>',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: AppColors.unguUtama,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
