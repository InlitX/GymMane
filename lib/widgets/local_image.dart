import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:video_player/video_player.dart';

ImageProvider localImage(String path) => kIsWeb ? NetworkImage(path) : FileImage(File(path));

VideoPlayerController localVideo(String path, {VideoPlayerOptions? options}) => kIsWeb
    ? VideoPlayerController.networkUrl(Uri.parse(path), videoPlayerOptions: options)
    : VideoPlayerController.file(File(path), videoPlayerOptions: options);
