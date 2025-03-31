import '/flutter/flutter_theme.dart';
import '/flutter/flutter_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'sender_message_page_model.dart';
export 'sender_message_page_model.dart';

class SenderMessagePageWidget extends StatefulWidget {
  const SenderMessagePageWidget({Key? key}) : super(key: key);

  @override
  _SenderMessagePageWidgetState createState() =>
      _SenderMessagePageWidgetState();
}

class _SenderMessagePageWidgetState extends State<SenderMessagePageWidget> {
  late SenderMessagePageModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SenderMessagePageModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Row(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Flexible(
          child: Card(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            color: Color(0xFF5C47A8),
            elevation: 4.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(8.0),
                bottomRight: Radius.circular(0.0),
                topLeft: Radius.circular(8.0),
                topRight: Radius.circular(8.0),
              ),
            ),
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(8.0, 8.0, 8.0, 8.0),
              child: Text(
                FFLocalizations.of(context).getText(
                  'j29afkuc' /* I have a lot of work in the ho... */,
                ),
                textAlign: TextAlign.start,
                style: FlutterTheme.of(context).bodyMedium.override(
                      fontFamily: 'Urbanist',
                      color: FlutterTheme.of(context).primaryBtnText,
                      fontWeight: FontWeight.normal,
                    ),
              ),
            ),
          ),
        ),
        Container(
          width: 40.0,
          height: 40.0,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
          ),
          child: Image.network(
            'https://picsum.photos/seed/132/600',
            fit: BoxFit.cover,
          ),
        ),
      ],
    );
  }
}
