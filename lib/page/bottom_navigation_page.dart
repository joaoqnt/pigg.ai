import 'package:flutter/material.dart';
import 'package:piggai/component/bottom_navigation_component/modal_bottom_component.dart';
import 'package:piggai/controller/category_controller.dart';
import 'package:piggai/controller/transaction_controller.dart';
import 'package:piggai/page/transaction_page.dart';
import 'package:piggai/util/singleton.dart';

class BottomNavigationPage extends StatefulWidget {
  const BottomNavigationPage({super.key});

  @override
  State<BottomNavigationPage> createState() => _BottomNavigationPageState();
}

class _BottomNavigationPageState extends State<BottomNavigationPage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {


    final List<Widget> _pages = [
      Center(child: Text('Início')),
      Center(child: Text('Metas')),
      Container(),
      TransactionPage(),
      Center(child: Text('Perfil')),
    ];

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: _pages[_currentIndex],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border(top: BorderSide(color: Theme.of(context).colorScheme.tertiaryContainer))
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) => setState(() => index != 2
              ? _currentIndex = index
              : ModalBottomComponent().show(context,transactionController: Singleton().transactionController)
          ),
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Theme.of(context).colorScheme.onSurface,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              activeIcon: Icon(Icons.home),
              label: 'Início',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.show_chart_outlined),
              activeIcon: Icon(Icons.show_chart),
              label: 'Metas',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add),
              label: 'Criar',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_balance_wallet_outlined),
              activeIcon: Icon(Icons.account_balance_wallet),
              label: 'Finanças',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.menu_outlined),
              activeIcon: Icon(Icons.menu),
              label: 'Menu',
            ),
          ],
        ),
      ),
    );
  }
}
