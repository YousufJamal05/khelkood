import 'dart:convert';
import 'dart:io' show Platform;

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Provider to initialize device info (runs once and caches result)
final FutureProvider<void> deviceInfoProvider = FutureProvider<void>((
  ref,
) async {
  final deviceInfoPlugin = DeviceInfoPlugin();

  try {
    Map<String, dynamic> deviceDetails = {};

    if (kIsWeb) {
      final webBrowserInfo = await deviceInfoPlugin.webBrowserInfo;
      deviceDetails = {
        'Browser Name': webBrowserInfo.browserName.toString(),
        'UserAgent': webBrowserInfo.userAgent,
        'AppName': webBrowserInfo.appName,
        'AppVersion': webBrowserInfo.appVersion,
        'AppCodeName': webBrowserInfo.appCodeName,
        'AppVendor': webBrowserInfo.vendor,
        'AppLanguage': webBrowserInfo.language,
        'AppLanguageVersion': webBrowserInfo.language,
      };
    } else {
      // Use try-catch to safely access Platform on native platforms
      try {
        // Determine platform OS safely
        String? os;
        try {
          os = Platform.operatingSystem;
        } catch (e) {
          debugPrint('Failed to access Platform.operatingSystem: $e');
          os = 'unknown';
        }

        // Use switch case for native platforms based on device_info_plus
        if (os == 'android') {
          final androidInfo = await deviceInfoPlugin.androidInfo;
          deviceDetails = {
            'OS': 'Android',
            'Version': androidInfo.version.release,
            'API Level': androidInfo.version.sdkInt,
            'Model': androidInfo.model,
            'Brand': androidInfo.brand,
            'Manufacturer': androidInfo.manufacturer,
            'Device': androidInfo.device,
            'Product': androidInfo.product,
            'Hardware': androidInfo.hardware,
            'Fingerprint': androidInfo.fingerprint,
            'Is Emulator': androidInfo.isPhysicalDevice,
            'Total Disk Size (Bytes)': androidInfo.totalDiskSize,
            'Free Disk Space (Bytes)': androidInfo.freeDiskSize,
          };
        } else if (os == 'ios') {
          final iosInfo = await deviceInfoPlugin.iosInfo;
          deviceDetails = {
            'OS': 'iOS',
            'System Version': iosInfo.systemVersion,
            'Model': iosInfo.model,
            'Name': iosInfo.name,
            'System Name': iosInfo.systemName,
            'Localized Model': iosInfo.localizedModel,
            'Is Simulator': !iosInfo.isPhysicalDevice,
            'Total Disk Size (Bytes)': iosInfo.totalDiskSize,
            'Free Disk Space (Bytes)': iosInfo.freeDiskSize,
          };
        } else if (os == 'windows') {
          final windowsInfo = await deviceInfoPlugin.windowsInfo;
          deviceDetails = {
            'OS': 'Windows',
            'Display Version': windowsInfo.displayVersion,
            'Computer Name': windowsInfo.computerName,
            'User Name': windowsInfo.userName,
            'Number of Cores': windowsInfo.numberOfCores,
            'System Memory (MB)': windowsInfo.systemMemoryInMegabytes,
            'Device ID': windowsInfo.deviceId,
            'Product Name': windowsInfo.productName,
          };
        } else if (os == 'linux') {
          final linuxInfo = await deviceInfoPlugin.linuxInfo;
          deviceDetails = {
            'OS': 'Linux',
            'Version': linuxInfo.version,
            'Machine ID': linuxInfo.machineId,
            'Pretty Name': linuxInfo.prettyName,
            'ID': linuxInfo.id,
            'Name': linuxInfo.name,
            'Version ID': linuxInfo.versionId,
            'Build ID': linuxInfo.buildId,
          };
        } else if (os == 'macos') {
          final macInfo = await deviceInfoPlugin.macOsInfo;
          deviceDetails = {
            'OS': 'macOS',
            'OS Release': macInfo.osRelease,
            'Computer Name': macInfo.computerName,
            'Model': macInfo.model,
            'Kernel Version': macInfo.kernelVersion,
            'Major Version': macInfo.majorVersion,
            'Minor Version': macInfo.minorVersion,
            'Patch Version': macInfo.patchVersion,
            'Active CPUs': macInfo.activeCPUs,
            'Memory Size': macInfo.memorySize,
            'CPU Frequency': macInfo.cpuFrequency,
          };
        } else {
          deviceDetails = {'Platform': os ?? 'unknown'};
        }
      } catch (e) {
        debugPrint('Failed to load device info on native platform: $e');
        deviceDetails = {'Platform': 'unknown', 'Error': e.toString()};
      }
    }

    debugPrint(
      'Device info loaded: \n${const JsonEncoder.withIndent('  ').convert(deviceDetails)}',
    );
  } catch (e) {
    debugPrint('Failed to load device info: $e');
  }
});
