// about_tasking.dart
// Widget con la información de versión, contacto comercial, soporte, enlaces y acciones.
// Úsalo tal cual o adáptalo a tu diseño.

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutApp extends StatelessWidget {
  const AboutApp({super.key});

  // Datos (puedes moverlos a un modelo/config externo si lo prefieres)
  final String _version = 'Versión 1.01';
  final String _updateDate = '12/01/2025';

  final String _salesEmail = 'ventas@task-ing.com';
  final String _salesPhone = '+51 939 631 096';
  final String _website = 'https://lyracode.com/task-ing';

  final String _supportEmail = 'soporte@task-ing.com';
  final String _supportPhone = '+51 989 068 290';

  const AboutApp._internal({Key? key}) : this(key: key);

  static Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      // Si falla, simplemente imprimimos el error. Puedes manejarlo mejor.
      debugPrint('No se pudo abrir: $url');
    }
  }

  static Future<void> _mailto(String email, {String? subject}) async {
    final params = <String, String>{
      if (subject != null) 'subject': subject,
    };
    final uri = Uri(scheme: 'mailto', path: email, queryParameters: params);
    if (!await launchUrl(uri)) debugPrint('No se pudo abrir mailto');
  }

  static Future<void> _call(String phone) async {
    final uri = Uri(scheme: 'tel', path: phone);
    if (!await launchUrl(uri)) debugPrint('No se pudo iniciar la llamada');
  }

  @override
  Widget build(BuildContext context) {
    // Nota: el usuario indicó que se encargará del diseño — esto es una estructura básica.
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Versión y fecha
          Text('$_version', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 4),
          Text('Fecha de actualización: $_updateDate'),
          const Divider(height: 24),

          // Contacto Comercial
          _Section(
            title: 'Contacto comercial',
            children: [
              _ActionTile(
                label: _salesEmail,
                subtitle: 'Enviar email',
                onTap: () => _mailto(_salesEmail, subject: 'Consulta comercial'),
                icon: Icons.email,
              ),
              _ActionTile(
                label: _salesPhone,
                subtitle: 'Llamar o copiar',
                onTap: () => _call(_salesPhone),
                onLongPress: () {
                  Clipboard.setData(const ClipboardData(text: '+51939631096'));
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Teléfono copiado')));
                },
                icon: Icons.phone,
              ),
              _ActionTile(
                label: _website,
                subtitle: 'Visitar web',
                onTap: () => _launchUrl(_website),
                icon: Icons.language,
              ),
            ],
          ),

          const Divider(height: 24),

          // Contacto Soporte
          _Section(
            title: 'Contacto soporte',
            children: [
              _ActionTile(
                label: _supportEmail,
                subtitle: 'Enviar email',
                onTap: () => _mailto(_supportEmail, subject: 'Soporte técnico'),
                icon: Icons.email_outlined,
              ),
              _ActionTile(
                label: 'Guía de uso',
                subtitle: 'Abrir guía (placeholder)',
                onTap: () {
                  // Reemplaza por la URL real de la guía de uso si la tienes
                  _launchUrl('https://lyracode.com/task-ing/guide');
                },
                icon: Icons.menu_book,
              ),
              _ActionTile(
                label: _supportPhone,
                subtitle: 'Llamar o copiar',
                onTap: () => _call(_supportPhone),
                onLongPress: () {
                  Clipboard.setData(const ClipboardData(text: '+51989068290'));
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Teléfono copiado')));
                },
                icon: Icons.phone_in_talk,
              ),
            ],
          ),

          const Divider(height: 24),

          // Comprar
          _Section(
            title: 'Comprar',
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  // Acción para comprar licencia - reemplaza URL por la real
                  _launchUrl('https://lyracode.com/task-ing/buy');
                },
                icon: const Icon(Icons.shopping_cart),
                label: const Text('Comprar Licencia'),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Webinar
          _Section(
            title: 'Webinar',
            children: [
              OutlinedButton.icon(
                onPressed: () {
                  // Acción para registrarse en eventos - reemplaza URL si es necesario
                  _launchUrl('https://lyracode.com/task-ing/events');
                },
                icon: const Icon(Icons.event),
                label: const Text('Participar de eventos Task-ing'),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Novedades en redes sociales (placeholder)
          _Section(
            title: 'Novedades en redes sociales',
            children: [
              const Text('Síguenos en nuestras redes para más novedades.'),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                    onPressed: () => _launchUrl('https://facebook.com/lyracode'),
                    icon: const Icon(Bootstrap.facebook),
                  ),
                  IconButton(
                    onPressed: () => _launchUrl('https://twitter.com/lyracode'),
                    icon: const Icon(Bootstrap.twitter_x),
                  ),
                  IconButton(
                    onPressed: () => _launchUrl('https://instagram.com/lyracode'),
                    icon: const Icon(Bootstrap.instagram),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 24),
        ],
      ),
    );
  }
}

// Widgets auxiliares
class _Section extends StatelessWidget {
  final String title;
  final List<Widget> children;
  const _Section({required this.title, required this.children, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: Theme.of(context).textTheme.titleSmall),
        const SizedBox(height: 8),
        ...children,
      ],
    );
  }
}

class _ActionTile extends StatelessWidget {
  final String label;
  final String? subtitle;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final IconData? icon;

  const _ActionTile({required this.label, this.subtitle, this.onTap, this.onLongPress, this.icon, super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: icon != null ? Icon(icon) : null,
      title: Text(label),
      subtitle: subtitle != null ? Text(subtitle!) : null,
      onTap: onTap,
      onLongPress: onLongPress,
    );
  }
}
