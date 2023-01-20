import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:wechat_camera_picker/wechat_camera_picker.dart';

class CustomCameraPickerState extends CameraPickerState {
  @override
  Widget buildCameraSwitch(BuildContext context) {
    return const SizedBox.shrink();
  }

  @override
  Widget buildFlashModeSwitch(BuildContext context, CameraValue value) {
    return const SizedBox.shrink();
  }

  Widget buildForegroundBody(BuildContext context, BoxConstraints constraints) {
    return SafeArea(
      child: Row(
        children: <Widget>[
          Semantics(
            sortKey: const OrdinalSortKey(0),
            hidden: innerController == null,
            child: buildSettingActions(context),
          ),
          const Spacer(flex: 16),
          ExcludeSemantics(child: buildCaptureTips(innerController)),
          Semantics(
            sortKey: const OrdinalSortKey(2),
            hidden: innerController == null,
            child: buildCaptureActions(
              context: context,
              constraints: constraints,
              controller: innerController,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCaptureActions({
    required BuildContext context,
    required BoxConstraints constraints,
    CameraController? controller,
  }) {
    return SizedBox(
      height: 300,
      child: Column(
        children: <Widget>[
          if (controller != null && controller.value.isRecordingVideo != true)
            Expanded(child: buildBackButton(context, constraints))
          else
            const Spacer(),
          Expanded(
            child: Center(
              child: MergeSemantics(child: buildCaptureButton(constraints)),
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }

  Widget buildCaptureButton(BoxConstraints constraints) {
    const Size outerSize = Size.square(115);
    const Size innerSize = Size.square(82);
    return Semantics(
      label: textDelegate.sActionShootingButtonTooltip,
      onTap: onTap,
      onTapHint: onTapHint,
      onLongPress: onLongPress,
      onLongPressHint: onLongPressHint,
      child: Listener(
        behavior: HitTestBehavior.opaque,
        onPointerUp: onPointerUp,
        onPointerMove: onPointerMove(constraints),
        child: GestureDetector(
          onTap: onTap,
          onLongPress: onLongPress,
          child: SizedBox.fromSize(
            size: outerSize,
            child: Stack(
              children: <Widget>[
                Center(
                  child: AnimatedContainer(
                    duration: kThemeChangeDuration,
                    width: isShootingButtonAnimate
                        ? outerSize.width
                        : innerSize.width,
                    height: isShootingButtonAnimate
                        ? outerSize.height
                        : innerSize.height,
                    padding: EdgeInsets.all(isShootingButtonAnimate ? 30 : 11),
                    decoration: BoxDecoration(
                      color: theme.canvasColor.withOpacity(0.85),
                      shape: BoxShape.circle,
                    ),
                    child: const DecoratedBox(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ),
                if ((innerController?.value.isRecordingVideo ?? false) &&
                    isRecordingRestricted)
                  CameraProgressButton(
                    isAnimating: isShootingButtonAnimate,
                    duration: pickerConfig.maximumRecordingDuration!,
                    outerRadius: outerSize.width,
                    ringsColor: theme.indicatorColor,
                    ringsWidth: 2,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
