// Copyright 2019 The FlutterCandies author. All rights reserved.
// Use of this source code is governed by an Apache license that can be found
// in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:wechat_camera_picker/wechat_camera_picker.dart';

import 'CustomCameraPickerState.dart';

/// Provide common usages of the picker.
/// 提供常见的选择器调用方式。
List<PickMethod> get pickMethods {
  return <PickMethod>[
    PickMethod(
      icon: '📷',
      name: 'Release mode button disappear',
      description: 'debug mode button exists but release mode button disappear',
      method: (BuildContext context) => CameraPicker.pickFromCamera(context,
          createPickerState: () => CustomCameraPickerState()),
    )
  ];
}

/// Define a regular pick method.
class PickMethod {
  const PickMethod({
    required this.icon,
    required this.name,
    required this.description,
    required this.method,
    this.onLongPress,
  });

  final String icon;
  final String name;
  final String description;

  /// The core function that defines how to use the picker.
  final Future<AssetEntity?> Function(BuildContext context) method;

  final GestureLongPressCallback? onLongPress;
}
