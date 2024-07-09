import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/services.dart';
import 'package:flutter_feature_platform/src/data/exception/feature_platform_exception.dart';
import 'package:flutter_feature_platform/src/data/repository/feature_platform_repository.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:platform_device_id_v3/platform_device_id.dart';

class FeaturePlatformRepositoryImpl extends FeaturePlatformRepository {
  @override
  Future<String> getUserAgent() async {
    final packageInfo = await PackageInfo.fromPlatform();
    final deviceInfo = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      final androidInfo = await deviceInfo.androidInfo;
      return '${packageInfo.appName}/${packageInfo.version}(${packageInfo.buildNumber}); Android ${androidInfo.version.release}/${androidInfo.manufacturer}/${androidInfo.model}';
    } else if (Platform.isIOS) {
      final iosInfo = await deviceInfo.iosInfo;
      return '${packageInfo.appName}/${packageInfo.version}(${packageInfo.buildNumber}); iOS ${iosInfo.systemName}/${iosInfo.systemVersion}';
    }
    return 'Unknown';
  }

  @override
  Future<String> getDeviceId() async {
    try {
      final deviceId = await PlatformDeviceId.getDeviceId;
      if (deviceId == null) {
        throw FeaturePlatformException(code: 'DEVICE_ID_MISSING', message: 'Device ID Missing');
      }
      return deviceId;
    } on PlatformException catch (e) {
      throw FeaturePlatformException(code: e.code, message: e.message ?? '-');
    } catch (e) {
      throw FeaturePlatformException(code: 'OTHER', message: '$e');
    }
  }
}
