import 'package:paint_shop/app/import.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageCubit extends Cubit<Locale> {
  LanguageCubit() : super(const Locale('en'));

  void changeLanguage(String languageCode) async {
    final newLocale = Locale(languageCode);
    emit(newLocale);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('languageCode', languageCode);
  }

  void loadSavedLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    final langCode = prefs.getString('languageCode') ?? 'en';
    emit(Locale(langCode));
  }
}
