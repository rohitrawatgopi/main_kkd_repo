import 'package:intl/intl.dart';
import 'package:paint_shop/app/import.dart';
import 'package:paint_shop/core/model/qr.model.dart';
import 'package:paint_shop/features/3bottom/qr/cubit/qr.cubit.dart';
import 'package:paint_shop/l10n/app_localizations.dart';

class QrScarrenWidget {
  static Widget succesCoinAlertDilogBox({required context, required conin}) {
    return Container(
      height: 331.h,
      width: 317.w,
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(32.r)),
      child: Stack(
        children: [
          Positioned(
            top: -15,
            right: -5,
            child: IconButton(
              onPressed: () {
                ScannerCubit.isScanning = true;
                Navigator.of(context).pop();
              },
              icon: Icon(Icons.close, size: 30.w),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Gap(30.h),
              AppText(
                textAlign: TextAlign.center,
                title: AppLocalizations.of(context)!.congratulations,
                fontWeight: FontWeight.w500,
                height: 1,
                fontSize: 24.sp,
              ),
              const SizedBox(height: 24),
              Image.asset(
                AppImage.dollar,
                height: 100.h,
                width: 100.w,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 14),
              AppText(
                textAlign: TextAlign.center,
                title: conin + " coins",
                fontWeight: FontWeight.w700,
                fontSize: 24.sp,
                height: 1,
              ),
              Gap(15.h),
              AppText(
                title: AppLocalizations.of(context)!.haveBeenAddedToWallet,
                fontWeight: FontWeight.w500,
                fontSize: 14.sp,
                height: 1,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ],
      ),
    );
  }

  static Widget unSuccessCoinAlertDilogBox({
    required context,
    required QrScanDataModel qrScanDataModel,
  }) {
    String original = qrScanDataModel.scannedAt.toString();

    final dateTime = DateTime.parse(original);
    String formatted = DateFormat('dd MMMM yyyy').format(dateTime);

    return Container(
      height: 328.h,
      width: 317.w,
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(32.r)),
      child: Stack(
        children: [
          Positioned(
            top: -15,
            right: -5,
            child: IconButton(
              onPressed: () {
                ScannerCubit.isScanning = true;
                Navigator.of(context).pop();
              },
              icon: Icon(Icons.close, size: 30.w),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Gap(30.h),
              AppText(
                textAlign: TextAlign.center,
                title: AppLocalizations.of(context)!.oops,
                fontWeight: FontWeight.w500,
                height: 1,
                fontSize: 24.sp,
              ),
              const SizedBox(height: 24),
              Image.asset(
                AppImage.wrong,
                height: 80.h,
                width: 80.w,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 14),
              AppText(
                textAlign: TextAlign.center,
                title: AppLocalizations.of(
                  context,
                )!.thisQrCodeHasAlreadyBeenUsedBy,
                fontWeight: FontWeight.w400,
                fontSize: 16.sp,

                height: 1.5,
              ),

              ReqAppText(
                title: "",

                title2: (qrScanDataModel.scannedByName ?? '').length > 12
                    ? qrScanDataModel.scannedByName!.substring(0, 12) + ".."
                    : qrScanDataModel.scannedByName ?? '',

                title3: " on ",

                title4: formatted,
                fontSize4: 16,
                fontSize2: 16,

                fontWeight2: FontWeight.w600,
                fontWeight4: FontWeight.w600,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
