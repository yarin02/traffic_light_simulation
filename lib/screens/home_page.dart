import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/consts.dart';
import '../widgets/traffic_light_widget.dart';
import '../providers/global_timer.dart'; // Make sure the import is correct

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isSyncMode = false;

  // Toggle between synchronized and chaos modes and reset the global timer
  void _toggleMode() {
    setState(() {
      isSyncMode = !isSyncMode;
    });
    Provider.of<GlobalTimerProvider>(context, listen: false).reset();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: kVerticalPadding,
              child: ElevatedButton(
                onPressed: _toggleMode,
                style: ElevatedButton.styleFrom(
                  backgroundColor: kBlueButton,
                  foregroundColor: kWhiteButtonText,
                ),
                child: Text(isSyncMode ? "Chaos Mode" : "Synchronize Mode"),
              ),
            ),
            // Grid of Traffic Lights
            Expanded(
              child: Padding(
                padding: kDefaultPadding,
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: kGridCrossAxisCount,
                    mainAxisSpacing: kGridMainAxisSpacing,
                    crossAxisSpacing: kGridCrossAxisSpacing,
                    childAspectRatio: kGridChildAspectRatio,
                  ),
                  itemCount: kTrafficLightCount,
                  itemBuilder: (context, index) {
                    return TrafficLightWidget(
                      key: ValueKey('traffic-light-$index-${isSyncMode ? "sync" : "chaos"}'),
                      isSync: isSyncMode,
                      index: index,
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
