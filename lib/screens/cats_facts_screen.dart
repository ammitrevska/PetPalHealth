import 'package:flutter/material.dart';
import 'package:petpal_health/provider/fact_provider.dart';
import 'package:provider/provider.dart';

class CatsFactsScreen extends StatefulWidget {
  const CatsFactsScreen({super.key});

  @override
  State<CatsFactsScreen> createState() => _CatsFactsScreenState();
}

class _CatsFactsScreenState extends State<CatsFactsScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final factProvider = Provider.of<FactProvider>(context, listen: false);
      factProvider.fetchCatFacts();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<FactProvider>(
      builder: (context, provider, child) {
        if (provider.isLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (provider.errorMessage.isNotEmpty) {
          return Center(child: Text(provider.errorMessage));
        } else if (provider.catFacts.isEmpty) {
          return const Center(child: Text('No facts available'));
        }

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView.builder(
            itemCount: provider.catFacts.length,
            itemBuilder: (context, index) {
              final fact = provider.catFacts[index];
              return Card(
                color: Colors.white,
                margin: const EdgeInsets.symmetric(vertical: 8.0),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      const Icon(Icons.pets, color: Colors.orange),
                      const SizedBox(width: 8.0),
                      Expanded(
                        child: Text(
                          fact.fact,
                          style: const TextStyle(
                            fontFamily: 'Cursive',
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
