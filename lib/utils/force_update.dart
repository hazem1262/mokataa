import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mokataa/utils/remote_config/remote_config.dart';
import 'package:mokataa/utils/remote_config/remote_config_keys.dart';
import 'package:mokataa/utils/style/colors.dart';
import 'package:mokataa/utils/style/text_style.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../main.dart';

Future<bool> checkForceUpdate() async {
  final remoteConfig = RemoteConfigImplementation();
  await remoteConfig.initRemoteConfig();
  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  int androidVersion = remoteConfig.getInt(RemoteConfigKeys.forceUpdateAndroidVersion);
  int iosVersion = remoteConfig.getInt(RemoteConfigKeys.forceUpdateIosVersion);

  if (Platform.isAndroid) {
    return int.parse(packageInfo.buildNumber) < androidVersion;
  } else if (Platform.isIOS) {
    return int.parse(packageInfo.buildNumber) < iosVersion;
  }
  return false;
}

void showForceUpdateDialog() async {
  final remoteConfig = RemoteConfigImplementation();
  Uri appStoreUrl = Uri.parse(remoteConfig.getString(key: RemoteConfigKeys.forceUpdateIosUrl));
  Uri playStoreUrl = Uri.parse(remoteConfig.getString(key: RemoteConfigKeys.forceUpdateAndroidUrl));
  await showDialog<String>(
    context: navigationKey.currentContext!,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        insetPadding: const EdgeInsets.all(10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
        title: Text(
          'لتجربة أفضل !',
          style: urbanistMedium(color: AppColors.gray25, fontSize: 24),
          textAlign: TextAlign.center,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
                'يرجى تحديث التطبيق إلى النسخة الجديدة',
                style: urbanistMedium(color: AppColors.gray25, fontSize: 18),
                textAlign: TextAlign.center
            ),
            Padding(
              padding: const EdgeInsetsDirectional.only(top: 20),
              child: TextButton(
                style: ButtonStyle(
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  )),
                  backgroundColor: MaterialStateProperty.all(AppColors.gray25),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 65.0, vertical: 4),
                  child: Text(
                    'موافق',
                    style: urbanistMedium(color: Colors.white, fontSize: 16),
                  ),
                ),
                onPressed: () async {
                  if (Platform.isIOS) {
                    _launchURL(appStoreUrl);
                  } else {
                    _launchURL(playStoreUrl);
                  }
                },
              ),
            ),
          ],
        ),
      );
    },
  );
}

_launchURL(Uri url) async {
  if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
    throw 'Could not launch $url';
  }
}

showForceUpdateIfNeeded() async {
  if(await checkForceUpdate()) {
    showForceUpdateDialog();
  }
}