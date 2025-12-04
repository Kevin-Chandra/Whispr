import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:whispr/di/di_config.dart';
import 'package:whispr/presentation/bloc/home/home_cubit.dart';
import 'package:whispr/presentation/bloc/settings/settings_cubit.dart';
import 'package:whispr/presentation/router/router_config.gr.dart';
import 'package:whispr/presentation/themes/colors.dart';
import 'package:whispr/presentation/themes/text_styles.dart';
import 'package:whispr/presentation/widgets/whispr_settings_item.dart';
import 'package:whispr/util/extensions.dart';

@RoutePage()
class SettingsScreen extends StatefulWidget implements AutoRouteWrapper {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider<SettingsCubit>(
      create: (context) => SettingsCubit(),
      child: this,
    );
  }
}

class _SettingsScreenState extends State<SettingsScreen> {
  late final SettingsCubit _settingsCubit;
  late final HomeCubit _homeCubit;
  StreamSubscription<bool>? _settingsValueSubscription;

  @override
  void initState() {
    super.initState();
    _settingsCubit = context.read<SettingsCubit>();
    _homeCubit = context.read<HomeCubit>();
    _settingsValueSubscription = _settingsCubit.appLockStream.listen((enabled) {
      _homeCubit.refreshAppLockEnabled();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: 8,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              context.strings.privacyAndSecurity,
              style: WhisprTextStyles.heading5
                  .copyWith(color: WhisprColors.spanishViolet),
              textAlign: TextAlign.start,
            ),
          ),
          StreamBuilder(
            stream: _settingsCubit.appLockStream,
            builder: (context, snapshot) {
              return WhisprSettingsItem(
                label: context.strings.appLock,
                onClick: null,
                style: WhisprSettingsItemStyle.toggleable,
                value: snapshot.data,
                onToggle: _settingsCubit.setAppLock,
              );
            },
          ),
          SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              context.strings.backupAndRestore,
              style: WhisprTextStyles.heading5
                  .copyWith(color: WhisprColors.spanishViolet),
              textAlign: TextAlign.start,
            ),
          ),
          WhisprSettingsItem(
            label: context.strings.backup,
            onClick: () {
              context.router.push(const BackupRoute());
            },
            style: WhisprSettingsItemStyle.clickable,
          ),
          WhisprSettingsItem(
            label: context.strings.restore,
            onClick: () async {
              final shouldRefresh =
                  await context.router.push(const RestoreRoute());
              if (shouldRefresh == true) {
                _homeCubit.refreshAudioRecordings();
              }
            },
            style: WhisprSettingsItemStyle.clickable,
          ),
          SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              context.strings.storage,
              style: WhisprTextStyles.heading5
                  .copyWith(color: WhisprColors.spanishViolet),
              textAlign: TextAlign.start,
            ),
          ),
          WhisprSettingsItem(
            label: context.strings.clearAllData,
            onClick: () async {
              final shouldRefresh =
                  await context.router.push(const ClearAllDataRoute());
              if (shouldRefresh == true) {
                _homeCubit.refreshAudioRecordings();
              }
            },
            style: WhisprSettingsItemStyle.clickable,
          ),
          Center(
            child: Text(
              context.strings.appVersion(
                di.get<PackageInfo>().version,
                di.get<PackageInfo>().buildNumber,
              ),
              style: WhisprTextStyles.subtitle1
                  .copyWith(fontWeight: FontWeight.normal),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _settingsValueSubscription?.cancel();
    super.dispose();
  }
}
