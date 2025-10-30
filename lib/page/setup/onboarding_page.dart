import 'package:flutter/material.dart';
import 'package:piggai/controller/setup_controller.dart';
import 'package:piggai/page/setup/setup_first_page.dart';

class OnboardingIntroPage extends StatelessWidget {
  OnboardingIntroPage({super.key});

  final controller = SetupController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Text("Pagina 1 de 3",
              style: TextStyle(
                fontSize: 12,
              )
          )
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Animação opcional
              // SizedBox(
              //   height: 180,
              //   child: Lottie.asset(
              //     'assets/animations/wallet.json', // se tiver
              //     fit: BoxFit.contain,
              //   ),
              // ),
              //
              // const SizedBox(height: 16),

              Text(
                "Vamos personalizar sua experiência",
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 12),

              Text(
                "Para te ajudar a organizar suas finanças, vamos precisar de algumas informações simples.",
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 24),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  InfoBullet(text: "💰 Sua forma de renda"),
                  InfoBullet(text: "🏷️ Seus principais gastos"),
                  InfoBullet(text: "🎯 Seus objetivos financeiros"),
                ],
              ),

              const SizedBox(height: 20),

              Text(
                "É bem rapidinho 😉",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontStyle: FontStyle.italic,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 32),

              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => SetupFirstPage(controller: controller)));
                  },
                  child: const Text("Começar"),
                ),
              ),
              TextButton(
                  onPressed: (){},
                  child: Text("Continuar sem configuração",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.tertiary,
                        decoration: TextDecoration.underline
                      )
                  )
              )
            ],
          ),
        ),
      ),
    );
  }
}

class InfoBullet extends StatelessWidget {
  final String text;
  const InfoBullet({required this.text, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          Text(text, style: Theme.of(context).textTheme.bodyLarge),
        ],
      ),
    );
  }
}
