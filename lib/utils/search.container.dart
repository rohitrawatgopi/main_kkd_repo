import 'package:paint_shop/app/import.dart';
import 'package:paint_shop/features/3bottom/product/widget/search/cubit/search.product.cubit.dart';
import 'package:paint_shop/l10n/app_localizations.dart';

class AppSearchContainer extends StatelessWidget {
  final String? hintText;

  final String image;
  final VoidCallback ontab;

  const AppSearchContainer({
    Key? key,
    required this.ontab,
    this.hintText,

    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController _searchContoller = TextEditingController();
    _performSearch(String value) {
      context.read<ProductSearchCubit>().searchProduct(_searchContoller.text);

      context.push("/search", extra: _searchContoller.text);
      _searchContoller.text = "";
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
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
              padding: EdgeInsets.fromLTRB(15.w, 11.h, 10.w, 11.h),
              child: AppTextField(
                hintStyle: TextStyle(
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
                onFieldSubmitted: (val) async {
                  _performSearch(val);
                },
                keyBoardType: TextInputType.webSearch,
                prefixIcon: InkWell(
                  onTap: () {
                    _performSearch(_searchContoller.text);
                  },
                  child: Icon(Icons.search, size: 20.w),
                ),
                controller: _searchContoller,
                fontSize: 12.sp,
                hintText: AppLocalizations.of(context)!.search,
                isCollapsed: true,
                contentPadding: EdgeInsets.zero,
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
