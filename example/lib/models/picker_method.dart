// Copyright 2019 The FlutterCandies author. All rights reserved.
// Use of this source code is governed by an Apache license that can be found
// in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:wechat_camera_picker/wechat_camera_picker.dart';

/// Provide common usages of the picker.
/// 提供常见的选择器调用方式。
List<PickMethod> get pickMethods {
  return <PickMethod>[
    PickMethod(
      icon: '⏳',
      name: '右侧无响应、foregroundWidget宽度问题',
      description: '右侧屏幕点击不展示曝光选择并且foregroundWidget宽度有问题',
      method: (BuildContext context) => CameraPicker.pickFromCamera(
        context,
        pickerConfig: CameraPickerConfig(
          cameraQuarterTurns: 1,
          foregroundBuilder: (b, c) => SlidingUpPanel(
            renderPanelSheet: false,
            panel: _floatingPanel(),
            collapsed: _floatingCollapsed(),
          ),
        ),
      ),
    ),
    PickMethod(
      icon: '⏳',
      name: '锁定屏幕方向无效',
      description: '锁定屏幕方向无效',
      method: (BuildContext context) => CameraPicker.pickFromCamera(
        context,
        pickerConfig: CameraPickerConfig(
          cameraQuarterTurns: 1,
          foregroundBuilder: (b, c) => SlidingUpPanel(
            renderPanelSheet: false,
            panel: _floatingPanel(),
            collapsed: _floatingCollapsed(),
          ),
        ),
      ),
    )
  ];
}

const radius = 12.0;
const topMargin = 40.0;

Widget _floatingCollapsed() {
  return Container(
    decoration: BoxDecoration(
      color: Colors.blueGrey,
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(radius), topRight: Radius.circular(radius)),
    ),
    margin: const EdgeInsets.fromLTRB(0.0, topMargin, 0.0, 0.0),
    child: Center(
      child: Text(
        "宽度有问题",
        style: TextStyle(color: Colors.white),
      ),
    ),
  );
}

Widget _floatingPanel() {
  return Container(
    decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(radius),
            topRight: Radius.circular(radius)),
        boxShadow: [
          BoxShadow(
            blurRadius: 20.0,
            color: Colors.grey,
          ),
        ]),
    margin: const EdgeInsets.fromLTRB(0.0, topMargin, 0.0, 0.0),
    child: ListView(
      children: getTabList(),
    ),
  );
}

List<Widget> getTabList() {
  List<Widget> list = [
    Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          width: 30,
          height: 5,
          decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.all(Radius.circular(12.0))),
        ),
      ],
    )
  ];
  for (int i = 0; i < 100; i++) {
    list.add(ListTile(
      title: TextButton(
        onPressed: () => print('on tap'),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[Text("TEST : $i"), Icon(Icons.arrow_forward_ios)],
        ),
      ),
    ));
  }
  return list;
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
