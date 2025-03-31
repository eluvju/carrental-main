import '/flutter/flutter_animations.dart';
import '/flutter/flutter_theme.dart';
import '/flutter/flutter_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'light_model.dart';
export 'light_model.dart';

class LightWidget extends StatefulWidget {
  const LightWidget({Key? key}) : super(key: key);

  @override
  _LightWidgetState createState() => _LightWidgetState();
}

class _LightWidgetState extends State<LightWidget>
    with TickerProviderStateMixin {
  late LightModel _model;

  final animationsMap = {
    'containerOnActionTriggerAnimation': AnimationInfo(
      trigger: AnimationTrigger.onActionTrigger,
      applyInitialState: true,
      effects: [
        MoveEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 300.ms,
          begin: Offset(-40.0, 0.0),
          end: Offset(0.0, 0.0),
        ),
      ],
    ),
  };

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => LightModel());

    setupAnimations(
      animationsMap.values.where((anim) =>
          anim.trigger == AnimationTrigger.onActionTrigger ||
          !anim.applyInitialState),
      this,
    );
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 12.0, 0.0),
      child: InkWell(
        splashColor: Colors.transparent,
        focusColor: Colors.transparent,
        hoverColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: () async {
          if ((Theme.of(context).brightness == Brightness.light) == true) {
            setDarkModeSetting(context, ThemeMode.dark);
            if (animationsMap['containerOnActionTriggerAnimation'] != null) {
              animationsMap['containerOnActionTriggerAnimation']!
                  .controller
                  .forward(from: 0.0);
            }
          } else {
            setDarkModeSetting(context, ThemeMode.light);
            if (animationsMap['containerOnActionTriggerAnimation'] != null) {
              animationsMap['containerOnActionTriggerAnimation']!
                  .controller
                  .reverse();
            }
          }
        },
        child: Container(
          width: 80.0,
          height: 40.0,
          decoration: BoxDecoration(
            color: FlutterTheme.of(context).primaryBackground,
            borderRadius: BorderRadius.circular(20.0),
            border: Border.all(
              color: FlutterTheme.of(context).alternate,
              width: 1.0,
            ),
          ),
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(2.0, 2.0, 2.0, 2.0),
            child: Stack(
              alignment: AlignmentDirectional(0.0, 0.0),
              children: [
                Align(
                  alignment: AlignmentDirectional(-0.90, 0.00),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(6.0, 0.0, 0.0, 0.0),
                    child: Icon(
                      Icons.wb_sunny_rounded,
                      color: FlutterTheme.of(context).secondaryText,
                      size: 24.0,
                    ),
                  ),
                ),
                Align(
                  alignment: AlignmentDirectional(1.00, 0.00),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 6.0, 0.0),
                    child: Icon(
                      Icons.mode_night_rounded,
                      color: FlutterTheme.of(context).secondaryText,
                      size: 24.0,
                    ),
                  ),
                ),
                Align(
                  alignment: AlignmentDirectional(1.00, 0.00),
                  child: Container(
                    width: 36.0,
                    height: 36.0,
                    decoration: BoxDecoration(
                      color: FlutterTheme.of(context).secondaryBackground,
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 4.0,
                          color: Color(0x430B0D0F),
                          offset: Offset(0.0, 2.0),
                        )
                      ],
                      borderRadius: BorderRadius.circular(30.0),
                      shape: BoxShape.rectangle,
                    ),
                  ).animateOnActionTrigger(
                    animationsMap['containerOnActionTriggerAnimation']!,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
