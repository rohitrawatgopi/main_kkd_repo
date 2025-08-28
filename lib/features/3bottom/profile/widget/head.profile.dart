import 'package:paint_shop/app/import.dart';
import 'package:paint_shop/features/4lang/lang.cubit.dart';

class CustomProfileHead extends StatelessWidget {
  final dynamic user;

  const CustomProfileHead({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currentLocale = context.watch<LanguageCubit>().state.languageCode;
    return ListTile(
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          DropdownButton<String>(
            value: currentLocale,
            items: const [
              DropdownMenuItem(value: 'en', child: Text('English')),
              DropdownMenuItem(value: 'hi', child: Text('हिंदी')),
            ],
            onChanged: (String? lang) {
              if (lang != null) {
                context.read<LanguageCubit>().changeLanguage(lang);
              }
            },
          ),
          Gap(10.w),
          InkWell(
            onTap: () => showLogoutDialog(context),
            child: Icon(Icons.logout, color: AppColors.red),
          ),
        ],
      ),
      horizontalTitleGap: 10.0.w,
      minLeadingWidth: 1,
      leading: GestureDetector(
        onTap: () {
          showDialog(
            context: context,
            barrierDismissible: true,
            builder: (dialogContext) => Dialog(
              backgroundColor: Colors.transparent,
              insetPadding: EdgeInsets.zero,
              child: GestureDetector(
                onTap: () =>
                    Navigator.of(dialogContext, rootNavigator: true).pop(),
                child: Container(
                  height: 250.h,
                  width: 250.w,
                  child: Hero(
                    tag: "imageHero",
                    child: CachedNetworkImage(
                      imageUrl:
                          user.profilePick ?? "https://dummyimage.com/100x100",
                      fit: BoxFit.contain,
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error, color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
          );
        },

        child: Hero(
          tag: "imageHero",
          child: SizedBox(
            width: 48.w,
            height: 48.h,
            child: ClipOval(
              child: CachedNetworkImage(
                cacheManager: MyCacheManager.instance,
                imageUrl: user.profilePick ?? "https://dummyimage.com/100x100",
                fit: BoxFit.cover,
                errorWidget: (context, url, error) =>
                    CircleAvatar(child: Icon(Icons.error)),
                progressIndicatorBuilder: (context, url, progress) => Center(
                  child: Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: CircleAvatar(radius: 80.r),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      title: AppText(
        title: user.fullName ?? '',
        fontSize: 18,
        fontWeight: FontWeight.w500,
        maxLine: 1,
        textOverflow: TextOverflow.ellipsis,
      ),
    );
  }
}

class SecondScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Second Screen')),
      body: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Center(
          child: Hero(
            tag: 'imageHero',
            child: Image.network('https://example.com/image.jpg'),
          ),
        ),
      ),
    );
  }
}
