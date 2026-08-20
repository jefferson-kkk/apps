import 'package:flutter/material.dart';
import 'home_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final PageController _pageController = PageController();
  int _selectedIndex = 0;

  // Função para mudar de página com animação suave
  void _navigateTo(int index) {
    setState(() => _selectedIndex = index);
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOutQuart,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Fundo branco conforme imagem 2
      body: Column(
        children: [
          // --- CABEÇALHO SUPERIOR ---
          Container(
            height: 80,
            padding: const EdgeInsets.symmetric(horizontal: 24),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                bottom: BorderSide(color: Colors.grey.withOpacity(0.2), width: 1),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Logo SENAI (Canto superior esquerdo)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFF2B2B),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Text(
                    'SENAI',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                      fontSize: 22,
                      letterSpacing: 1.2,
                    ),
                  ),
                ),
                // Botão de Sair/Login (Canto superior direito)
                OutlinedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const HomeScreen()),
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Color(0xFFE2E8F0)),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  ),
                  child: const Text(
                    'SAIR',
                    style: TextStyle(color: Color(0xFF64748B), fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: Row(
              children: [
                // --- MENU LATERAL VERMELHO (Design exato da imagem 2) ---
                Container(
                  width: 250,
                  color: const Color(0xFFFF2B2B), // Vermelho vibrante SENAI
                  child: Column(
                    children: [
                      const SizedBox(height: 30),
                      _buildMenuItem(0, Icons.assignment_outlined, 'Chamado'),
                      _buildMenuItem(1, Icons.people_alt_outlined, 'Colaborador'),
                      _buildMenuItem(2, Icons.grid_view_rounded, 'Setores'),
                      _buildMenuItem(3, Icons.business_center_outlined, 'Empresa'),
                      _buildMenuItem(4, Icons.inventory_2_outlined, 'Patrimônio'),
                      _buildMenuItem(5, Icons.person_pin_outlined, 'Responsável'),
                    ],
                  ),
                ),

                // --- CONTEÚDO PRINCIPAL COM TRANSIÇÃO SUAVE ---
                Expanded(
                  child: PageView(
                    controller: _pageController,
                    physics: const NeverScrollableScrollPhysics(), // Navegação apenas pelo menu
                    children: [
                      _buildPageContent('Gestão de Chamados'),
                      _buildPageContent('Lista de Colaboradores'),
                      _buildPageContent('Setores da Unidade'),
                      _buildPageContent('Dados da Empresa'),
                      _buildPageContent('Controle de Patrimônio'),
                      _buildPageContent('Responsáveis Técnicos'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Widget para criar os itens do menu lateral
  Widget _buildMenuItem(int index, IconData icon, String label) {
    bool isSelected = _selectedIndex == index;

    return GestureDetector(
      onTap: () => _navigateTo(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white.withOpacity(0.15) : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.white, size: 24),
            const SizedBox(width: 16),
            Text(
              label,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w400,
              ),
            ),
            if (isSelected) const Spacer(),
            if (isSelected) 
              const Icon(Icons.arrow_forward_ios, color: Colors.white, size: 12),
          ],
        ),
      ),
    );
  }

  // Layout base para as páginas de conteúdo
  Widget _buildPageContent(String title) {
    return Container(
      padding: const EdgeInsets.all(40),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1E293B),
            ),
          ),
          const SizedBox(height: 8),
          Container(
            height: 4,
            width: 60,
            decoration: BoxDecoration(
              color: const Color(0xFFFF2B2B),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const Expanded(
            child: Center(
              child: Text(
                'Conteúdo da área selecionada carregado com sucesso.',
                style: TextStyle(color: Colors.grey, fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}