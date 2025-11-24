/* import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:html' as html;

class WebviewCollaboration extends StatefulWidget {
  const WebviewCollaboration(
      {required this.projectId,
      required this.clienteId,
      super.key,
      required this.companiaId,
      required this.taskId});
  final String projectId;
  final String clienteId;
  final String companiaId;
  final String taskId;
  @override
  _WebviewCollaborationState createState() => _WebviewCollaborationState();
}

class _WebviewCollaborationState extends State<WebviewCollaboration> {
  late final WebViewController controller;
  @override
  void initState() {
    super.initState();

    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(
        'http://localhost/AppTaskingGX18NETFrameworkSQLServer/webopcomentario03c.aspx?${widget.taskId},${widget.clienteId},${widget.companiaId},0,0,${widget.projectId}',
      ));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: WebViewWidget(controller: controller),
    );
  }
}
 */
import 'dart:html' as html;
import 'dart:ui' as ui;
import 'package:app_tasking/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class WebviewCollaboration extends StatelessWidget {
  const WebviewCollaboration({
    required this.projectId,
    required this.clienteId,
    required this.companiaId,
    required this.taskId,
    super.key,
  });

  final String projectId;
  final String clienteId;
  final String companiaId;
  final String taskId;

  @override
  Widget build(BuildContext context) {
    print('$taskId,$clienteId,$companiaId,0,0,$projectId');
    /* final String url =
        'http://localhost/AppTaskingGX18NETFrameworkSQLServer/General.WpColaborationTask.aspx?$taskId,$clienteId,$companiaId,0,0,$projectId'; */
    // final String url =
    //     'https://app.task-ing.com/qa/WpColaborationTask.aspx?$taskId,$clienteId,$companiaId,0,0,$projectId';
    final String url =
        'https://app.task-ing.com/demo/WpColaborationTask.aspx?$taskId,$clienteId,$companiaId,0,0,$projectId';
    // final String url =
    //     'https://app.task-ing.com/vs1/WpColaborationTask.aspx?$taskId,$clienteId,$companiaId,0,0,$projectId';

    final String viewType = 'iframe-$taskId'; // 👈 único por taskId

    // ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory(
      viewType,
      (int viewId) => html.IFrameElement()
        ..src = url
        ..style.border = 'none'
        ..style.width = '100%'
        ..style.height = '100%',
    );

    return
        /*  SizedBox.expand(
          child: HtmlElementView(viewType: viewType, key: ValueKey(taskId)), // 👈 fuerza reconstrucción
        ); */
        Column(
      children: [
        Expanded(
          child: HtmlElementView(
            viewType: viewType,
            key: ValueKey(taskId),
          ),
        ),
        Align(
            alignment: Alignment.bottomRight,
            child: InkWell(
              child: Container(
                height: 45.0,
                width: 78.0,
                margin: const EdgeInsets.only(bottom: 5.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: AppColors.closeBtnColor(context),
                ),
                child: const Center(
                    child: Text(
                  "Cerrar",
                  style: TextStyle(color: AppColors.primaryConst),
                )),
              ),
              onTap: () => Navigator.of(context).pop(),
            )),
      ],
    );
  }
}
