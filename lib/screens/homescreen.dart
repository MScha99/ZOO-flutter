import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Activity {
  final String dayOfWeek;
  final String activityName;

  Activity({required this.dayOfWeek, required this.activityName});
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController scrollController = ScrollController();

  List<Activity> activities = [
    Activity(
        dayOfWeek: 'Poniedziałek', activityName: '09:15 - Żyrafy Siatkowane'),
    Activity(dayOfWeek: 'Poniedziałek', activityName: '11:00 - Hipopotamy'),
    Activity(
        dayOfWeek: 'Poniedziałek', activityName: '12:00 - Pawiany Masajskie'),
    Activity(dayOfWeek: 'Poniedziałek', activityName: '12:30 - Manaty'),
    Activity(dayOfWeek: 'Poniedziałek', activityName: '13:00 - Kotiki'),
    Activity(
        dayOfWeek: 'Poniedziałek', activityName: '13:30 - Pelikany Różowe'),
    Activity(dayOfWeek: 'Poniedziałek', activityName: '15:00 - Lemury Katta'),
    Activity(dayOfWeek: 'Wtorek', activityName: '09:15 - Żyrafy Siatkowane'),
    Activity(dayOfWeek: 'Wtorek', activityName: '09:30 - Flamingi'),
    Activity(dayOfWeek: 'Wtorek', activityName: '11:00 - Hipopotamy'),
    Activity(dayOfWeek: 'Wtorek', activityName: '12:00 - Pawiany Masajskie'),
    Activity(dayOfWeek: 'Wtorek', activityName: '13:00 - Lemury Katta'),
    Activity(dayOfWeek: 'Wtorek', activityName: '14:30 - Wielbłądy'),
    Activity(dayOfWeek: 'Wtorek', activityName: '15:00 - Kotiki'),
    Activity(dayOfWeek: 'Środa', activityName: '09:15 - Żyrafy Siatkowane'),
    Activity(dayOfWeek: 'Środa', activityName: '10:30 - Lamparty'),
    Activity(dayOfWeek: 'Środa', activityName: '11:00 - Hipopotamy'),
    Activity(dayOfWeek: 'Środa', activityName: '12:00 - Pawiany Masajskie'),
    Activity(dayOfWeek: 'Środa', activityName: '13:00 - Lemury Katta'),
    Activity(dayOfWeek: 'Środa', activityName: '14:00 - Słonie'),
    Activity(dayOfWeek: 'Środa', activityName: '15:00 - Kotiki'),
    Activity(dayOfWeek: 'Czwartek', activityName: '09:15 - Żyrafy Siatkowane'),
    Activity(dayOfWeek: 'Czwartek', activityName: '10:00 - Tygrysy'),
    Activity(dayOfWeek: 'Czwartek', activityName: '11:00 - Hipopotamy'),
    Activity(dayOfWeek: 'Czwartek', activityName: '12:00 - Pawiany Masajskie'),
    Activity(dayOfWeek: 'Czwartek', activityName: '13:00 - Lemury Katta'),
    Activity(dayOfWeek: 'Czwartek', activityName: '14:30 - Zebry'),
    Activity(dayOfWeek: 'Czwartek', activityName: '15:00 - Kotiki'),
    Activity(dayOfWeek: 'Piątek', activityName: '09:15 - Żyrafy Siatkowane'),
    Activity(dayOfWeek: 'Piątek', activityName: '11:00 - Hipopotamy'),
    Activity(dayOfWeek: 'Piątek', activityName: '12:00 - Pawiany Masajskie'),
    Activity(dayOfWeek: 'Piątek', activityName: '15:00 - Kotiki'),
    Activity(dayOfWeek: 'Piątek', activityName: '13:00 - Lemury Katta'),
    Activity(dayOfWeek: 'Piątek', activityName: '11:30 - Nosorożce'),
    Activity(dayOfWeek: 'Piątek', activityName: '14:00 - Orangutany'),
    Activity(dayOfWeek: 'Sobota', activityName: '09:15 - Żyrafy Siatkowane'),
    Activity(dayOfWeek: 'Sobota', activityName: '11:00 - Hipopotamy'),
    Activity(dayOfWeek: 'Sobota', activityName: '12:00 - Pawiany Masajskie'),
    Activity(dayOfWeek: 'Sobota', activityName: '15:00 - Kotiki'),
    Activity(dayOfWeek: 'Sobota', activityName: '13:00 - Lemury Katta'),
    Activity(dayOfWeek: 'Sobota', activityName: '10:30 - Krokodyle'),
    Activity(dayOfWeek: 'Sobota', activityName: '14:30 - Węże'),
    Activity(dayOfWeek: 'Niedziela', activityName: '09:15 - Żyrafy Siatkowane'),
    Activity(dayOfWeek: 'Niedziela', activityName: '11:00 - Hipopotamy'),
    Activity(dayOfWeek: 'Niedziela', activityName: '12:00 - Pawiany Masajskie'),
    Activity(dayOfWeek: 'Niedziela', activityName: '15:00 - Kotiki'),
    Activity(dayOfWeek: 'Niedziela', activityName: '13:00 - Lemury Katta'),
    Activity(dayOfWeek: 'Niedziela', activityName: '10:00 - Sowy'),
    Activity(dayOfWeek: 'Niedziela', activityName: '14:00 - Panda'),
  ];

  @override
  void initState() {
    super.initState();
  }

  String _getDayOfWeek(int dayIndex) {
    switch (dayIndex) {
      case 1:
        return 'Poniedziałek';
      case 2:
        return 'Wtorek';
      case 3:
        return 'Środa';
      case 4:
        return 'Czwartek';
      case 5:
        return 'Piątek';
      case 6:
        return 'Sobota';
      case 7:
        return 'Niedziela';
      default:
        return '';
    }
  }

  TextStyle smallHeadline = const TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w500,
  );

  void showFullActivityList() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Pełny harmonogram'),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView.builder(
              itemCount: 7, // Liczba dni tygodnia
              itemBuilder: (context, dayIndex) {
                final dayOfWeek = _getDayOfWeek(dayIndex + 1);
                final dayActivities = activities
                    .where((activity) => activity.dayOfWeek == dayOfWeek)
                    .toList();

                if (dayActivities.isEmpty) {
                  return SizedBox.shrink(); // Pomijanie pustych dni
                }

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      dayOfWeek,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 8),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: dayActivities.length,
                      itemBuilder: (context, index) {
                        final activity = dayActivities[index];
                        return ListTile(
                          title: Text(activity.activityName),
                        );
                      },
                    ),
                    SizedBox(height: 16),
                  ],
                );
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Zamknij'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentDayOfWeek = DateTime.now().weekday;
    final filteredActivities = activities
        .where(
            (activity) => activity.dayOfWeek == _getDayOfWeek(currentDayOfWeek))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('ZOO Wrocław'),
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 32.0, 16.0, 16.0),
              child: Container(
                child: Text(
                  "Dzisiejszy harmonogram karmień zwierzaków",
                  style: smallHeadline,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(32.0, 0.0, 32.0, 16.0),
              child: Material(
                elevation: 1,
                borderRadius: BorderRadius.circular(10),
                child: InkWell(
                  onTap: showFullActivityList,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      // color: Colors.grey[200],
                    ),
                    height: MediaQuery.of(context).size.height / 3,
                    child: Scrollbar(
                      thumbVisibility: true,
                      child: ListView.builder(
                        itemCount: filteredActivities.length,
                        itemBuilder: (context, index) {
                          final activity = filteredActivities[index];
                          return ListTile(
                            title: Text(activity.activityName),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16.0, 16.0, 8.0, 16.0),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: GestureDetector(
                          onTap: () {
                            context.push('/home/animalgallery?title=Galeria');
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15.0),
                            child: Image.asset(
                              "assets/images/Galeria.jpg",
                              fit: BoxFit.cover,
                              width: 160.0,
                              height: 160.0,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        'Galeria',
                        style: smallHeadline,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16.0, 16.0, 8.0, 16.0),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: GestureDetector(
                          onTap: () {
                            context.push(
                                '/home/animalgallery?title=Twoje zdjęcia');
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15.0),
                            child: Image.asset(
                              "assets/images/Twoje zdjęcia.jpg",
                              fit: BoxFit.cover,
                              width: 160.0,
                              height: 160.0,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        'Twoje zdjęcia',
                        style: smallHeadline,
                      ),
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
