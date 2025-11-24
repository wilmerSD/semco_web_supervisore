import 'package:animate_do/animate_do.dart';
import 'package:app_tasking/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
/* 
class SidePanelContainer extends StatefulWidget {
  final String title;
  final Widget child;

  const SidePanelContainer({
    super.key,
    required this.title,
    required this.child,
  });

  @override
  State<SidePanelContainer> createState() => _SidePanelContainerState();
}

class _SidePanelContainerState extends State<SidePanelContainer>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _slideAnimation =
        Tween<Offset>(begin: const Offset(1, 0), end: Offset.zero).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    // Responsive: en pantallas pequeñas ocupa todo el ancho
    final panelWidth = screenWidth > 800 ? screenWidth * 0.40 : screenWidth * 0.9;

    return Material(
      color: Colors.transparent,
      child: Align(
        alignment: Alignment.centerRight,
        child: SlideTransition(
          position: _slideAnimation,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
            width: panelWidth,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  blurRadius: 18,
                  spreadRadius: 4,
                  color: Colors.black.withOpacity(0.15),
                ),
              ],
            ),
            child: Column(
              children: [
                // Header
                Container(
                  height: 50,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: Colors.grey.shade300),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(widget.title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                      GestureDetector(
                        onTap: () => Navigator.of(context).pop(),
                        child: const Icon(Icons.close, size: 22),
                      ),
                    ],
                  ),
                ),
                // Contenido scrollable
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(16),
                    child: widget.child,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
} */

class SidePanelAnimated extends StatelessWidget {
  final String? title;
  final Widget child;
  final Widget? floatingActionButton;

  const SidePanelAnimated({
    super.key,
    required this.title,
    required this.child,
    this.floatingActionButton,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final panelWidth = width > 800 ? width * 0.80 : width * 0.9;
    final schemeColor = Theme.of(context).colorScheme.surface;
    return Material(
      color: Colors.transparent,
      child: Stack(
        children: [
          // 🔥 Overlay clickeable para cerrar
          GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Container(
              color: Colors.transparent,
            ),
          ),

          // 🎭 Panel que desliza desde la derecha con animate_do
          Align(
            alignment: Alignment.centerRight,
            child: SlideInRight(
              duration: const Duration(milliseconds: 400),
              child: Container(
                margin: const EdgeInsets.symmetric(
                    horizontal: 15.0, vertical: 30.0),
                width: panelWidth,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: schemeColor,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 18,
                      spreadRadius: 4,
                      color: Colors.black.withOpacity(0.15),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    if (title != null)
                    Container(
                        height: 50,
                        width: double.infinity,
                        margin: const
                            EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          // border: Border(
                          //   bottom: BorderSide(color: Colors.grey.shade300),
                          // ),
                          borderRadius: BorderRadius.circular(5.0),
                          gradient: AppColors.gradientToHeader,
                        ),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(title!,
                              style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Colors
                                      .white)),
                        ) /*  Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          //TODO: Como figma
                          Text(title,
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w600)),
                          GestureDetector(
                            onTap: () => Navigator.of(context).pop(),
                            child: const Icon(Icons.close, size: 22),
                          ),
                        ],
                      ), */
                        ),

                    // 🔁 Contenido scrollable
                    Expanded(
                      // child: SingleChildScrollView(
                      // padding: const EdgeInsets.all(16),
                      child: child,
                      // ),
                    ),
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(20.0),
                        bottomRight: Radius.circular(20.0),
                      ),
                      child: floatingActionButton ?? const SizedBox(),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/* void showSidePanel(BuildContext context, {required String title, required Widget child}) {
  showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: '',
    barrierColor: Colors.black.withOpacity(0.3), // Overlay con fade-in
    transitionDuration: const Duration(milliseconds: 500),
    pageBuilder: (context, animation, secondaryAnimation) {
      return SidePanelAnimated(title: title, child: child);
    },
    transitionBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(
        opacity: animation, // Fade del overlay
        child: child,
      );
    },
  );
} */

void showSidePanel(
  BuildContext context, {
  String? title,
  required Widget child,
  Widget? floatingActionButton,
}) {
  showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: '',
    barrierColor: Colors.black.withOpacity(0.3), // overlay con fade-in
    transitionDuration: const Duration(milliseconds: 250),
    pageBuilder: (_, __, ___) {
      return SidePanelAnimated(
          title: title,
          child: child,
          floatingActionButton: floatingActionButton);
    },
  );
}
