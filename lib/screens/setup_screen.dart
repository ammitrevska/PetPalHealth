import 'package:flutter/material.dart';
import 'package:petpal_health/provider/pet_provider.dart';
import 'package:provider/provider.dart';
import 'package:petpal_health/constants.dart';
import 'package:petpal_health/widgets/bottom_nav_bar.dart';
import 'package:petpal_health/widgets/gradient_background.dart';

class SetupScreen extends StatelessWidget {
  const SetupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final pet = Provider.of<PetProvider>(context).pet;

    return GradientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: const Text('Home'),
          actions: const [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 18.0),
              child: CircleAvatar(
                radius: 30.0,
                backgroundColor: Colors.white,
              ),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 42.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Pet section
              SizedBox(
                width: double.infinity,
                height: 130.0,
                child: Material(
                  elevation: 12,
                  borderRadius: const BorderRadius.all(Radius.circular(40.0)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8.0,
                      vertical: 18.0,
                    ),
                    child: pet != null
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 16.0),
                                child: Row(
                                  children: [
                                    ...[
                                      pet.name,
                                      'the',
                                      pet.breed,
                                      pet.species,
                                    ].map((text) => Padding(
                                          padding:
                                              const EdgeInsets.only(right: 8.0),
                                          child: Text(
                                            text,
                                            style: const TextStyle(
                                              fontSize: 24.0,
                                              fontWeight: FontWeight.bold,
                                              color: kTextColor,
                                            ),
                                          ),
                                        )),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 8.0),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(pet.gender),
                                    const SizedBox(width: 8.0),
                                    Text(' ${pet.weight} kg'),
                                    const SizedBox(width: 8.0),
                                    Text(pet.age),
                                  ],
                                ),
                              ),
                            ],
                          )
                        : Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(left: 16.0),
                                  child: Text(
                                    'No pets to display',
                                    style: TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 8.0),
                                TextButton.icon(
                                  onPressed: () {
                                    Navigator.pushNamed(
                                        context, Pages.addPetScreen);
                                  },
                                  label: const Text('Add a pet'),
                                  icon: const Icon(Icons.add),
                                ),
                              ],
                            ),
                          ),
                  ),
                ),
              ),
              const SizedBox(height: 42.0),

              // Tasks section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        'No daily tasks to display',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    TextButton.icon(
                      onPressed: () {
                        Navigator.pushNamed(context, Pages.addTaskScreen);
                      },
                      label: const Text('Add a task'),
                      icon: const Icon(Icons.add),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavBar(context).getFooterMenu(0),
      ),
    );
  }
}
