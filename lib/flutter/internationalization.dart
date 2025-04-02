import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _kLocaleStorageKey = '__locale_key__';

class FFLocalizations {
  FFLocalizations(this.locale);

  final Locale locale;

  static FFLocalizations of(BuildContext context) =>
      Localizations.of<FFLocalizations>(context, FFLocalizations)!;

  static List<String> languages() => ['en', 'ar', 'es', 'pt'];

  static late SharedPreferences _prefs;
  static Future initialize() async =>
      _prefs = await SharedPreferences.getInstance();
  static Future storeLocale(String locale) =>
      _prefs.setString(_kLocaleStorageKey, locale);
  static Locale? getStoredLocale() {
    final locale = _prefs.getString(_kLocaleStorageKey);
    return locale != null && locale.isNotEmpty ? createLocale(locale) : null;
  }

  String get languageCode => locale.toString();
  String? get languageShortCode =>
      _languagesWithShortCode.contains(locale.toString())
          ? '${locale.toString()}_short'
          : null;
  int get languageIndex => languages().contains(languageCode)
      ? languages().indexOf(languageCode)
      : 0;

  String getText(String key) =>
      (kTranslationsMap[key] ?? {})[locale.toString()] ?? '';

  String getVariableText({
    String? enText = '',
    String? arText = '',
    String? esText = '',
    String? ptText = '',
  }) =>
      [enText, arText, esText, ptText][languageIndex] ?? '';

  static const Set<String> _languagesWithShortCode = {
    'ar',
    'az',
    'ca',
    'cs',
    'da',
    'de',
    'dv',
    'en',
    'es',
    'et',
    'fi',
    'fr',
    'gr',
    'he',
    'hi',
    'hu',
    'it',
    'km',
    'ku',
    'mn',
    'ms',
    'no',
    'pt',
    'ro',
    'ru',
    'rw',
    'sv',
    'th',
    'uk',
    'vi',
  };
}

class FFLocalizationsDelegate extends LocalizationsDelegate<FFLocalizations> {
  const FFLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    final language = locale.toString();
    return FFLocalizations.languages().contains(
      language.endsWith('_')
          ? language.substring(0, language.length - 1)
          : language,
    );
  }

  @override
  Future<FFLocalizations> load(Locale locale) =>
      SynchronousFuture<FFLocalizations>(FFLocalizations(locale));

  @override
  bool shouldReload(FFLocalizationsDelegate old) => false;
}

Locale createLocale(String language) => language.contains('_')
    ? Locale.fromSubtags(
        languageCode: language.split('_').first,
        scriptCode: language.split('_').last,
      )
    : Locale(language);

final kTranslationsMap = <Map<String, Map<String, String>>>[
  // SplashPage1
  {
    'qu4qvz13': {
      'en': 'Home',
      'ar': 'بيت',
      'es': 'Hogar',
    },
  },
  // LoginPage
  {
    'ygpkfzvy': {
      'en': 'Welcome Back',
      'ar': 'مرحبًا بعودتك',
      'es': 'Bienvenido de nuevo',
      'pt': 'Bem-vindo de volta',
    },
    'if9a4fyq': {
      'en': 'Let\'s get started by filling out the form below.',
      'ar': 'لنبدأ بملء النموذج أدناه.',
      'es': 'Comencemos completando el formulario a continuación.',
      'pt': 'Vamos começar preenchendo o formulário abaixo.',
    },
    'cuhg5h2k': {
      'en': 'Email',
      'ar': 'بريد إلكتروني',
      'es': 'Correo electrónico',
      'pt': 'E-mail',
    },
    'email_mobile_hint': {
      'en': 'Enter your email id/Mobile no.',
      'ar': 'أدخل بريدك الإلكتروني / رقم الهاتف المحمول',
      'es': 'Ingrese su correo electrónico / número de teléfono móvil',
      'pt': 'Digite seu e-mail ou número de celular',
    },
    'qiz98qc1': {
      'en': 'Password',
      'ar': 'كلمة المرور',
      'es': 'Contraseña',
      'pt': 'Senha',
    },
    'password_hint': {
      'en': 'Enter your password',
      'ar': 'أدخل كلمة المرور',
      'es': 'Ingrese su contraseña',
      'pt': 'Digite sua senha',
    },
    'jvavrjuj': {
      'en': 'Login',
      'ar': 'تسجيل الدخول',
      'es': 'Acceso',
      'pt': 'Entrar',
    },
    'or_text': {
      'en': 'OR',
      'ar': 'أو',
      'es': 'O',
      'pt': 'OU',
    },
    'login_with_google': {
      'en': 'Login with Google',
      'ar': 'تسجيل الدخول باستخدام جوجل',
      'es': 'Iniciar sesión con Google',
      'pt': 'Entrar com Google',
    },
    'login_with_otp': {
      'en': 'Login with OTP',
      'ar': 'تسجيل الدخول باستخدام OTP',
      'es': 'Iniciar sesión con OTP',
      'pt': 'Entrar com OTP',
    },
    'dont_have_account': {
      'en': "Don't have an account?",
      'ar': 'ليس لديك حساب؟',
      'es': '¿No tienes una cuenta?',
      'pt': 'Não tem uma conta?',
    },
    'enter_email_hint': {
      'en': 'Enter your email id',
      'ar': 'أدخل بريدك الإلكتروني',
      'es': 'Ingrese su correo electrónico',
      'pt': 'Digite seu e-mail',
    },
    'full_name_label': {
      'en': 'Full Name',
      'ar': 'الاسم الكامل',
      'es': 'Nombre completo',
      'pt': 'Nome completo',
    },
    'enter_full_name_hint': {
      'en': 'Enter your full name',
      'ar': 'أدخل اسمك الكامل',
      'es': 'Ingrese su nombre completo',
      'pt': 'Digite seu nome completo',
    },
    '5wmogy0o': {
      'en': 'Please enter valid email id',
      'ar': 'الرجاء إدخال البريد الإلكتروني الصحيح',
      'es': 'Por favor ingrese una identificación de correo electrónico válida',
      'pt': 'Por favor, insira um e-mail válido',
    },
    '2ssulxuz': {
      'en': 'Please choose an option from the dropdown',
      'ar': 'يرجى اختيار خيار من القائمة المنسدلة',
      'es': 'Por favor elija una opción del menú desplegable',
      'pt': 'Por favor, escolha uma opção do menu',
    },
    'emkt5zqf': {
      'en': 'Please enter  password ',
      'ar': 'الرجاء إدخال كلمة المرور',
      'es': 'Por favor, ingrese contraseña',
      'pt': 'Por favor, insira sua senha',
    },
    'evfcgber': {
      'en': 'Please choose an option from the dropdown',
      'ar': 'يرجى اختيار خيار من القائمة المنسدلة',
      'es': 'Por favor elija una opción del menú desplegable',
      'pt': 'Por favor, escolha uma opção do menu',
    },
    '7ida6i7p': {
      'en': 'Or sign up with',
      'ar': 'أو قم بالتسجيل مع',
      'es': 'O regístrate con',
      'pt': 'Ou cadastre-se com',
    },
    'mhoemhea': {
      'en': 'Already have an account? ',
      'ar': 'هل لديك حساب؟',
      'es': '¿Ya tienes una cuenta?',
      'pt': 'Já tem uma conta?',
    },
    'ytqlordy': {
      'en': 'Sign up',
      'ar': 'اشتراك',
      'es': 'Inscribirse',
      'pt': 'Cadastrar',
    },
  },
  // NotificationPage
  {
    '3bafembr': {
      'en': 'Notification',
      'ar': 'إشعار',
      'es': 'Notificación',
      'pt': 'Notificação',
    },
    'bjdj7m31': {
      'en': 'Home',
      'ar': 'بيت',
      'es': 'Hogar',
      'pt': 'Início',
    },
  },
  // signupPage
  {
    '0p0b9pfj': {
      'en': 'Create a\nnew account\n',
      'ar': 'إنشاء\nحساب جديد',
      'es': 'Crear un\nnueva cuenta',
      'pt': 'Criar uma\nnova conta',
    },
    '89k4l8jl': {
      'en': 'Enter your complete details to \ncreate your account',
      'ar': 'أدخل التفاصيل الكاملة الخاصة بك ل\nأنشئ حسابك',
      'es': 'Ingresa tus datos completos para\nCrea tu cuenta',
      'pt': 'Digite seus dados completos para\ncriar sua conta',
    },
    '7v7ixvt3': {
      'en': 'Email',
      'ar': 'بريد إلكتروني',
      'es': 'Correo electrónico',
      'pt': 'E-mail',
    },
    'wbbhdncd': {
      'en': 'Full Name',
      'ar': 'الاسم الكامل',
      'es': 'Nombre completo',
      'pt': 'Nome completo',
    },
    'bl0od0hs': {
      'en': 'Password',
      'ar': 'كلمة المرور',
      'es': 'Contraseña',
      'pt': 'Senha',
    },
    'xmmk259o': {
      'en': 'Confirm Password',
      'ar': 'تأكيد كلمة المرور',
      'es': 'confirmar Contraseña',
      'pt': 'Confirmar senha',
    },
    'myn8lzuh': {
      'en': 'Create Account',
      'ar': 'إنشاء حساب',
      'es': 'Crear una cuenta',
      'pt': 'Criar conta',
    },
    'bx6orwdq': {
      'en': 'Field is required',
      'ar': 'الحقل مطلوب',
      'es': 'Se requiere campo',
      'pt': 'Campo obrigatório',
    },
    '1giem5jl': {
      'en': 'Please enter valid email id',
      'ar': 'الرجاء إدخال البريد الإلكتروني الصحيح',
      'es': 'Por favor ingrese una identificación de correo electrónico válida',
      'pt': 'Por favor, insira um e-mail válido',
    },
    's548orc3': {
      'en': 'Please choose an option from the dropdown',
      'ar': 'يرجى اختيار خيار من القائمة المنسدلة',
      'es': 'Por favor elija una opción del menú desplegable',
      'pt': 'Por favor, escolha uma opção do menu',
    },
    '5sgk3y5r': {
      'en': 'Field is required',
      'ar': 'الحقل مطلوب',
      'es': 'Se requiere campo',
      'pt': 'Campo obrigatório',
    },
    'dhneoj2g': {
      'en': 'Please enter user name  ',
      'ar': 'الرجاء إدخال اسم المستخدم',
      'es': 'Por favor ingrese el nombre de usuario',
      'pt': 'Por favor, insira o nome de usuário',
    },
    'biu293fk': {
      'en': 'Please choose an option from the dropdown',
      'ar': 'يرجى اختيار خيار من القائمة المنسدلة',
      'es': 'Por favor elija una opción del menú desplegable',
      'pt': 'Por favor, escolha uma opção do menu',
    },
    'q8ve59sr': {
      'en': 'Please  enter password',
      'ar': 'الرجاء إدخال كلمة المرور',
      'es': 'Por favor, ingrese contraseña',
      'pt': 'Por favor, insira sua senha',
    },
    '1yvx607t': {
      'en': 'Please choose an option from the dropdown',
      'ar': 'يرجى اختيار خيار من القائمة المنسدلة',
      'es': 'Por favor elija una opción del menú desplegable',
      'pt': 'Por favor, escolha uma opção do menu',
    },
    'pzxu4e9f': {
      'en': 'Please enter confirm password ',
      'ar': 'الرجاء إدخال تأكيد كلمة المرور',
      'es': 'Por favor ingrese confirmar contraseña',
      'pt': 'Por favor, confirme sua senha',
    },
    'b69boic2': {
      'en': 'Please choose an option from the dropdown',
      'ar': 'يرجى اختيار خيار من القائمة المنسدلة',
      'es': 'Por favor elija una opción del menú desplegable',
      'pt': 'Por favor, escolha uma opção do menu',
    },
    '3gieehle': {
      'en': 'Or sign up with',
      'ar': 'أو قم بالتسجيل مع',
      'es': 'O regístrate con',
      'pt': 'Ou cadastre-se com',
    },
    'k5tkrarf': {
      'en': 'Already have an account? ',
      'ar': 'هل لديك حساب؟',
      'es': '¿Ya tienes una cuenta?',
      'pt': 'Já tem uma conta?',
    },
    'e2zk3fd9': {
      'en': 'Sign In',
      'ar': 'تسجيل الدخول',
      'es': 'Iniciar sesión',
      'pt': 'Entrar',
    },
  },
  // HomePage
  {
    '41dhs01a': {
      'en': 'Search Here...',
      'ar': 'ابحث هنا...',
      'es': 'Busca aquí...',
      'pt': 'Pesquisar aqui...',
    },
    '5evyq1ya': {
      'en': 'enter your search location',
      'ar': 'أدخل موقع البحث الخاص بك',
      'es': 'ingresa tu ubicación de búsqueda',
      'pt': 'Digite sua localização para pesquisa',
    },
    'ahrn63qh': {
      'en': 'Available cars',
      'ar': 'السيارة المتوفرة',
      'es': 'Coche disponible',
      'pt': 'Carros disponíveis',
    },
    'azfqybrp': {
      'en': 'Home',
      'ar': 'بيت',
      'es': 'Hogar',
      'pt': 'Início',
    },
    '4rn1ny7d': {
      'en': 'Home',
      'ar': 'بيت',
      'es': 'Hogar',
      'pt': 'Início',
    },
  },
  // vehicle_listing_page
  {
    '1f26sndv': {
      'en': 'Days',
      'ar': 'أيام',
      'es': 'Días',
      'pt': 'Dias',
    },
    '9nrrtl81': {
      'en': 'Hours',
      'ar': 'ساعات',
      'es': 'Horas',
      'pt': 'Horas',
    },
    '2mlzstcu': {
      'en': '\$',
      'ar': '\$',
      'es': 'ps',
      'pt': 'R\$',
    },
    'uklnmth2': {
      'en': '/',
      'ar': '/',
      'es': '/',
      'pt': '/',
    },
    'xf936hfw': {
      'en': 'Details',
      'ar': 'تفاصيل',
      'es': 'Detalles',
      'pt': 'Detalhes',
    },
    'w94vsybl': {
      'en': 'Vehicle Listing',
      'ar': 'قائمة المركبات',
      'es': 'Listado de vehículos',
      'pt': 'Listagem de Veículos',
    },
    'o9x1i06l': {
      'en': 'Home',
      'ar': 'بيت',
      'es': 'Hogar',
      'pt': 'Início',
    },
  },
  // more_filter_page
  {
    'p6r3ar1p': {
      'en': 'More Filter',
      'ar': 'المزيد من التصفية',
      'es': 'Más filtro',
      'pt': 'Mais Filtros',
    },
    'ximtytd4': {
      'en': 'Location',
      'ar': 'موقع',
      'es': 'Ubicación',
      'pt': 'Localização',
    },
    '3ggt81oc': {
      'en': 'Search Here...',
      'ar': 'ابحث هنا...',
      'es': 'Busca aquí...',
      'pt': 'Pesquisar aqui...',
    },
    'zqqn5a7c': {
      'en': 'Price',
      'ar': 'سعر',
      'es': 'Precio',
      'pt': 'Preço',
    },
    'e3g8k48q': {
      'en': 'Brand',
      'ar': 'ماركة',
      'es': 'Marca',
      'pt': 'Marca',
    },
    'c6515iqk': {
      'en': 'Maruti Suzuki',
      'ar': 'Maruti Suzuki',
      'es': 'Maruti Suzuki',
      'pt': 'Maruti Suzuki',
    },
    '47og9azx': {
      'en': 'Renault',
      'ar': 'Renault',
      'es': 'Renault',
      'pt': 'Renault',
    },
    'x7w4hzte': {
      'en': 'Hyundai',
      'ar': 'Hyundai',
      'es': 'Hyundai',
      'pt': 'Hyundai',
    },
    '031fyc8d': {
      'en': 'Toyota',
      'ar': 'Toyota',
      'es': 'Toyota',
      'pt': 'Toyota',
    },
    'v11t7y1t': {
      'en': 'KIA',
      'ar': 'KIA',
      'es': 'KIA',
      'pt': 'KIA',
    },
    'txfxon3g': {
      'en': 'Tata Motars',
      'ar': 'Tata Motars',
      'es': 'Tata Motars',
      'pt': 'Tata Motors',
    },
    'wxnjayuj': {
      'en': 'Mahindra ',
      'ar': 'Mahindra ',
      'es': 'Mahindra ',
      'pt': 'Mahindra',
    },
    'hmsjzk0s': {
      'en': 'Honda',
      'ar': 'Honda',
      'es': 'Honda',
      'pt': 'Honda',
    },
    '86l9nq6i': {
      'en': 'Please select band',
      'ar': '',
      'es': '',
      'pt': 'Por favor, selecione a marca',
    },
    'ge0r9f4r': {
      'en': 'Search for an item...',
      'ar': '',
      'es': '',
      'pt': 'Pesquisar um item...',
    },
    '0um1s2zd': {
      'en': 'Vehicle Type',
      'ar': 'نوع السيارة',
      'es': 'tipo de vehiculo',
      'pt': 'Tipo de Veículo',
    },
    'lct9bt0b': {
      'en': 'SUV',
      'ar': 'SUV',
      'es': '',
      'pt': 'SUV',
    },
    '0y4waitz': {
      'en': 'MUV',
      'ar': '',
      'es': '',
      'pt': 'MUV',
    },
    '77fhwwp7': {
      'en': 'Luxury',
      'ar': 'Luxury',
      'es': 'Luxury',
      'pt': 'Luxo',
    },
    'wpvg3uqg': {
      'en': 'Sports',
      'ar': 'Sports',
      'es': 'Sports',
      'pt': 'Esportivo',
    },
    'p6oi6gzr': {
      'en': 'Please select vehicle type',
      'ar': '',
      'es': '',
      'pt': 'Por favor, selecione o tipo de veículo',
    },
    'w1bbj03s': {
      'en': 'Search for an item...',
      'ar': '',
      'es': '',
      'pt': 'Pesquisar um item...',
    },
    'ldt9x460': {
      'en': 'Fuel Type',
      'ar': 'نوع الوقود',
      'es': 'Tipo de combustible',
      'pt': 'Tipo de Combustível',
    },
    'wg341w1p': {
      'en': 'Disel',
      'ar': '',
      'es': '',
      'pt': 'Diesel',
    },
    '6sti7o4o': {
      'en': 'Disel',
      'ar': 'Disel',
      'es': 'Disel',
      'pt': 'Diesel',
    },
    'mzxaq16c': {
      'en': 'Petrol',
      'ar': 'Petrol',
      'es': 'Petrol',
      'pt': 'Gasolina',
    },
    'z0m3r4h7': {
      'en': 'EV',
      'ar': 'EV',
      'es': 'EV',
      'pt': 'Elétrico',
    },
    'uyodmq21': {
      'en': 'CNG',
      'ar': 'CNG',
      'es': 'CNG',
      'pt': 'GNV',
    },
    'pghdrqrf': {
      'en': 'Please select Fule type',
      'ar': '',
      'es': '',
      'pt': 'Por favor, selecione o tipo de combustível',
    },
    '39qlp78b': {
      'en': 'Search for an item...',
      'ar': '',
      'es': '',
      'pt': 'Pesquisar um item...',
    },
    '09wgunbd': {
      'en': 'Days And Hourly',
      'ar': 'باب الطاقة',
      'es': 'Puerta eléctrica',
      'pt': 'Dias e Horas',
    },
    '63rynpmm': {
      'en': 'Days',
      'ar': '',
      'es': '',
      'pt': 'Dias',
    },
    'li5iqc87': {
      'en': 'Days',
      'ar': 'Days',
      'es': 'Days',
      'pt': 'Dias',
    },
    '4hc07c3a': {
      'en': 'Hourly',
      'ar': 'Hourly',
      'es': 'Hourly',
      'pt': 'Por Hora',
    },
    'ic9zni57': {
      'en': 'Please select days and hourly',
      'ar': '',
      'es': '',
      'pt': 'Por favor, selecione dias e horas',
    },
    'cvvo9laq': {
      'en': 'Search for an item...',
      'ar': '',
      'es': '',
      'pt': 'Pesquisar um item...',
    },
    'g0u3cva6': {
      'en': 'Apply',
      'ar': 'يتقدم',
      'es': 'Aplicar',
      'pt': 'Aplicar',
    },
    '54vofrya': {
      'en': 'Home',
      'ar': 'بيت',
      'es': 'Hogar',
      'pt': 'Início',
    },
  },
  // product_detail_page
  {
    '1wk0pwmi': {
      'en': '\$',
      'ar': '\$',
      'es': 'ps',
      'pt': 'R\$',
    },
    'gdgk4la9': {
      'en': '/',
      'ar': '/',
      'es': '/',
      'pt': '/',
    },
    'hv7ydtqz': {
      'en': 'Features',
      'ar': 'سمات',
      'es': 'Características',
      'pt': 'Recursos',
    },
    'y90sqru4': {
      'en': 'Automatic transmission: Yes',
      'ar': 'ناقل الحركة الأوتوماتيكي: نعم',
      'es': 'Transmisión automática: Sí',
      'pt': 'Transmissão automática: Sim',
    },
    'mk4g2ktn': {
      'en': 'Descriptions',
      'ar': 'الأوصاف',
      'es': 'Descripciones',
      'pt': 'Descrições',
    },
    'ri8keepz': {
      'en': 'Specification',
      'ar': 'تخصيص',
      'es': 'Especificación',
      'pt': 'Especificações',
    },
    '9ljxt6nm': {
      'en': 'Where to find',
      'ar': 'أين تجد',
      'es': 'Donde encontrar',
      'pt': 'Onde encontrar',
    },
    'pvhvrom9': {
      'en': 'Similar Vehicles ',
      'ar': 'مركبات مماثلة',
      'es': 'Vehículos similares',
      'pt': 'Veículos Similares',
    },
    'uc5oqgba': {
      'en': '\$',
      'ar': '\$',
      'es': 'ps',
      'pt': 'R\$',
    },
    'g5ane3oy': {
      'en': '/',
      'ar': '/',
      'es': '/',
      'pt': '/',
    },
    'dee2pi5u': {
      'en': 'Details',
      'ar': 'تفاصيل',
      'es': 'Detalles',
      'pt': 'Detalhes',
    },
    '30q5685b': {
      'en': 'Rent It',
      'ar': 'استأجرها',
      'es': 'Alquilalo',
      'pt': 'Alugar',
    },
    'nlaxqzbk': {
      'en': 'Home',
      'ar': 'بيت',
      'es': 'Hogar',
      'pt': 'Início',
    },
  },
  // your_currentBooking_page
  {
    'zmr4vt9t': {
      'en': 'Current Booking',
      'ar': 'الحجز الحالي',
      'es': 'Reserva actual',
      'pt': 'Reserva Atual',
    },
    'g3baa7fb': {
      'en': '\$',
      'ar': '\$',
      'es': 'ps',
      'pt': 'R\$',
    },
    'ibfzcjjx': {
      'en': '/',
      'ar': '/',
      'es': '/',
      'pt': '/',
    },
    '882rxjud': {
      'en': 'Price',
      'ar': '',
      'es': '',
      'pt': 'Preço',
    },
    '3dfiveih': {
      'en': 'Details',
      'ar': 'تفاصيل',
      'es': 'Detalles',
      'pt': 'Detalhes',
    },
    't6bazqfn': {
      'en': 'No Booking Available !',
      'ar': 'لا يوجد حجز متاح!',
      'es': '¡No hay reservas disponibles!',
      'pt': 'Nenhuma Reserva Disponível!',
    },
    'zt1l5kzn': {
      'en': 'History',
      'ar': 'تاريخ',
      'es': 'Historia',
      'pt': 'Histórico',
    },
    '847bm6he': {
      'en': '\$',
      'ar': '\$',
      'es': 'ps',
      'pt': 'R\$',
    },
    'v2nw6ctr': {
      'en': '/',
      'ar': '/',
      'es': '/',
      'pt': '/',
    },
    'ul0cxoo5': {
      'en': 'Price',
      'ar': '',
      'es': '',
      'pt': 'Preço',
    },
    '963r5h1i': {
      'en': 'Details',
      'ar': 'تفاصيل',
      'es': 'Detalles',
      'pt': 'Detalhes',
    },
    'cwi7jaad': {
      'en': 'No Booking Available !',
      'ar': 'لا يوجد حجز متاح!',
      'es': '¡No hay reservas disponibles!',
      'pt': 'Nenhuma Reserva Disponível!',
    },
    '64j4t9wx': {
      'en': 'Booking',
      'ar': 'الحجز',
      'es': 'Reserva',
      'pt': 'Reserva',
    },
    'icu4qvrc': {
      'en': 'Bookings',
      'ar': 'الحجوزات',
      'es': 'Reservaciones',
      'pt': 'Reservas',
    },
  },
  // address_page
  {
    'u6swov4v': {
      'en': 'Add New Addrress',
      'ar': 'إضافة عنوان جديد',
      'es': 'Agregar nueva dirección',
      'pt': 'Adicionar Novo Endereço',
    },
    'uvib30ms': {
      'en': 'Address',
      'ar': 'عنوان',
      'es': 'DIRECCIÓN',
      'pt': 'Endereço',
    },
    'tizrv6dy': {
      'en': 'Dewas',
      'ar': 'ديواس',
      'es': 'Dewas',
      'pt': 'Dewas',
    },
    '4mvd6mv3': {
      'en': '34, Mahaweer Nagar, Dewas',
      'ar': '34، محوير نجار، ديواس',
      'es': '34, Mahaweer Nagar, Dewas',
      'pt': '34, Mahaweer Nagar, Dewas',
    },
    'o5awb2uw': {
      'en': '(+91) 98266 98050',
      'ar': '(+91) 98266 98050',
      'es': '(+91) 98266 98050',
      'pt': '(+91) 98266 98050',
    },
    'amveo663': {
      'en': 'Zip code:',
      'ar': 'الرمز البريدي:',
      'es': 'Código postal:',
      'pt': 'CEP:',
    },
    'uugrk14b': {
      'en': '455001',
      'ar': '455001',
      'es': '455001',
      'pt': '455001',
    },
    'dgcvrapm': {
      'en': 'Set Address Defaut  ',
      'ar': 'تعيين العنوان الافتراضي',
      'es': 'Establecer dirección predeterminada',
      'pt': 'Definir como Endereço Padrão',
    },
    '7qy0hda4': {
      'en': 'Dewas',
      'ar': 'ديواس',
      'es': 'Dewas',
      'pt': 'Dewas',
    },
    'it291rmd': {
      'en': '34, Mahaweer Nagar, Dewas',
      'ar': '34، محوير نجار، ديواس',
      'es': '34, Mahaweer Nagar, Dewas',
      'pt': '34, Mahaweer Nagar, Dewas',
    },
    'h6srezlr': {
      'en': '(+91) 98266 98050',
      'ar': '(+91) 98266 98050',
      'es': '(+91) 98266 98050',
      'pt': '(+91) 98266 98050',
    },
    'gxpjs2w5': {
      'en': 'Zip code:',
      'ar': 'الرمز البريدي:',
      'es': 'Código postal:',
      'pt': 'CEP:',
    },
    '3h0wfkne': {
      'en': '455001',
      'ar': '455001',
      'es': '455001',
      'pt': '455001',
    },
    'p2qfsnb8': {
      'en': 'Set Address Defaut ',
      'ar': 'تعيين العنوان الافتراضي',
      'es': 'Establecer dirección predeterminada',
      'pt': 'Definir como Endereço Padrão',
    },
    'g55e4ia6': {
      'en': 'Address',
      'ar': 'عنوان',
      'es': 'DIRECCIÓN',
      'pt': 'Endereço',
    },
    'rc44sz8v': {
      'en': 'Home',
      'ar': 'بيت',
      'es': 'Hogar',
      'pt': 'Início',
    },
  },
  // payment_method_page
  {
    'o1hts0bx': {
      'en': 'Add New Card',
      'ar': 'إضافة بطاقة جديدة',
      'es': 'Agregar nueva tarjeta',
      'pt': 'Adicionar Novo Cartão',
    },
    '7tzgolfc': {
      'en': 'Credit cards',
      'ar': 'بطاقات الائتمان',
      'es': 'Tarjetas de crédito',
      'pt': 'Cartões de Crédito',
    },
    'aeyravv1': {
      'en': '**** **** **** 1234',
      'ar': '**** **** **** 1234',
      'es': '**** **** **** 1234',
      'pt': '**** **** **** 1234',
    },
    'l66u8s7u': {
      'en': 'VISA Card',
      'ar': 'بطاقة فيزا',
      'es': 'Tarjeta Visa',
      'pt': 'Cartão VISA',
    },
    '3w7abgxq': {
      'en': '**** **** **** 1234',
      'ar': '**** **** **** 1234',
      'es': '**** **** **** 1234',
      'pt': '**** **** **** 1234',
    },
    'ffjn81aw': {
      'en': 'Master Card',
      'ar': 'بطاقة ماستر بطاقة ائتمان',
      'es': 'Tarjeta maestra',
      'pt': 'Cartão Mastercard',
    },
    'naleqxks': {
      'en': '**** **** **** 1234',
      'ar': '**** **** **** 1234',
      'es': '**** **** **** 1234',
      'pt': '**** **** **** 1234',
    },
    '58et1ax4': {
      'en': 'Paypal Card',
      'ar': 'بطاقة باي بال',
      'es': 'Tarjeta Paypal',
      'pt': 'Cartão PayPal',
    },
    'cdssq4h4': {
      'en': 'Payment Methods',
      'ar': 'طرق الدفع',
      'es': 'Métodos de pago',
      'pt': 'Métodos de Pagamento',
    },
    'v716gt1l': {
      'en': 'Home',
      'ar': 'بيت',
      'es': 'Hogar',
      'pt': 'Início',
    },
  },
  // Information_page
  {
    'dp13yjqj': {
      'en': 'Information',
      'ar': 'معلومة',
      'es': 'Información',
      'pt': 'Informação',
    },
    'b2k3drgb': {
      'en': 'Home',
      'ar': 'بيت',
      'es': 'Hogar',
      'pt': 'Início',
    },
  },
  // message_page
  {
    '37ob9eig': {
      'en': 'Message',
      'ar': 'رسالة',
      'es': 'Mensaje',
      'pt': 'Mensagem',
    },
    'jjuhxx69': {
      'en': 'Home',
      'ar': 'بيت',
      'es': 'Hogar',
      'pt': 'Início',
    },
  },
  // location_page
  {
    '7z9o676i': {
      'en': 'Select Location',
      'ar': 'اختر موقعا',
      'es': 'Seleccionar Ubicación',
      'pt': 'Selecionar Localização',
    },
    'gsymxful': {
      'en': 'Location',
      'ar': '',
      'es': '',
      'pt': 'Localização',
    },
    'p2rkghtj': {
      'en': 'Location',
      'ar': 'طريق',
      'es': 'Ruta',
      'pt': 'Localização',
    },
    'brj850v2': {
      'en': 'Home',
      'ar': 'بيت',
      'es': 'Hogar',
      'pt': 'Início',
    },
  },
  // booking_page
  {
    '6pl2lxl3': {
      'en': 'Self',
      'ar': '',
      'es': '',
      'pt': 'Próprio',
    },
    'v8no0oyb': {
      'en': 'Self',
      'ar': 'الذات',
      'es': 'Ser',
      'pt': 'Próprio',
    },
    'jz6j8hga': {
      'en': 'Driver',
      'ar': 'سائق',
      'es': 'Conductor',
      'pt': 'Motorista',
    },
    'gcruivme': {
      'en': '\$',
      'ar': '',
      'es': '',
      'pt': 'R\$',
    },
    'o8e8rhpu': {
      'en': ' Per Days',
      'ar': '',
      'es': '',
      'pt': 'Por Dia',
    },
    'sobzzdfw': {
      'en': ' ',
      'ar': '',
      'es': '',
      'pt': ' ',
    },
    'x1lc4q5d': {
      'en': '\$',
      'ar': '',
      'es': '',
      'pt': 'R\$',
    },
    's3b6u5bv': {
      'en': ' Per',
      'ar': '',
      'es': '',
      'pt': 'Por',
    },
    'pvvsz70d': {
      'en': '',
      'ar': '',
      'es': '',
      'pt': '',
    },
    'aafmr9y1': {
      'en': 'Option 1',
      'ar': 'الخيار 1',
      'es': 'Opción 1',
      'pt': 'Opção 1',
    },
    '7adfhanl': {
      'en': 'Please select pickup location',
      'ar': 'الرجاء تحديد موقع الالتقاط',
      'es': 'Por favor seleccione el lugar de recogida',
      'pt': 'Por favor, selecione o local de retirada',
    },
    '2t3olczu': {
      'en': 'Search for an item...',
      'ar': 'البحث عن عنصر...',
      'es': 'Buscar un artículo...',
      'pt': 'Pesquisar um item...',
    },
    'gnnbki8q': {
      'en': '',
      'ar': '',
      'es': '',
      'pt': '',
    },
    '5ix4b3hr': {
      'en': 'Option 1',
      'ar': 'الخيار 1',
      'es': 'Opción 1',
      'pt': 'Opção 1',
    },
    '6bgu8ex7': {
      'en': 'Please select dropoff location',
      'ar': 'الرجاء تحديد موقع الالتقاط',
      'es': 'Por favor seleccione el lugar de recogida',
      'pt': 'Por favor, selecione o local de entrega',
    },
    'v89jtu1y': {
      'en': 'Search for an item...',
      'ar': 'البحث عن عنصر...',
      'es': 'Buscar un artículo...',
      'pt': 'Pesquisar um item...',
    },
    'nve5nwq1': {
      'en': 'Name of Rented',
      'ar': 'اسم المستأجرة',
      'es': 'Nombre del Alquilado',
      'pt': 'Nome do Locatário',
    },
    'pli178ke': {
      'en': 'Please enter name',
      'ar': '',
      'es': '',
      'pt': 'Por favor, insira o nome',
    },
    '7kixyhdg': {
      'en': 'Phone Number',
      'ar': 'رقم التليفون',
      'es': 'Número de teléfono',
      'pt': 'Número de Telefone',
    },
    '9fwpvtje': {
      'en': 'Please enter contact Number',
      'ar': '',
      'es': '',
      'pt': 'Por favor, insira o número de contato',
    },
    '6b8vp6f5': {
      'en': 'Start date',
      'ar': 'تاريخ البدء',
      'es': 'Fecha de inicio',
      'pt': 'Data de início',
    },
    'p878gseq': {
      'en': 'Start time',
      'ar': 'تاريخ البدء',
      'es': 'Fecha de inicio',
      'pt': 'Horário de início',
    },
    '1ui0h2nb': {
      'en': 'End date',
      'ar': 'تاريخ الانتهاء',
      'es': 'Fecha final',
      'pt': 'Data de término',
    },
    '062bdg35': {
      'en': 'End time',
      'ar': 'تاريخ الانتهاء',
      'es': 'Fecha final',
      'pt': 'Horário de término',
    },
    'uwxzfxa2': {
      'en': 'License photo back and fornt',
      'ar': 'صورة الترخيص من الخلف والأمام',
      'es': 'Foto de licencia de ida y vuelta',
      'pt': 'Foto da CNH frente e verso',
    },
    'b9dlagdz': {
      'en': 'Rental  Fees',
      'ar': 'تأجير ريس',
      'es': 'Alquiler Fees',
      'pt': 'Taxa de Aluguel',
    },
    '4hvdgqis': {
      'en': 'Total of ',
      'ar': 'إجمالي 3 أيام',
      'es': 'Total de 3 días',
      'pt': 'Total de ',
    },
    'qj2u90vy': {
      'en': 'driver',
      'ar': 'إجمالي 3 أيام',
      'es': 'Total de 3 días',
      'pt': 'motorista',
    },
    'le6zzjtl': {
      'en': ' ',
      'ar': '600 دولار',
      'es': '\$600',
      'pt': ' ',
    },
    '89j9atll': {
      'en': 'Total of ',
      'ar': 'إجمالي 3 أيام',
      'es': 'Total de 3 días',
      'pt': 'Total de ',
    },
    'p5ik7die': {
      'en': 'days',
      'ar': 'إجمالي 3 أيام',
      'es': 'Total de 3 أيام',
      'pt': 'dias',
    },
    'b44laoxv': {
      'en': 'Total of ',
      'ar': 'إجمالي 3 أيام',
      'es': 'Total de 3 días',
      'pt': 'Total de ',
    },
    '4iixpq4v': {
      'en': ' houly',
      'ar': 'إجمالي 3 أيام',
      'es': 'Total de 3 días',
      'pt': 'horas',
    },
    'nx5oz5zu': {
      'en': 'Total fees',
      'ar': 'الرسوم الكلية',
      'es': 'Tarifas totales',
      'pt': 'Taxas totais',
    },
    'kvtmofp3': {
      'en': 'Total fees',
      'ar': 'الرسوم الكلية',
      'es': 'Tarifas totales',
      'pt': 'Taxas totais',
    },
    'p8jtyhqy': {
      'en': 'I accept terms of service',
      'ar': 'أوافق على شروط الخدمة',
      'es': 'Acepto los términos de servicio',
      'pt': 'Aceito os termos de serviço',
    },
    'konc25ih': {
      'en': 'Book',
      'ar': 'كتاب',
      'es': 'Libro',
      'pt': 'Reservar',
    },
    'rfbijtbs': {
      'en': 'Booking',
      'ar': 'الحجز',
      'es': 'Reserva',
      'pt': 'Reserva',
    },
    'r5nsh2jf': {
      'en': 'Home',
      'ar': 'بيت',
      'es': 'Hogar',
      'pt': 'Início',
    },
  },
  // edit_profile
  {
    'i4u53ivf': {
      'en': 'Edit Page',
      'ar': 'تعديل الصفحة',
      'es': 'Editar página',
      'pt': 'Editar Perfil',
    },
    '4gks486y': {
      'en': 'Full Name',
      'ar': 'الاسم الكامل',
      'es': 'Nombre completo',
      'pt': 'Nome Completo',
    },
    't8xpkwki': {
      'en': 'Enter your full name',
      'ar': 'أدخل اسمك الكامل',
      'es': 'Introduce tu nombre completo',
      'pt': 'Digite seu nome completo',
    },
    'tgovzoq7': {
      'en': 'Email Address',
      'ar': 'عنوان البريد الإلكتروني',
      'es': 'Dirección de correo electrónico',
      'pt': 'Endereço de E-mail',
    },
    '5mrcu7r1': {
      'en': 'Enter your email address',
      'ar': 'أدخل عنوان بريدك الالكتروني',
      'es': 'Introduce tu dirección de correo electrónico',
      'pt': 'Digite seu endereço de e-mail',
    },
    'x49fyvee': {
      'en': 'Phone Number',
      'ar': 'رقم التليفون',
      'es': 'Número de teléfono',
      'pt': 'Número de Telefone',
    },
    'bqy57d8r': {
      'en': 'Enter your phone number',
      'ar': 'أدخل رقم هاتفك',
      'es': 'Ingrese su número telefónico',
      'pt': 'Digite seu número de telefone',
    },
    'z5ykg1jz': {
      'en': 'Save Changes',
      'ar': 'حفظ التغييرات',
      'es': 'Guardar cambios',
      'pt': 'Salvar Alterações',
    },
  },
  // confirmation_page
  {
    'dx0o2bhy': {
      'en': 'Please  Review Your Request and confrim',
      'ar': 'يرجى مراجعة طلبك والتأكيد',
      'es': 'Por favor revise su solicitud y confirme',
      'pt': 'Por favor, revise sua solicitação e confirme',
    },
    'vy3zwxy0': {
      'en': '\$',
      'ar': '',
      'es': '',
      'pt': 'R\$',
    },
    'g8u9edbp': {
      'en': 'Full Name',
      'ar': 'الاسم الكامل',
      'es': 'Nombre completo',
      'pt': 'Nome Completo',
    },
    'xck1b5m9': {
      'en': 'Name',
      'ar': 'اسم',
      'es': 'Nombre',
      'pt': 'Nome',
    },
    'neqmcvn4': {
      'en': 'Mobile Number',
      'ar': 'رقم الهاتف المحمول',
      'es': 'Número de teléfono móvil',
      'pt': 'Número de Celular',
    },
    '8cgwoodc': {
      'en': 'Mobile Number',
      'ar': 'رقم الهاتف المحمول',
      'es': 'Número de teléfono móvil',
      'pt': 'Número de Celular',
    },
    'q0u6kl6c': {
      'en': 'Email',
      'ar': 'بريد إلكتروني',
      'es': 'Correo electrónico',
      'pt': 'E-mail',
    },
    'n6r3zyp1': {
      'en': 'Email',
      'ar': 'بريد إلكتروني',
      'es': 'Correo electrónico',
      'pt': 'E-mail',
    },
    'mlrivcx6': {
      'en': 'Pickup Address',
      'ar': 'الاستلام والعودة',
      'es': 'Recogida y devolución',
      'pt': 'Endereço de Retirada',
    },
    '81teod8g': {
      'en': 'Return Address',
      'ar': 'الاستلام والعودة',
      'es': 'Recogida y devolución',
      'pt': 'Endereço de Devolução',
    },
    'qs8elic5': {
      'en': 'Rental  Rees',
      'ar': 'تأجير ريس',
      'es': 'Alquiler Rees',
      'pt': 'Taxa de Aluguel',
    },
    'cm6xinmt': {
      'en': 'Total of ',
      'ar': 'إجمالي 3 أيام',
      'es': 'Total de 3 días',
      'pt': 'Total de ',
    },
    'cc8dnbt7': {
      'en': 'driver',
      'ar': 'إجمالي 3 أيام',
      'es': 'Total de 3 días',
      'pt': 'motorista',
    },
    'm60be12x': {
      'en': ' ',
      'ar': '600 دولار',
      'es': '\$600',
      'pt': ' ',
    },
    'oiv8z3y9': {
      'en': 'Total of ',
      'ar': 'إجمالي 3 أيام',
      'es': 'Total de 3 días',
      'pt': 'Total de ',
    },
    'npjj1f7n': {
      'en': 'days',
      'ar': 'إجمالي 3 أيام',
      'es': 'Total de 3 أيام',
      'pt': 'dias',
    },
    'tfodefb4': {
      'en': 'Total fees',
      'ar': 'الرسوم الكلية',
      'es': 'Tarifas totales',
      'pt': 'Taxas totais',
    },
    '4tnjexl6': {
      'en': 'Rental  Rees',
      'ar': 'تأجير ريس',
      'es': 'Alquiler Rees',
      'pt': 'Taxa de Aluguel',
    },
    'a4vmimgx': {
      'en': 'Total of ',
      'ar': 'إجمالي 3 أيام',
      'es': 'Total de 3 días',
      'pt': 'Total de ',
    },
    'meoh2eql': {
      'en': 'driver',
      'ar': 'إجمالي 3 أيام',
      'es': 'Total de 3 días',
      'pt': 'motorista',
    },
    '10teyk1y': {
      'en': ' ',
      'ar': '600 دولار',
      'es': '\$600',
      'pt': ' ',
    },
    'x6nm0quf': {
      'en': 'Total of ',
      'ar': 'إجمالي 3 أيام',
      'es': 'Total de 3 días',
      'pt': 'Total de ',
    },
    '805xt1d3': {
      'en': 'hourly',
      'ar': 'إجمالي 3 أيام',
      'es': 'Total de 3 días',
      'pt': 'horas',
    },
    '4geu19oq': {
      'en': 'Total fees',
      'ar': 'الرسوم الكلية',
      'es': 'Tarifas totales',
      'pt': 'Taxas totais',
    },
    'i2sq1i0t': {
      'en': ' \$',
      'ar': '800 دولار',
      'es': '\$800',
      'pt': 'R\$',
    },
    '3nsfzryp': {
      'en': 'Payment method',
      'ar': 'طريقة الدفع او السداد',
      'es': 'Método de pago',
      'pt': 'Método de pagamento',
    },
    'k90w4e0g': {
      'en': '**** **** **** 1234',
      'ar': '**** **** **** 1234',
      'es': '**** **** **** 1234',
      'pt': '**** **** **** 1234',
    },
    'qsa14vpn': {
      'en': 'Pay now',
      'ar': 'ادفع الآن',
      'es': 'Pagar ahora',
      'pt': 'Pagar agora',
    },
    'fub301no': {
      'en': 'Pay at Pick-up',
      'ar': 'الدفع عند الاستلام',
      'es': 'Pagar al recoger',
      'pt': 'Pagar na retirada',
    },
    'pzxgxutd': {
      'en': 'Confrimation',
      'ar': 'تأكيد',
      'es': 'Confirmación',
      'pt': 'Confirmação',
    },
    '0khsnznw': {
      'en': 'Home',
      'ar': 'بيت',
      'es': 'Hogar',
      'pt': 'Início',
    },
  },
  // booking_successfully_page
  {
    '8sk7o7zk': {
      'en': 'Booking Successfully',
      'ar': 'تم الحجز بنجاح',
      'es': 'Reserva exitosa',
      'pt': 'Reserva Realizada com Sucesso',
    },
    'c8p568dk': {
      'en':
          'You\'ve booked car successfully. Go to My booking for more booking detail.',
      'ar': 'لقد قمت بحجز السيارة بنجاح. انتقل إلى حجزي لمزيد من تفاصيل الحجز.',
      'es':
          'Has reservado el coche con éxito. Vaya a Mi reserva para obtener más detalles sobre la reserva.',
      'pt': 'Você reservou o carro com sucesso. Vá para Minhas Reservas para mais detalhes.',
    },
    'v344iihr': {
      'en': 'Summary',
      'ar': 'ملخص',
      'es': 'Resumen',
      'pt': 'Resumo',
    },
    'n8oog2rh': {
      'en': 'Car',
      'ar': 'سيارة',
      'es': 'Auto',
      'pt': 'Carro',
    },
    'nhpxkroy': {
      'en': 'Trip pickup ',
      'ar': 'الاستلام والعودة',
      'es': 'recogida y devolución',
      'pt': 'Local de retirada',
    },
    '8ryhnx7i': {
      'en': 'Return address',
      'ar': 'الاستلام والعودة',
      'es': 'recogida y devolución',
      'pt': 'Local de devolução',
    },
    'nbn06gp4': {
      'en': 'Trip start date',
      'ar': 'تاريخ الرحلة',
      'es': 'Fecha de viaje',
      'pt': 'Data de início da viagem',
    },
    'mbowpdmn': {
      'en': 'Return date',
      'ar': 'تاريخ الرحلة',
      'es': 'Fecha de viaje',
      'pt': 'Data de devolução',
    },
    'dur2igv0': {
      'en': 'Total fees',
      'ar': 'الرسوم الكلية',
      'es': 'Tarifas totales',
      'pt': 'Taxas totais',
    },
    'wbgpvwye': {
      'en': ' \$',
      'ar': '800 دولار',
      'es': '\$800',
      'pt': 'R\$',
    },
    'feux1yxi': {
      'en': 'Go To Home',
      'ar': 'اذهب إلى المنزل',
      'es': 'Ir a casa',
      'pt': 'Ir para Início',
    },
    'mupzwz9h': {
      'en': 'Home',
      'ar': 'بيت',
      'es': 'Hogar',
      'pt': 'Início',
    },
  },
  // add_my_payment_page
  {
    'f7a6wnt3': {
      'en': 'Pay',
      'ar': 'يدفع',
      'es': 'Pagar',
      'pt': 'Pagar',
    },
    'e353pjnp': {
      'en': 'Paymnet',
      'ar': 'شبكة الدفع',
      'es': 'Pago',
      'pt': 'Pagamento',
    },
    'u5n0y2mr': {
      'en': 'Home',
      'ar': 'بيت',
      'es': 'Hogar',
      'pt': 'Início',
    },
  },
  // support_page
  {
    '1cy3vp12': {
      'en': 'Welcome to support',
      'ar': 'مرحبا بكم في الدعم',
      'es': 'Bienvenido a apoyar',
      'pt': 'Bem-vindo ao suporte',
    },
    'yayjowch': {
      'en': 'Submit a Ticket',
      'ar': 'تسجيل التذكرة',
      'es': 'Envía un boleto',
      'pt': 'Enviar um Ticket',
    },
    'd64ticys': {
      'en': 'User Name',
      'ar': 'اسم المستخدم',
      'es': 'Nombre de usuario',
      'pt': 'Nome de Usuário',
    },
    'yd9rmtek': {
      'en': 'Email',
      'ar': 'بريد إلكتروني',
      'es': 'Correo electrónico',
      'pt': 'E-mail',
    },
    '0g085y2a': {
      'en': 'Contact',
      'ar': 'اتصال',
      'es': 'Contacto',
      'pt': 'Contato',
    },
    '64cwuku8': {
      'en': 'Short Description of what is going on...',
      'ar': 'وصف مختصر لما يحدث...',
      'es': 'Breve descripción de lo que está pasando...',
      'pt': 'Breve descrição do que está acontecendo...',
    },
    'ja010245': {
      'en': 'Submit',
      'ar': 'يُقدِّم',
      'es': 'Entregar',
      'pt': 'Enviar',
    },
    'vanz5ki4': {
      'en': 'Submit Ticket',
      'ar': 'قدم التذكرة',
      'es': 'Enviar ticket',
      'pt': 'Enviar Ticket',
    },
    'gnud9hpr': {
      'en': 'Home',
      'ar': 'بيت',
      'es': 'Hogar',
      'pt': 'Início',
    },
  },
  // booking_History_List
  {
    'xf4nlb3i': {
      'en': '\$',
      'ar': '\$',
      'es': 'ps',
      'pt': 'R\$',
    },
    '04krq0p0': {
      'en': '/',
      'ar': '/',
      'es': '/',
      'pt': '/',
    },
    'jujcrcje': {
      'en': 'Price',
      'ar': '',
      'es': '',
      'pt': 'Preço',
    },
    't6khy8tq': {
      'en': 'Details',
      'ar': 'تفاصيل',
      'es': 'Detalles',
      'pt': 'Detalhes',
    },
    'u84f0ob1': {
      'en': 'History',
      'ar': 'تاريخ',
      'es': 'Historia',
      'pt': 'Histórico',
    },
    'vpsu3vv9': {
      'en': 'Wish List',
      'ar': 'قائمة الرغبات',
      'es': 'Lista de deseos',
      'pt': 'Lista de Desejos',
    },
  },
  // booking_detail_page
  {
    'z5umyfkd': {
      'en': 'Booking Details',
      'ar': 'تفاصيل الحجز',
      'es': 'Detalles de la reserva',
      'pt': 'Detalhes da Reserva',
    },
    '1dbmam87': {
      'en': '\$',
      'ar': '\$',
      'es': 'ps',
      'pt': 'R\$',
    },
    'x7qgqosd': {
      'en': '/',
      'ar': '/',
      'es': '/',
      'pt': '/',
    },
    'sac1yk3s': {
      'en': 'Driver Detail',
      'ar': 'تفاصيل السائق',
      'es': 'Detalle del conductor',
      'pt': 'Detalhes do Motorista',
    },
    'rpgy9djv': {
      'en': 'Driver Name',
      'ar': 'اسم السائق',
      'es': 'Nombre del conductor',
      'pt': 'Nome do Motorista',
    },
    '0tsg3xre': {
      'en': 'jogn tomer',
      'ar': 'برامود تومر',
      'es': 'tomer pramod',
      'pt': 'João Tomer',
    },
    'hffbxk2l': {
      'en': 'Driver Phone Number',
      'ar': 'رقم هاتف السائق',
      'es': 'Número de teléfono del conductor',
      'pt': 'Número de Telefone do Motorista',
    },
    'p3yu5y5n': {
      'en': '+91 8827904769',
      'ar': '+91 8827904764',
      'es': '+91 8827904764',
      'pt': '+91 8827904769',
    },
    'fpl9ns3f': {
      'en': 'Car Seats',
      'ar': 'مقاعد السيارة',
      'es': 'Asientos de carro',
      'pt': 'Assentos do Carro',
    },
    'lcww4gsd': {
      'en': 'Descriptions',
      'ar': 'الأوصاف',
      'es': 'Descripciones',
      'pt': 'Descrições',
    },
    '210seo17': {
      'en': 'Features',
      'ar': 'سمات',
      'es': 'Características',
      'pt': 'Recursos',
    },
    'vs47b3oz': {
      'en': 'Automatic transmission: Yes',
      'ar': 'ناقل الحركة الأوتوماتيكي: نعم',
      'es': 'Transmisión automática: Sí',
      'pt': 'Transmissão automática: Sim',
    },
    'oi63dzrs': {
      'en': 'Pickup and Return',
      'ar': 'الاستلام والعودة',
      'es': 'Recogida y devolución',
      'pt': 'Retirada e Devolução',
    },
    'wf9mvwnl': {
      'en': 'Pickup and Return',
      'ar': 'الاستلام والعودة',
      'es': 'Recogida y devolución',
      'pt': 'Retirada e Devolução',
    },
    'yfakuji7': {
      'en': 'Rental  Amount',
      'ar': 'مبلغ الإيجار',
      'es': 'Monto del alquiler',
      'pt': 'Valor do Aluguel',
    },
    'aalh5yj0': {
      'en': 'Total fees',
      'ar': 'الرسوم الكلية',
      'es': 'Tarifas totales',
      'pt': 'Taxas totais',
    },
    '57a4seeo': {
      'en': ' \$',
      'ar': '',
      'es': '',
      'pt': 'R\$',
    },
    'akx9iwst': {
      'en': 'Cancel',
      'ar': 'يلغي',
      'es': 'Cancelar',
      'pt': 'Cancelar',
    },
    'skx8itm3': {
      'en': 'Pick-up',
      'ar': 'يلتقط',
      'es': 'Levantar',
      'pt': 'Retirada',
    },
    'uc8bj374': {
      'en': 'On Road',
      'ar': 'على الطريق',
      'es': 'En la carretera',
      'pt': 'Na Estrada',
    },
    'lifp86mm': {
      'en': 'Deliver',
      'ar': 'يسلم',
      'es': 'Entregar',
      'pt': 'Entregar',
    },
    'ho6wpn9f': {
      'en': 'Home',
      'ar': 'بيت',
      'es': 'Hogar',
      'pt': 'Início',
    },
  },
  // change_password_page
  {
    'wi3e3bo4': {
      'en': 'Current Password',
      'ar': 'كلمة السر الحالية',
      'es': 'Contraseña actual',
      'pt': 'Senha Atual',
    },
    'jtz7c2zs': {
      'en': 'New Password',
      'ar': 'كلمة المرور الجديدة',
      'es': 'Nueva contraseña',
      'pt': 'Nova Senha',
    },
    'djim67wx': {
      'en': 'Confirm Password',
      'ar': 'تأكيد كلمة المرور',
      'es': 'confirmar Contraseña',
      'pt': 'Confirmar Senha',
    },
    'uowtj27v': {
      'en': 'Please  enter your old password.',
      'ar': 'الرجاء إدخال كلمة كلمة المرور القديمة.',
      'es': 'Por favor ingrese su antigua contraseña.',
      'pt': 'Por favor, insira sua senha antiga.',
    },
    '7lkd8cya': {
      'en': 'Please choose an option from the dropdown',
      'ar': 'يرجى اختيار خيار من القائمة المنسدلة',
      'es': 'Por favor elija una opción del menú desplegable',
      'pt': 'Por favor, escolha uma opção do menu',
    },
    'klck5kp1': {
      'en': 'Please enter your new password',
      'ar': 'الرجاء إدخال كلمة كلمة المرور الجديدة',
      'es': 'Por favor ingrese su nueva contraseña',
      'pt': 'Por favor, insira sua nova senha',
    },
    '7wwpw48z': {
      'en': 'Please choose an option from the dropdown',
      'ar': 'يرجى اختيار خيار من القائمة المنسدلة',
      'es': 'Por favor elija una opción del menú desplegable',
      'pt': 'Por favor, escolha uma opção do menu',
    },
    'y77y2cbb': {
      'en': 'Please enter your confirm password',
      'ar': 'الرجاء إدخال تأكيد كلمة كلمة المرور الخاصة بك',
      'es': 'Por favor ingrese su contraseña de confirmación',
      'pt': 'Por favor, confirme sua senha',
    },
    'skya6dw6': {
      'en': 'Please choose an option from the dropdown',
      'ar': 'يرجى اختيار خيار من القائمة المنسدلة',
      'es': 'Por favor elija una opción del menú desplegable',
      'pt': 'Por favor, escolha uma opção do menu',
    },
    '248m3bha': {
      'en': 'Save Changes',
      'ar': 'حفظ التغييرات',
      'es': 'Guardar cambios',
      'pt': 'Salvar Alterações',
    },
    'pmnplsci': {
      'en': 'Change Password',
      'ar': 'تغيير كلمة المرور',
      'es': 'Cambiar la contraseña',
      'pt': 'Alterar Senha',
    },
  },
  // your_favouriteList_page
  {
    'wr75d95l': {
      'en': 'Favorite ',
      'ar': 'مفضل',
      'es': 'Favorito',
      'pt': 'Favoritos',
    },
    'rswwto66': {
      'en': '\$',
      'ar': '\$',
      'es': 'ps',
      'pt': 'R\$',
    },
    'e8zle783': {
      'en': '/',
      'ar': '/',
      'es': '/',
      'pt': '/',
    },
    '0uuzgdpj': {
      'en': 'Details',
      'ar': 'تفاصيل',
      'es': 'Detalles',
      'pt': 'Detalhes',
    },
    '5k1k1q0n': {
      'en': 'Favorite',
      'ar': 'مفضل',
      'es': 'Favorito',
      'pt': 'Favoritos',
    },
  },
  // histroy_detail_page
  {
    'aexfonwp': {
      'en': '\$',
      'ar': '\$',
      'es': 'ps',
      'pt': 'R\$',
    },
    'irweqdj5': {
      'en': '/',
      'ar': '/',
      'es': '/',
      'pt': '/',
    },
    'mf4o3v9b': {
      'en': 'Review',
      'ar': 'مراجعة',
      'es': 'Revisar',
      'pt': 'Avaliação',
    },
    '0fkd0m1k': {
      'en': 'Driver Detail',
      'ar': 'تفاصيل السائق',
      'es': 'Detalle del conductor',
      'pt': 'Detalhes do Motorista',
    },
    'jin2pifz': {
      'en': 'Driver Name',
      'ar': 'اسم السائق',
      'es': 'Nombre del conductor',
      'pt': 'Nome do Motorista',
    },
    'i65ey8f8': {
      'en': 'John tomer',
      'ar': 'برامود تومر',
      'es': 'tomer pramod',
      'pt': 'João Tomer',
    },
    'z9ac1rtp': {
      'en': 'Driver Phone Number',
      'ar': 'رقم هاتف السائق',
      'es': 'Número de teléfono del conductor',
      'pt': 'Número de Telefone do Motorista',
    },
    'qwtjokhl': {
      'en': '+91 8827904769',
      'ar': '+91 8827904764',
      'es': '+91 8827904764',
      'pt': '+91 8827904769',
    },
    '880638lp': {
      'en': 'Availability',
      'ar': 'التوفر',
      'es': 'Disponibilidad',
      'pt': 'Disponibilidade',
    },
    'h87bx4ig': {
      'en': 'Minimum Days: 2 Days',
      'ar': 'الحد الأدنى للأيام: يومين',
      'es': 'Días mínimos: 2 días',
      'pt': 'Dias Mínimos: 2 Dias',
    },
    '21h5gnww': {
      'en': 'Car Seats',
      'ar': 'مقاعد السيارة',
      'es': 'Asientos de carro',
      'pt': 'Assentos do Carro',
    },
    '1ag8ozwz': {
      'en': 'Descriptions',
      'ar': 'الأوصاف',
      'es': 'Descripciones',
      'pt': 'Descrições',
    },
    'qczvar83': {
      'en': 'Features',
      'ar': 'سمات',
      'es': 'Características',
      'pt': 'Recursos',
    },
    'lochcfgh': {
      'en': 'Location',
      'ar': 'موقع',
      'es': 'Ubicación',
      'pt': 'Localização',
    },
    'a5diebah': {
      'en': 'Automatic transmission: Yes',
      'ar': 'ناقل الحركة الأوتوماتيكي: نعم',
      'es': 'Transmisión automática: Sí',
      'pt': 'Transmissão automática: Sim',
    },
    'airbags': {
      'en': 'Airbags: 6 bags ',
      'ar': 'وسائد هوائية - 6 أكياس',
      'es': 'airbags: 6 bolsas',
      'pt': 'Airbags: 6 bolsas',
    },
    'safety': {
      'en': 'Safety rating - 5 star in global NCAP ',
      'ar': 'تصنيف السلامة - 5 نجوم في NCAP العالمي',
      'es': 'Calificación de seguridad: 5 estrellas en NCAP global',
      'pt': 'Classificação de segurança - 5 estrelas no NCAP global',
    },
    'vmuwnnz6': {
      'en': 'Pickup Address',
      'ar': 'عنوان الاستلام',
      'es': 'Dirección de entrega',
      'pt': 'Endereço de Retirada',
    },
    '0ril64r9': {
      'en': 'Pickup and Return',
      'ar': 'الاستلام والعودة',
      'es': 'Recogida y devolución',
      'pt': 'Retirada e Devolução',
    },
    'q36z8wq8': {
      'en': 'Rental  Fee',
      'ar': 'رسوم الإيجار',
      'es': 'Precio de renta',
      'pt': 'Taxa de Aluguel',
    },
    'ie29xnxc': {
      'en': 'Total fees',
      'ar': 'الرسوم الكلية',
      'es': 'Tarifas totales',
      'pt': 'Taxas totais',
    },
    '88euir1v': {
      'en': ' \$',
      'ar': '800 دولار',
      'es': '\$800',
      'pt': 'R\$',
    },
    'bhxchf0e': {
      'en': 'Booking Status',
      'ar': 'وضع الحجز',
      'es': 'Estado de la reservación',
      'pt': 'Status da Reserva',
    },
    '8vsmwv6i': {
      'en': 'History Details',
      'ar': 'تفاصيل التاريخ',
      'es': 'Detalles de la historia',
      'pt': 'Detalhes do Histórico',
    },
    '0x5o6vbg': {
      'en': 'Home',
      'ar': 'بيت',
      'es': 'Hogar',
      'pt': 'Início',
    },
  },
  // settings_page
  {
    'bwhpeicr': {
      'en': 'Settings',
      'ar': 'إعدادات',
      'es': 'Ajustes',
      'pt': 'Configurações',
    },
    'sgwvfgwt': {
      'en': '         ',
      'ar': '',
      'es': '',
      'pt': '         ',
    },
    'p7fixm5n': {
      'en': 'Mode',
      'ar': 'لاوناج',
      'es': 'Lavadero',
      'pt': 'Modo',
    },
    '69inanq5': {
      'en': 'Change Password',
      'ar': 'تغيير كلمة المرور',
      'es': 'Cambiar la contraseña',
      'pt': 'Alterar Senha',
    },
    'mcmg3n10': {
      'en': 'Edit Profile',
      'ar': 'تعديل الملف الشخصي',
      'es': 'Editar perfil',
      'pt': 'Editar Perfil',
    },
    'g4vzf15u': {
      'en': 'Contact Us',
      'ar': 'اتصل بنا',
      'es': 'Contáctenos',
      'pt': 'Contate-nos',
    },
    'olr7jsxh': {
      'en': 'Language',
      'ar': 'لاوناج',
      'es': 'Lavadero',
      'pt': 'Idioma',
    },
    'dwut51nl': {
      'en': 'Account Delete',
      'ar': 'حذف الحساب',
      'es': 'Eliminar cuenta',
      'pt': 'Excluir Conta',
    },
    '837x3ooi': {
      'en': 'Logout',
      'ar': 'تسجيل خروج',
      'es': 'Cerrar sesión',
      'pt': 'Sair',
    },
    '39k73xfz': {
      'en': 'Settings',
      'ar': 'إعدادات',
      'es': 'Ajustes',
      'pt': 'Configurações',
    },
  },
  // search_page
  {
    '514qv0xu': {
      'en': 'Search',
      'ar': 'يبحث',
      'es': 'Buscar',
      'pt': 'Pesquisar',
    },
    'yy1kqgyl': {
      'en': '\$',
      'ar': '\$',
      'es': 'ps',
      'pt': 'R\$',
    },
    'lp4rn0k6': {
      'en': '/',
      'ar': '/',
      'es': '/',
      'pt': '/',
    },
    'yfptwmsw': {
      'en': 'Details',
      'ar': 'تفاصيل',
      'es': 'Detalles',
      'pt': 'Detalhes',
    },
    '2sk738dg': {
      'en': 'Home',
      'ar': '',
      'es': '',
      'pt': 'Início',
    },
  },
  // language_page
  {
    'lu5f2dgm': {
      'en': 'English',
      'ar': 'الإنجليزية',
      'es': 'Inglés',
      'pt': 'Inglês',
    },
    '0ike59t8': {
      'en': 'Arabic',
      'ar': 'العربية',
      'es': 'Árabe',
      'pt': 'Árabe',
    },
    '19zferan': {
      'en': 'Spanish',
      'ar': 'الإسبانية',
      'es': 'Español',
      'pt': 'Espanhol',
    },
    'n64id622': {
      'en': 'Language',
      'ar': 'لغة',
      'es': 'Idioma',
      'pt': 'Idioma',
    },
    'jcz9z1d6': {
      'en': 'Home',
      'ar': '',
      'es': '',
      'pt': 'Início',
    },
  },
  // intro_page
  {
    'yspnfehw': {
      'en': 'Finish',
      'ar': '',
      'es': '',
      'pt': 'Finalizar',
    },
    '29eyxxy8': {
      'en': 'Home',
      'ar': '',
      'es': '',
      'pt': 'Início',
    },
  },
  // welcome_page
  {
    'ddvcvdtl': {
      'en': 'SIGN IN',
      'ar': 'تسجيل الدخول',
      'es': 'INICIAR SESIÓN',
      'pt': 'ENTRAR',
    },
    'w845781l': {
      'en': 'SIGN UP',
      'ar': '',
      'es': '',
      'pt': 'CADASTRAR',
    },
    'mv9vs9bs': {
      'en': 'Home',
      'ar': '',
      'es': '',
      'pt': 'Início',
    },
  },
  // mobileNumberlogin_Page
  {
    'uvq08p9i': {
      'en': 'Login to\nYour Account',
      'ar': '',
      'es': '',
      'pt': 'Entrar na\nSua Conta',
    },
    'o9yq2pcp': {
      'en': 'Mobile number',
      'ar': '',
      'es': '',
      'pt': 'Número de celular',
    },
    'xrn9o5zn': {
      'en': 'Send OTP',
      'ar': '',
      'es': '',
      'pt': 'Enviar OTP',
    },
    '3zgavb3j': {
      'en': 'Login',
      'ar': '',
      'es': '',
      'pt': 'Entrar',
    },
    'ni9ejfr1': {
      'en': 'Home',
      'ar': '',
      'es': '',
      'pt': 'Início',
    },
  },
  // verificationcode_page
  {
    'mogiroi8': {
      'en': 'Page Title',
      'ar': '',
      'es': '',
      'pt': 'Título da Página',
    },
    'bpb13yc6': {
      'en': 'Home',
      'ar': '',
      'es': '',
      'pt': 'Início',
    },
  },
  // VehicalDetal
  {
    'k8jbvpcb': {
      'en': '\$',
      'ar': '\$',
      'es': 'ps',
      'pt': 'R\$',
    },
    '7d6tgj68': {
      'en': '/',
      'ar': '/',
      'es': '/',
      'pt': '/',
    },
    '3t5g5b9u': {
      'en': 'Details',
      'ar': 'تفاصيل',
      'es': 'Detalles',
      'pt': 'Detalhes',
    },
  },
  // alertControllerPage
  {
    't7dwge9a': {
      'en': 'Logout',
      'ar': 'تسجيل خروج',
      'es': 'Cerrar sesión',
      'pt': 'Sair',
    },
    'zv41jkt0': {
      'en': 'Are you sure you want to logout  this account',
      'ar': 'هل أنت متأكد أنك تريد تسجيل الخروج من هذا الحساب',
      'es': '¿Estás seguro de que deseas cerrar sesión en esta cuenta?',
      'pt': 'Tem certeza que deseja sair desta conta?',
    },
    '4zyq3u6i': {
      'en': 'Cancel',
      'ar': 'يلغي',
      'es': 'Cancelar',
      'pt': 'Cancelar',
    },
    'g1my771c': {
      'en': 'Okay',
      'ar': 'تمام',
      'es': 'Bueno',
      'pt': 'OK',
    },
  },
  // Information_column
  {
    'mecqc17c': {
      'en': 'Jhon Doe ',
      'ar': 'جون دو',
      'es': 'Jhon Doe',
      'pt': 'João Silva',
    },
    '2a6y7poe': {
      'en': 'Delhi',
      'ar': 'دلهي',
      'es': 'Delhi',
      'pt': 'Delhi',
    },
    'irbec3jt': {
      'en': '34 Mahaweer Nagarf \nDelhi',
      'ar': '34 مهاوير نجارف\nدلهي',
      'es': '34 Mahaweer Nagarf\nDelhi',
      'pt': '34 Mahaweer Nagar\nDelhi',
    },
    'y2mykieu': {
      'en': '6 KM',
      'ar': '6 كم',
      'es': '6 KM',
      'pt': '6 KM',
    },
    'uaxt9bdk': {
      'en': 'Online',
      'ar': 'متصل',
      'es': 'En línea',
      'pt': 'Online',
    },
    '52sp976p': {
      'en': '(2345)',
      'ar': '(2345)',
      'es': '(2345)',
      'pt': '(2345)',
    },
  },
  // receiver_message_page
  {
    '3nqfndpf': {
      'en':
          'I have a lot of work in the house that needs maintenance fsdkfhsdkajfsd       hl;kjshfjhkl;fjhk sjfshlksh js;hfj;ldkhdfjskhl;slkh sfdlkhsdflkh;sdfklfds hkshk j hdjlsk h;lkhjsklh sl jkl hjl hfsdlkljkhf l fdljk.  l ',
      'ar':
          'لدي أعمال كثيرة في المنزل تحتاج إلى صيانة fsdkfhsdkajfsd hl;kjshfjhkl;fjhk sjfshlksh js;hfj;ldkhdfjskhl;slkh sfdlkhsdflkh;sdfklfds hkshk j hdjlsk h;lkhjsklh sl jkl hjl hfsdlkljkhf l fdl jk. ل',
      'es':
          'Tengo mucho trabajo en la casa que necesita mantenimiento fsdkfhsdkajfsd hl;kjshfjhkl;fjhk sjfshlksh js;hfj;ldkhdfjskhl;slkh sfdlkhsdflkh;sdfklfds hkshk j hdjlsk h;lkhjsklh sl jkl hjl hfsdlkljkhf l f dljk. yo',
      'pt': 'Tenho muito trabalho na casa que precisa de manutenção. Preciso de ajuda com algumas tarefas domésticas e reparos.',
    },
  },
  // sender_message_page
  {
    'j29afkuc': {
      'en':
          'I have a lot of work in the house that needs maintenance fsdkfhsdkajfsd hgsdjkghdkljghsdkdljgh dldjks gdghkjdfh dkdjlsgh lghdslkdslfdgkdsglkdjhs lh gkldj hdsklg hdsdkgjl hdskjhfshkgjh sglhkdjsghdg',
      'ar':
          'لدي أعمال كثيرة في المنزل تحتاج إلى صيانة fsdkfhsdkajfsd hgsdjkghdkljghsdkdljgh dldjks gdghkjdfh dkdjlsgh lghdslkdslfdgkdsglkdjhs lh gkldj hdsklg hdsdkgjl hdskjhfshkgjh sglhkdjsghdg',
      'es':
          'Tengo mucho trabajo en la casa que necesita mantenimiento fsdkfhsdkajfsd hgsdjkghdkljghsdkdljgh dldjks gdghkjdfh dkdjlsgh lghdslkdslfdgkdsglkdjhs lh gkldj hdsklg hdsdkgjl hdskjhfshkgjh sglhkdjsghdg',
      'pt': 'Tenho muito trabalho na casa que precisa de manutenção. Preciso de ajuda com algumas tarefas domésticas e reparos urgentes.',
    },
  },
  // send_message
  {
    'd2uzlc4y': {
      'en': 'Type message',
      'ar': 'اكتب الرسالة',
      'es': 'Escribe mensaje',
      'pt': 'Digite a mensagem',
    },
  },
  // alertCancelPage
  {
    'n968vjav': {
      'en': 'Notice',
      'ar': 'يلاحظ',
      'es': 'Aviso',
      'pt': 'Aviso',
    },
    'yqlhvd8z': {
      'en': 'Are you sure you want to cancel  this booking',
      'ar': 'هل أنت متأكد أنك تريد إلغاء هذا الحجز',
      'es': '¿Estás seguro de que quieres cancelar esta reserva?',
      'pt': 'Tem certeza que deseja cancelar esta reserva?',
    },
    'dpummdq7': {
      'en': 'Cancel',
      'ar': 'يلغي',
      'es': 'Cancelar',
      'pt': 'Cancelar',
    },
    '8qfzm4fr': {
      'en': 'Okay',
      'ar': 'تمام',
      'es': 'Bueno',
      'pt': 'OK',
    },
  },
  // alertControllerBackPage
  {
    'lk4gv59a': {
      'en': 'Notice',
      'ar': 'يلاحظ',
      'es': 'Aviso',
      'pt': 'Aviso',
    },
    'glrp0tgn': {
      'en': 'Okay',
      'ar': 'تمام',
      'es': 'Bueno',
      'pt': 'OK',
    },
  },
  // alertAccountDelete
  {
    'j8l4d67u': {
      'en': 'Delete My Account',
      'ar': 'احذف حسابي',
      'es': 'borrar mi cuenta',
      'pt': 'Excluir Minha Conta',
    },
    'fwge82n8': {
      'en': 'Are you sure do you want to permanently delete your account ?',
      'ar': 'هل أنت متأكد أنك تريد ذلك حذف حسابك نهائيا؟',
      'es': '¿Estás seguro de que quieres ¿Eliminar permanentemente tu cuenta?',
      'pt': 'Tem certeza que deseja excluir permanentemente sua conta?',
    },
    'cuuxlwr3': {
      'en': 'Cancel',
      'ar': 'يلغي',
      'es': 'Cancelar',
      'pt': 'Cancelar',
    },
    '01fon2ld': {
      'en': 'Okay',
      'ar': 'تمام',
      'es': 'Bueno',
      'pt': 'OK',
    },
  },
  // RatingViewPage
  {
    'wdgzac1m': {
      'en': 'Please Share your Rating',
      'ar': 'يرجى مشاركة تقييمك',
      'es': 'Por favor comparte tu calificación',
      'pt': 'Por favor, compartilhe sua avaliação',
    },
    'u0764vh7': {
      'en': 'Submit',
      'ar': 'يُقدِّم',
      'es': 'Entregar',
      'pt': 'Enviar',
    },
  },
  // Mode_screen
  {
    'qbiecm3r': {
      'en': 'Light Mode',
      'ar': '',
      'es': '',
      'pt': 'Modo Claro',
    },
    's39meop0': {
      'en': 'Dark Mode',
      'ar': '',
      'es': '',
      'pt': 'Modo Escuro',
    },
  },
  // Miscellaneous
  {
    'vsrx4w4a': {
      'en':
          'In order to take a picture or video, this app requires permission to access the camera.',
      'ar':
          'لالتقاط صورة أو مقطع فيديو، يتطلب هذا التطبيق إذنًا للوصول إلى الكاميرا.',
      'es':
          'Para tomar una foto o grabar un video, esta aplicación requiere permiso para acceder a la cámara.',
      'pt': 'Para tirar uma foto ou gravar um vídeo, este aplicativo requer permissão para acessar a câmera.',
    },
    '0idnvf4q': {
      'en':
          'In order to upload data, this app requires permission to access the photo library.',
      'ar':
          'من أجل تحميل البيانات، يتطلب هذا التطبيق إذنًا للوصول إلى مكتبة الصور.',
      'es':
          'Para cargar datos, esta aplicación requiere permiso para acceder a la biblioteca de fotos.',
      'pt': 'Para fazer upload de dados, este aplicativo requer permissão para acessar a biblioteca de fotos.',
    },
    'yvtoshqx': {
      'en': '',
      'ar': '',
      'es': '',
      'pt': '',
    },
    '0guyzszu': {
      'en': '',
      'ar': '',
      'es': '',
      'pt': '',
    },
    'quwk9rko': {
      'en': '',
      'ar': '',
      'es': '',
      'pt': '',
    },
    '4ta0yx4j': {
      'en': '',
      'ar': '',
      'es': '',
      'pt': '',
    },
    '252wmib8': {
      'en': '',
      'ar': '',
      'es': '',
      'pt': '',
    },
    's3lgufym': {
      'en': '',
      'ar': '',
      'es': '',
      'pt': '',
    },
    'x3ql454q': {
      'en': '',
      'ar': '',
      'es': '',
      'pt': '',
    },
    '7t82j6u5': {
      'en': '',
      'ar': '',
      'es': '',
      'pt': '',
    },
    'k1eesspb': {
      'en': '',
      'ar': '',
      'es': '',
      'pt': '',
    },
    'i7wrquzv': {
      'en': '',
      'ar': '',
      'es': '',
      'pt': '',
    },
    'e8i89wgq': {
      'en': '',
      'ar': '',
      'es': '',
      'pt': '',
    },
    'li9jtfbf': {
      'en': '',
      'ar': '',
      'es': '',
      'pt': '',
    },
    'pxowvbgg': {
      'en': '',
      'ar': '',
      'es': '',
      'pt': '',
    },
    'g8u718la': {
      'en': '',
      'ar': '',
      'es': '',
      'pt': '',
    },
    'ujcpo7aq': {
      'en': '',
      'ar': '',
      'es': '',
      'pt': '',
    },
    'ajnyijdi': {
      'en': '',
      'ar': '',
      'es': '',
      'pt': '',
    },
    '9c71o3tg': {
      'en': '',
      'ar': '',
      'es': '',
      'pt': '',
    },
    'wi34mmmt': {
      'en': '',
      'ar': '',
      'es': '',
      'pt': '',
    },
    'giagrldv': {
      'en': '',
      'ar': '',
      'es': '',
      'pt': '',
    },
    'ljph6mrv': {
      'en': '',
      'ar': '',
      'es': '',
      'pt': '',
    },
    'd3kypjks': {
      'en': '',
      'ar': '',
      'es': '',
      'pt': '',
    },
    'oo8tt1tw': {
      'en': '',
      'ar': '',
      'es': '',
      'pt': '',
    },
    'mvgawvx0': {
      'en': '',
      'ar': '',
      'es': '',
      'pt': '',
    },
    '6bdthdpo': {
      'en': '',
      'ar': '',
      'es': '',
      'pt': '',
    },
  },
  // ... existing code ...
  {
    'email_label': {
      'en': 'Email',
      'ar': 'البريد الإلكتروني',
      'es': 'Correo electrónico',
      'pt': 'E-mail',
    },
    'enter_email_hint': {
      'en': 'Enter your email id',
      'ar': 'أدخل بريدك الإلكتروني',
      'es': 'Ingrese su correo electrónico',
      'pt': 'Digite seu e-mail',
    },
    'full_name_label': {
      'en': 'Full Name',
      'ar': 'الاسم الكامل',
      'es': 'Nombre completo',
      'pt': 'Nome completo',
    },
    'enter_full_name_hint': {
      'en': 'Enter your full name',
      'ar': 'أدخل اسمك الكامل',
      'es': 'Ingrese su nombre completo',
      'pt': 'Digite seu nome completo',
    },
  },
  {
    'phone_number_label': {
      'en': 'Phone Number',
      'ar': 'رقم الهاتف',
      'es': 'Número de teléfono',
      'pt': 'Número de Telefone',
    },
    'enter_phone_number_hint': {
      'en': 'Enter your phone number',
      'ar': 'أدخل رقم هاتفك',
      'es': 'Ingrese su número de teléfono',
      'pt': 'Digite seu número de telefone',
    },
    'password_label': {
      'en': 'Password',
      'ar': 'كلمة المرور',
      'es': 'Contraseña',
      'pt': 'Senha',
    },
    'enter_password_hint': {
      'en': 'Enter your password',
      'ar': 'أدخل كلمة المرور',
      'es': 'Ingrese su contraseña',
      'pt': 'Digite sua senha',
    },
    'confirm_password_label': {
      'en': 'Confirm Password',
      'ar': 'تأكيد كلمة المرور',
      'es': 'Confirmar contraseña',
      'pt': 'Confirmar senha',
    },
    'enter_confirm_password_hint': {
      'en': 'Enter your confirm password',
      'ar': 'أدخل تأكيد كلمة المرور',
      'es': 'Ingrese su confirmación de contraseña',
      'pt': 'Digite sua confirmação de senha',
    },
    'next_button': {
      'en': 'Next',
      'ar': 'التالي',
      'es': 'Siguiente',
      'pt': 'Próximo',
    },
    'get_started_button': {
      'en': 'Get Started',
      'ar': 'ابدأ الآن',
      'es': 'Comenzar',
      'pt': 'Começar',
    },
  },
  {
    'search_label': {
      'en': 'Search',
      'ar': 'بحث',
      'es': 'Buscar',
      'pt': 'Pesquisar',
    },
    'search_hint': {
      'en': 'Start typing to search',
      'ar': 'ابدأ الكتابة للبحث',
      'es': 'Empiece a escribir para buscar',
      'pt': 'Comece a digitar para pesquisar',
    },
    'okay_button': {
      'en': 'Okay',
      'ar': 'موافق',
      'es': 'Aceptar',
      'pt': 'Ok',
    },
    'notice_title': {
      'en': 'Notice',
      'ar': 'تنبيه',
      'es': 'Aviso',
      'pt': 'Aviso',
    },
    'already_have_account': {
      'en': 'Already have an account?',
      'ar': 'لديك حساب بالفعل؟',
      'es': '¿Ya tienes una cuenta?',
      'pt': 'Já tem uma conta?',
    },
    'sign_in_button': {
      'en': 'Sign In',
      'ar': 'تسجيل الدخول',
      'es': 'Iniciar sesión',
      'pt': 'Entrar',
    },
    'create_account_title': {
      'en': 'Create a new account and start car rental with ease',
      'ar': 'أنشئ حسابًا جديدًا وابدأ استئجار السيارات بسهولة',
      'es': 'Crea una nueva cuenta y comienza a alquilar coches fácilmente',
      'pt': 'Crie uma nova conta e comece a alugar carros com facilidade',
    },
    'create_title': {
      'en': 'create',
      'ar': 'إنشاء',
      'es': 'crear',
      'pt': 'criar',
    },
    'hey_user': {
      'en': 'Hey,User',
      'ar': 'مرحباً، المستخدم',
      'es': 'Hola, Usuario',
      'pt': 'Olá, Usuário',
    },
    'hey_name': {
      'en': 'Hey,',
      'ar': 'مرحباً،',
      'es': 'Hola,',
      'pt': 'Olá,',
    },
    'see_all_button': {
      'en': 'See All',
      'ar': 'عرض الكل',
      'es': 'Ver todo',
      'pt': 'Ver todos',
    },
    'available_cars': {
      'en': 'Available Cars',
      'ar': 'السيارات المتاحة',
      'es': 'Coches disponibles',
      'pt': 'Carros disponíveis',
    },
    'available_now': {
      'en': 'Available now',
      'ar': 'متاح الآن',
      'es': 'Disponible',
      'pt': 'Liberado',
    },
    'promo_codes': {
      'en': 'Promo Codes',
      'ar': 'رموز الترويج',
      'es': 'Códigos promocionales',
      'pt': 'Códigos promocionais',
    },
    'no_cars_available': {
      'en': 'No Car Available in this Category',
      'ar': 'لا توجد سيارات متاحة في هذه الفئة',
      'es': 'No hay coches disponibles en esta categoría',
      'pt': 'Nenhum carro disponível nesta categoria',
    },
    'no_data': {
      'en': 'NO DATA',
      'ar': 'لا توجد بيانات',
      'es': 'SIN DATOS',
      'pt': 'SEM DADOS',
    },
    'seater': {
      'en': 'Seater',
      'ar': 'مقاعد',
      'es': 'Asientos',
      'pt': 'Assentos',
    },
    'kilometer': {
      'en': 'km',
      'ar': 'كم',
      'es': 'km',
      'pt': 'km',
    },
    'all_cars': {
      'en': 'All Cars',
      'ar': 'جميع السيارات',
      'es': 'Todos',
      'pt': 'Todos',
    },
    'price_type_day': {
      'en': 'Day',
      'ar': 'يوم',
      'es': 'Día',
      'pt': 'Dia',
    },
    'price_type_hour': {
      'en': 'Hourly',
      'ar': 'بالساعة',
      'es': 'Por hora',
      'pt': 'Por hora',
    },
    'price_type_week': {
      'en': 'Week',
      'ar': 'أسبوع',
      'es': 'Semana',
      'pt': 'Semana',
    },
    'price_type_month': {
      'en': 'Month',
      'ar': 'شهر',
      'es': 'Mes',
      'pt': 'Mês',
    },
    'currency_symbol': {
      'en': '\$',
      'ar': 'د.إ',
      'es': '€',
      'pt': 'R\$',
    },
    'filter_button': {
      'en': 'Filter',
      'ar': 'تصفية',
      'es': 'Filtrar',
      'pt': 'Filtrar',
    },
    'redeem_code': {
      'en': 'Redeem Code',
      'ar': 'رمز الاسترداد',
      'es': 'Código de Canje',
      'pt': 'Código de Resgate',
    },
    'expired_status': {
      'en': 'Expired',
      'ar': 'منتهي الصلاحية',
      'es': 'Expirado',
      'pt': 'Expirado',
    },
    'coupon_copied': {
      'en': 'Coupon code copied to clipboard',
      'ar': 'تم نسخ رمز القسيمة إلى الحافظة',
      'es': 'Código de cupón copiado al portapapeles',
      'pt': 'Código do cupom copiado para a área de transferência',
    },
    'available_cars_in': {
      'en': 'Available Cars in',
      'ar': 'السيارات المتوفرة في',
      'es': 'Coches disponibles en',
      'pt': 'Carros disponíveis em',
    },
    'apply_button': {
      'en': 'Apply',
      'ar': 'تطبيق',
      'es': 'Aplicar',
      'pt': 'Aplicar',
    },
    'applied_status': {
      'en': 'Applied',
      'ar': 'تم التطبيق',
      'es': 'Aplicado',
      'pt': 'Aplicado',
    },
    'coupon_amount': {
      'en': 'Coupon Amount',
      'ar': 'قيمة القسيمة',
      'es': 'Importe del cupón',
      'pt': 'Valor do cupom',
    },
    'saved_cars': {
      'en': 'Saved Cars',
      'pt': 'Carros Favoritos',
      'es': 'Coches Guardados',
      'ar': 'السيارات المحفوظة',
    },
    'no_data': {
      'en': 'No Data',
      'pt': 'Sem Carros Salvos',
      'es': 'Sin Datos',
      'ar': 'لا توجد بيانات',
    },
  },
  {
    'add_list': {
      'en': 'Add List',
      'pt': 'Favoritar',
      'es': 'Agregar Lista',
      'ar': 'إضافة قائمة',
    },
  },
].reduce((a, b) => a..addAll(b));
