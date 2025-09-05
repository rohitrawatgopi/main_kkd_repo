import 'package:paint_shop/app/import.dart';
import 'package:paint_shop/features/3bottom/product/widget/search/cubit/search.product.cubit.dart';
import 'package:paint_shop/l10n/app_localizations.dart';

class AppSearchContainer extends StatelessWidget {
  final String? hintText;

  final String image;
  final VoidCallback ontab;

  AppSearchContainer({
    Key? key,
    required this.ontab,
    this.hintText,

    required this.image,
  }) : super(key: key);
  final TextEditingController searchContoller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    performSearch(String value) {
      ProductSearchCubit.page1 = 1;
      context.read<ProductSearchCubit>().searchProduct(searchContoller.text);

      context.push("/search", extra: searchContoller.text);
      searchContoller.text = "";
    }

    return Row(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,

          children: [
            Container(
              width: 287.w,
              height: 40.h,

              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(36.r),
              ),

              child: AppTextField(
                textAlignVertical: TextAlignVertical.center,
                contentPadding: EdgeInsets.symmetric(
                  vertical: 0,
                  horizontal: 32.h,
                ), // 👈 fix
                textAlign: TextAlign.left,
                bgColor: Colors.white,
                hintStyle: TextStyle(
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
                onFieldSubmitted: (val) async {
                  if (searchContoller.text.isNotEmpty) {
                    performSearch(searchContoller.text);
                    FocusScope.of(
                      context,
                    ).unfocus(); // 👈 tap search par bhi focus hatana
                  }
                },
                keyBoardType: TextInputType.webSearch,
                prefixIcon: InkWell(
                  onTap: () {
                    if (searchContoller.text.isNotEmpty) {
                      performSearch(searchContoller.text);
                      FocusScope.of(
                        context,
                      ).unfocus(); // 👈 tap search par bhi focus hatana
                    }
                  },
                  child: Icon(Icons.search, size: 20.w),
                ),
                controller: searchContoller,
                fontSize: 12.sp,
                hintText: AppLocalizations.of(context)!.search,
                isCollapsed: true,
              ),
            ),
            Gap(10.w, color: Colors.transparent),
            InkWell(
              onTap: ontab,
              child: Container(
                height: 40.h,
                width: 40.w,
                padding: EdgeInsets.all(10.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Center(
                  child: SvgPicture.asset(
                    image,
                    height: 20.h,
                    width: 20.h,
                    fit: BoxFit.scaleDown,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
