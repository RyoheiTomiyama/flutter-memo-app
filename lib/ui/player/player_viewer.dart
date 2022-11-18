import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:video_player/video_player.dart';

class PlayerViewer extends HookWidget {
  final VideoPlayerController controller;
  const PlayerViewer({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final playerKey = GlobalKey();

    final animation = useState<Animation<Matrix4>>(
      AlwaysStoppedAnimation(Matrix4.identity()),
    );
    final animationController = useAnimationController(
      duration: const Duration(milliseconds: 80),
    );
    useAnimation(animationController);

    final transformationController = useTransformationController();
    useListenable(transformationController);

    useEffect(() {
      transformationController.value = animation.value.value;
    }, [animation.value.value]);

    return Container(
      color: Colors.black,
      child: controller.value.isInitialized
          ? GestureDetector(
              onDoubleTap: () {
                if (context.size == null) {
                  return;
                }
                // 拡大も縮小もされていないMatrix
                final initialMatrix4 = Matrix4.diagonal3Values(1, 1, 1);
                final currentMatrix4 = transformationController.value.clone();
                final nextMatrix4 = transformationController.value.clone();

                //等倍のとき 位置を無視するためにgetNormalMatrixをしている
                if (currentMatrix4.getNormalMatrix() ==
                    initialMatrix4.getNormalMatrix()) {
                  const scale = 2.5;
                  final widgetSize = context.size!;
                  // 拡大したものを中央寄せにする
                  final dx = (widgetSize.width - widgetSize.width * scale) / 2;
                  final dy =
                      (widgetSize.height - widgetSize.height * scale) / 2;
                  nextMatrix4
                    ..scale(2.5)
                    ..setTranslationRaw(dx, dy, 0);
                } else {
                  nextMatrix4.setFrom(initialMatrix4);
                }

                // animationさせる
                animation.value = Matrix4Tween(
                  begin: currentMatrix4,
                  end: nextMatrix4,
                ).animate(animationController);
                animationController.forward(from: 0);
              },
              child: InteractiveViewer(
                transformationController: transformationController,
                child: Center(
                  child: AspectRatio(
                    aspectRatio: controller.value.aspectRatio,
                    child: VideoPlayer(controller, key: playerKey),
                  ),
                ),
              ),
            )
          : Container(),
    );
  }
}
