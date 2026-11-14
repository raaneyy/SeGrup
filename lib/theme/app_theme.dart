import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// 1. PALET WARNA (Sesuai Style Guide SeGrup)
class AppColors {
  // Brand & aksen
  static const Color unguUtama = Color(0xFF3121B1); // Primary SeGrup
  static const Color indigo = Color(0xFF4F46E5);
  static const Color merahKoral = Color(0xFFF43F5E);
  static const Color oranye = Color(0xFFF97316);
  static const Color hijauMint = Color(0xFF6EE7B7);
  static const Color biru = Color(0xFF0284C7);

  // Teks & garis
  static const Color teksGelap = Color(0xFF111827);
  static const Color teksUtama = Color(0xFF1F2937);
  static const Color abuGelap = Color(0xFF374151);
  static const Color teksSekunder = Color(0xFF6B7280);
  static const Color teksRedup = Color(0xFF9CA3AF);
  static const Color garisLembut = Color(0xFFE5E7EB);

  // Latar & permukaan
  static const Color putih = Color(0xFFFFFFFF);
  static const Color latarLavender = Color(0xFFF3F0FF);
  static const Color permukaanTerang = Color(0xFFF7F7FA); // Scaffold Background
  static const Color lavender = Color(0xFFEDE9FE);
  static const Color unguLembut = Color(0xFFDDD6FE);
  static const Color biruLembut = Color(0xFFE0E7FF);

  // Status & pendukung
  static const Color hijauGelap = Color(0xFF15803D);
  static const Color hijau = Color(0xFF22C55E);
  static const Color merahError = Color(0xFFDC2626);
  static const Color latarError = Color(0xFFFCE7F3);
  static const Color cokelat = Color(0xFF713F12);
  static const Color latarHangat = Color(0xFFFFEDD5);

  /// --------------------------------------------------------------------------
  /// Pemetaan (Mapping) Token Warna untuk Komponen UI Sebelumnya
  /// (Agar layar Tasks, Kelola Anggota, dan Profil tetap berfungsi tanpa error)
  /// --------------------------------------------------------------------------
  static const Color primary = unguUtama;
  static const Color primarySoft = lavender;
  static const Color background = permukaanTerang;
  static const Color surface = putih;
  static const Color inputFill = Color(0xFFF3F4F6); // Mendekati latar lavender/abu
  static const Color border = garisLembut;
  static const Color divider = Color(0xFFF3F4F6);
  
  static const Color textPrimary = teksUtama;
  static const Color textSecondary = teksSekunder;
  static const Color textMuted = teksRedup;

  static const Color successBg = Color(0xFFDCFCE7); // Turunan Hijau
  static const Color successText = hijauGelap;
  static const Color warningBg = latarHangat;
  static const Color warningText = Color(0xFFEA580C);
  static const Color dangerBg = latarError;
  static const Color dangerText = merahError;

  static const Color greenBadge = hijau;
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [unguUtama, indigo],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}

/// ============================================================================
/// 2. TIPOGRAFI (Plus Jakarta Sans & Inter)
/// ============================================================================
class AppTextStyles {
  /// --- PLUS JAKARTA SANS (Identitas dan Label Utama) ---
  
  static TextStyle pjsBold32 = GoogleFonts.plusJakartaSans(
    fontWeight: FontWeight.w700,
    fontSize: 32,
    height: 40 / 32, // Line height
  );

  static TextStyle pjsBold24 = GoogleFonts.plusJakartaSans(
    fontWeight: FontWeight.w700,
    fontSize: 24,
    height: 36 / 24,
  );

  static TextStyle pjsBold20 = GoogleFonts.plusJakartaSans(
    fontWeight: FontWeight.w700,
    fontSize: 20,
    height: 30 / 20,
  );

  static TextStyle pjsBold16 = GoogleFonts.plusJakartaSans(
    fontWeight: FontWeight.w700,
    fontSize: 16,
    height: 24 / 16,
  );

  static TextStyle pjsSemiBold15 = GoogleFonts.plusJakartaSans(
    fontWeight: FontWeight.w600,
    fontSize: 15,
    height: 22 / 15,
  );

  static TextStyle pjsSemiBold14 = GoogleFonts.plusJakartaSans(
    fontWeight: FontWeight.w600,
    fontSize: 14,
    height: 20 / 14,
  );

  static TextStyle pjsSemiBold12 = GoogleFonts.plusJakartaSans(
    fontWeight: FontWeight.w600,
    fontSize: 12,
    height: 18 / 12,
  );

  static TextStyle pjsBold10 = GoogleFonts.plusJakartaSans(
    fontWeight: FontWeight.w700,
    fontSize: 10,
    height: 14 / 10,
  );

  static TextStyle pjsRegular12 = GoogleFonts.plusJakartaSans(
    fontWeight: FontWeight.w400,
    fontSize: 12,
    height: 18 / 12,
  );

  /// --- INTER (Teks Pendukung dan Deskripsi) ---
  
  static TextStyle interSemiBold20 = GoogleFonts.inter(
    fontWeight: FontWeight.w600,
    fontSize: 20,
    height: 28 / 20,
  );

  static TextStyle interSemiBold14 = GoogleFonts.inter(
    fontWeight: FontWeight.w600,
    fontSize: 14,
    height: 20 / 14,
  );

  static TextStyle interRegular14 = GoogleFonts.inter(
    fontWeight: FontWeight.w400,
    fontSize: 14,
    height: 20 / 14,
  );

  static TextStyle interItalic14 = GoogleFonts.inter(
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.italic,
    fontSize: 14,
    height: 20 / 14,
  );

  static TextStyle interMedium12 = GoogleFonts.inter(
    fontWeight: FontWeight.w500,
    fontSize: 12,
    height: 18 / 12,
  );

  static TextStyle interBold12 = GoogleFonts.inter(
    fontWeight: FontWeight.w700,
    fontSize: 12,
    height: 18 / 12,
  );

  static TextStyle interRegular12 = GoogleFonts.inter(
    fontWeight: FontWeight.w400,
    fontSize: 12,
    height: 18 / 12,
  );

  static TextStyle interRegular11 = GoogleFonts.inter(
    fontWeight: FontWeight.w400,
    fontSize: 11,
    height: 17 / 11,
  );
}

/// ============================================================================
/// 3. TEMA APLIKASI (ThemeData)
/// ============================================================================
class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: AppColors.permukaanTerang,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.unguUtama,
        primary: AppColors.unguUtama,
        error: AppColors.merahError,
        surface: AppColors.putih,
      ),
      // Set Plus Jakarta Sans sebagai font bawaan jika tidak dideklarasikan spesifik
      textTheme: GoogleFonts.plusJakartaSansTextTheme().apply(
        bodyColor: AppColors.teksUtama,
        displayColor: AppColors.teksGelap,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.putih,
        foregroundColor: AppColors.teksGelap,
        elevation: 0,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.unguUtama,
          foregroundColor: AppColors.putih,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}