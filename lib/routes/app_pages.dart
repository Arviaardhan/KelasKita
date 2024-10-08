import 'package:get/get.dart';
import 'package:kelas_kita/presentation/registration/biografi/form_biografi.dart';
import 'package:kelas_kita/presentation/screens/guru/scan_qr_absensi/qr_code.dart';
import 'package:kelas_kita/presentation/screens/guru/struktur_kelas_guru/struktur_kelas_view.dart';
import 'package:kelas_kita/presentation/screens/info_tugas/info_tugas.dart';
import 'package:kelas_kita/presentation/screens/lupa_password/input_email/input_email.dart';
import 'package:kelas_kita/presentation/screens/pending/pending_view.dart';
import 'package:kelas_kita/presentation/screens/qr_code_siswa/qr_code_siswa.dart';
import 'package:kelas_kita/presentation/screens/splashscreen/SplashScreen.dart';
import 'package:kelas_kita/presentation/screens/agenda/agenda_view.dart';
import 'package:kelas_kita/presentation/screens/home/home_view.dart';
import 'package:kelas_kita/presentation/screens/info_kelas/info_kelas_view.dart';
import 'package:kelas_kita/presentation/screens/jadwal/jadwal_view.dart';
import 'package:kelas_kita/presentation/screens/kas/kas_view.dart';
import 'package:kelas_kita/presentation/screens/onboarding/onboarding_view.dart';
import 'package:kelas_kita/presentation/screens/qr/qr_code.dart';
import 'package:kelas_kita/presentation/registration/login/login_view.dart';
import 'package:kelas_kita/presentation/screens/pembukuan/Pembukuan_view.dart';
import 'package:kelas_kita/presentation/screens/profile/profile_view.dart';
import 'package:kelas_kita/presentation/screens/notification/notif_page.dart';
import 'package:kelas_kita/presentation/screens/struktur_kelas/struktur_kelas_view.dart';
import 'package:kelas_kita/presentation/screens/qr_code_tunai/qr_code_tunai.dart';
import 'package:kelas_kita/presentation/screens/jadwal/jadwal_piket_view.dart';
import 'package:kelas_kita/routes/app_routes.dart';

import '../presentation/registration/register/register_view.dart';
import '../presentation/screens/guru/home_guru/home_guru_view.dart';

class AppPages {
  static const INITIAL = Route.SPLASHSCREEN_PAGE;
  static const ONBOARDING = Route.ONBOARDINGVIEW_PAGE;
  static const LOGIN = Route.LOGINVIEW_PAGE;
  static const INPUTEMAIL = Route.INPUTEMAILVIEW_PAGE;
  static const REGISTER = Route.REGISTERVIEW_PAGE;
  static const BIOGRAFI = Route.BIOGRAFIVIEW_PAGE;
  static const PENDING = Route.PENDING_PAGE;
  static const HOME = Route.HOMEVIEW_PAGE;
  static const HOMEGURU = Route.HOMEGURUVIEW_PAGE;
  static const NOTIFICATION = Route.NOTIFICATIONVIEW_PAGE;
  static const STRUKTURKELAS = Route.STRUKTURKELASVIEW_PAGE;
  static const STRUKTURKELASGURU = Route.STRUKTURKELASGURUVIEW_PAGE;
  static const INFOKELAS = Route.INFOKELASVIEW_PAGE;
  static const INFOTUGAS = Route.INFOTUGASVIEW_PAGE;
  static const PEMBUKUAN = Route.PEMBUKUANVIEW_PAGE;
  static const KAS = Route.KASVIEW_PAGE;
  static const AGENDA = Route.AGENDAVIEW_PAGE;
  static const PROFILE = Route.PROFILEVIEW_PAGE;
  static const JADWAL = Route.JADWALVIEW_PAGE;
  static const QRCODESISWA = Route.QRCODESISWAVIEW_PAGE;
  static const QRCODEGURU = Route.QRCODEGURUVIEW_PAGE;
  static const QRCODETUNAI = Route.QRCODETUNAIVIEW_PAGE;
  static const JADWALPIKET = Route.JADWALPIKET_PAGE;

  static final routes = [
    GetPage(
        name: Path.SPLASHSCREEN_PAGE,
        page: () => SplashScreen(),
        transition: Transition.noTransition),
    GetPage(
        name: Path.ONBOARDING_PAGE,
        page: () => OnboardingScreen(),
        transition: Transition.noTransition),
    GetPage(
        name: Path.LOGIN_PAGE,
        page: () => LoginView(),
        transition: Transition.noTransition),
    GetPage(
        name: Path.INPUTEMAIL_PAGE,
        page: () => InputEmailScreen(),
        transition: Transition.noTransition),
    GetPage(
        name: Path.REGISTER_PAGE,
        page: () => RegisterView(),
        transition: Transition.noTransition),
    GetPage(
        name: Path.BIOGRAFI_PAGE,
        page: () => BiografiView(),
        transition: Transition.noTransition),
    GetPage(
        name: Path.PENDING_PAGE,
        page: () => PendingScreen(),
        transition: Transition.noTransition),
    GetPage(
        name: Path.HOME_PAGE,
        page: () => HomeScreen(),
        transition: Transition.noTransition),
    GetPage(
        name: Path.HOMEGURU_PAGE,
        page: () => HomeScreenGuru(),
        transition: Transition.noTransition),
    GetPage(
        name: Path.NOTIFICATION_PAGE,
        page: () => NotificationPage(),
        transition: Transition.noTransition),
    GetPage(
        name: Path.STRUKTURKELAS_PAGE,
        page: () => StrukturKelasScreen(),
        transition: Transition.noTransition),
    GetPage(
        name: Path.STRUKTURKELASGURU_PAGE,
        page: () => StrukturKelasGuruScreen(),
        transition: Transition.noTransition),
    GetPage(
        name: Path.INFOKELAS_PAGE,
        page: () => InfoKelasScreen(),
        transition: Transition.noTransition),
    GetPage(
        name: Path.INFOTUGAS_PAGE,
        page: () => InfoTugasScreen(),
        transition: Transition.noTransition),
    GetPage(
        name: Path.PEMBUKUAN_PAGE,
        page: () => PembukuanView(),
        transition: Transition.noTransition),
    GetPage(
        name: Path.AGENDA_PAGE,
        page: () => AgendaScreen(),
        transition: Transition.noTransition),
    GetPage(
        name: Path.KAS_PAGE,
        page: () => KasScreen(),
        transition: Transition.noTransition),
    GetPage(
        name: Path.PROFILE_PAGE,
        page: () => ProfileScreen(),
        transition: Transition.noTransition),
    GetPage(
        name: Path.JADWAL_PAGE,
        page: () => JadwalScreen(),
        transition: Transition.noTransition),
    GetPage(
        name: Path.QRCODE,
        page: () => QrCodeScreen(),
        transition: Transition.noTransition),
    GetPage(
        name: Path.QRCODESISWA,
        page: () => QrCodeSiswaScreen(),
        transition: Transition.noTransition),
    GetPage(
        name: Path.QRCODEGURU,
        page: () => ScanQrAbsensi(),
        transition: Transition.noTransition),
    GetPage(
        name: Path.QRCODETUNAI,
        page: () => ScanQrCodeTunaiScreen(),
        transition: Transition.noTransition),
    GetPage(
        name: Path.JADWALPIKET,
        page: () => JadwalPiket(),
        transition: Transition.noTransition),    
  ];
}
