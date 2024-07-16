import 'package:flutter/material.dart';
import 'package:harmony_hive/flutter_flow/flutter_flow_theme.dart';
import 'package:harmony_hive/flutter_flow/flutter_flow_util.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await Future.delayed(const Duration(seconds: 1));
      context.goNamed('_initialize');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              FlutterFlowTheme.of(context).accent1,
              FlutterFlowTheme.of(context).accent2,
              FlutterFlowTheme.of(context).accent3
            ],
            stops: const [0.0, 0.2, 1.0],
            begin: const AlignmentDirectional(0.98, 1.0),
            end: const AlignmentDirectional(-0.98, -1.0),
          ),
        ),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                'assets/images/app_logo.png',
                height: 180,
                width: 180,
              ),
            )
          ],
        ),
      ),
    );
  }
}
