import 'dart:math';

import 'package:flutter/material.dart';
import 'package:scrapwala_dev/models/pickup_request_model/pickup_request_model.dart';
import 'package:timelines/timelines.dart';

class RequestStatusPreviewWidget extends StatefulWidget {
  final PickupRequestModel model;

  const RequestStatusPreviewWidget({super.key, required this.model});

  @override
  // ignore: library_private_types_in_public_api
  _RequestStatusPreviewWidgetState createState() =>
      _RequestStatusPreviewWidgetState();
}

const kTileHeight = 50.0;
const completeColor = Color(0xff5e6172);

class _RequestStatusPreviewWidgetState
    extends State<RequestStatusPreviewWidget> {
  late int _processIndex;

  @override
  void initState() {
    super.initState();
    _processIndex = _processes.keys.toList().indexOf(widget.model.status);
  }

  Color getColor(BuildContext context, int index) {
    if (index == _processIndex) {
      return Theme.of(context).colorScheme.primary;
    } else if (index < _processIndex) {
      return Theme.of(context).colorScheme.inverseSurface;
    } else {
      return const Color(0xff5e6172);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 100,
      child: Timeline.tileBuilder(
        theme: TimelineThemeData(
          direction: Axis.horizontal,
          connectorTheme: const ConnectorThemeData(
            space: 30.0,
            thickness: 5.0,
          ),
        ),
        builder: TimelineTileBuilder.connected(
          connectionDirection: ConnectionDirection.before,
          itemExtentBuilder: (_, __) =>
              MediaQuery.of(context).size.width / _processes.length,
          oppositeContentsBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 15.0),
              child: Icon(
                  _processIndex == index
                      ? _processes.keys.toList()[index].icon
                      : _processes.keys.toList()[index].outlinedIcon,
                  color: getColor(context, index)),
            );
          },
          contentsBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: Text(
                (_processes.values.toList())[index],
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: getColor(context, index),
                ),
              ),
            );
          },
          indicatorBuilder: (_, index) {
            Color color;
            late Widget child;
            if (index == _processIndex) {
              color = Theme.of(context).colorScheme.primary;
              child = const Padding(
                padding: EdgeInsets.all(8.0),
                child: CircularProgressIndicator(
                  strokeWidth: 3.0,
                  valueColor: AlwaysStoppedAnimation(Colors.white),
                ),
              );
            } else if (index < _processIndex) {
              color = completeColor;
              child = const Icon(
                Icons.check,
                color: Colors.white,
                size: 15.0,
              );
            } else {
              color = completeColor;
            }

            if (index <= _processIndex) {
              return Stack(
                children: [
                  CustomPaint(
                    size: const Size(30.0, 30.0),
                    painter: _BezierPainter(
                      color: color,
                      drawStart: index > 0,
                      drawEnd: index < _processIndex,
                    ),
                  ),
                  DotIndicator(
                    size: 30.0,
                    color: color,
                    child: child,
                  ),
                ],
              );
            } else {
              return Stack(
                children: [
                  CustomPaint(
                    size: const Size(15.0, 15.0),
                    painter: _BezierPainter(
                      color: color,
                      drawEnd: index < _processes.length - 1,
                    ),
                  ),
                  OutlinedDotIndicator(
                    borderWidth: 4.0,
                    color: color,
                  ),
                ],
              );
            }
          },
          connectorBuilder: (_, index, type) {
            if (index > 0) {
              if (index == _processIndex) {
                final prevColor = getColor(context, index - 1);
                final color = getColor(context, index);
                List<Color> gradientColors;
                if (type == ConnectorType.start) {
                  gradientColors = [Color.lerp(prevColor, color, 0.5)!, color];
                } else {
                  gradientColors = [
                    prevColor,
                    Color.lerp(prevColor, color, 0.5)!
                  ];
                }
                return DecoratedLineConnector(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: gradientColors,
                    ),
                  ),
                );
              } else {
                return SolidLineConnector(
                  color: getColor(context, index),
                );
              }
            } else {
              return null;
            }
          },
          itemCount: _processes.length,
        ),
      ),
    );
  }
}

class _BezierPainter extends CustomPainter {
  const _BezierPainter({
    required this.color,
    this.drawStart = true,
    this.drawEnd = true,
  });

  final Color color;
  final bool drawStart;
  final bool drawEnd;

  Offset offset(double radius, double angle) {
    return Offset(
      radius * cos(angle) + radius,
      radius * sin(angle) + radius,
    );
  }

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.fill
      ..color = color;

    final radius = size.width / 2;

    double angle;
    Offset offset1;
    Offset offset2;

    Path path;

    if (drawStart) {
      angle = 3 * pi / 4;
      offset1 = offset(radius, angle);
      offset2 = offset(radius, -angle);
      path = Path()
        ..moveTo(offset1.dx, offset1.dy)
        ..quadraticBezierTo(0.0, size.height / 2, -radius, radius)
        ..quadraticBezierTo(0.0, size.height / 2, offset2.dx, offset2.dy)
        ..close();

      canvas.drawPath(path, paint);
    }
    if (drawEnd) {
      angle = -pi / 4;
      offset1 = offset(radius, angle);
      offset2 = offset(radius, -angle);

      path = Path()
        ..moveTo(offset1.dx, offset1.dy)
        ..quadraticBezierTo(size.width, size.height / 2, size.width + radius,
            radius) // TODO connector end & gradient
        ..quadraticBezierTo(size.width, size.height / 2, offset2.dx, offset2.dy)
        ..close();

      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(_BezierPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.drawStart != drawStart ||
        oldDelegate.drawEnd != drawEnd;
  }
}

final _processes = {
  RequestStatus.requested: 'Requested',
  RequestStatus.accepted: 'Accepted',
  RequestStatus.onTheWay: 'On The Way',
  RequestStatus.picked: 'Picked',
};
