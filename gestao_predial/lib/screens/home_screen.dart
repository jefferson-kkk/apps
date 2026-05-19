import 'package:flutter/material.dart';
import 'dashboard_screan.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void _openLogin(BuildContext context) {
    Navigator.push(
      context,
      PageRouteBuilder<void>(
        transitionDuration: const Duration(milliseconds: 620),
        reverseTransitionDuration: const Duration(milliseconds: 420),
        pageBuilder: (_, __, ___) => const LoginScreen(),
        transitionsBuilder: (_, animation, __, child) {
          final curvedAnimation = CurvedAnimation(
            parent: animation,
            curve: Curves.easeOutCubic,
          );

          return FadeTransition(
            opacity: curvedAnimation,
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0, 0.04),
                end: Offset.zero,
              ).animate(curvedAnimation),
              child: child,
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        scrolledUnderElevation: 0,
        title: Row(
          children: [
            // Logo com a identidade SENAI
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
              decoration: BoxDecoration(
                color: const Color(0xFFFF2B2B),
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Text(
                'SENAI',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                  fontSize: 18,
                  letterSpacing: 1,
                ),
              ),
            ),
            const SizedBox(width: 16),
            const Text(
              'Portal de Gestão Predial',
              style: TextStyle(
                color: Color(0xFF1E293B), 
                fontSize: 16, 
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        actions: [
          // BOTÃO DE LOGIN NO CAMPO SUPERIOR DIREITO
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: ElevatedButton.icon(
              onPressed: () => _openLogin(context),
              icon: const Icon(Icons.lock_open_rounded, color: Colors.white, size: 18),
              label: const Text(
                'LOGIN', 
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFF2B2B),
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
            ),
          ),
        ],
      ),
      body: Row(
        children: [
          // Menu de Navegação Lateral - CORRIGIDO AQUI
          Container(
            width: 260,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                right: BorderSide(color: Colors.grey.withOpacity(0.2)),
              ),
            ),
            child: Column(
              children: [
                const SizedBox(height: 24),
                _menuItem(Icons.home_rounded, 'Início do Portal', active: true),
                _menuItem(Icons.info_outline_rounded, 'Informações'),
                _menuItem(Icons.contact_support_rounded, 'Suporte Técnico'),
              ],
            ),
          ),
          // Conteúdo Principal da Home
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.domain_rounded, size: 80, color: const Color(0xFFFF2B2B).withOpacity(0.6)),
                  const SizedBox(height: 24),
                  const Text(
                    'Ambiente de Gestão Integrada',
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Color(0xFF1E293B)),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Clique no botão de Login no canto superior direito para aceder.',
                    style: TextStyle(fontSize: 15, color: Colors.grey),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _menuItem(IconData icon, String label, {bool active = false}) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 24),
      leading: Icon(icon, color: active ? const Color(0xFFFF2B2B) : Colors.blueGrey),
      title: Text(
        label,
        style: TextStyle(
          color: active ? const Color(0xFFFF2B2B) : Colors.black87,
          fontWeight: active ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }
}