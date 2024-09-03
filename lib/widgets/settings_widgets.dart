import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

import 'package:looncher/data/settings.dart';


class ClockSettings extends StatefulWidget {
  const ClockSettings({super.key});

  @override
  State<ClockSettings> createState() => _ClockSettingsState();
}

class _ClockSettingsState extends State<ClockSettings> {
  
  late StarBorder currentBorder;
  Map<StarBorder, String> borders = {
    octagonBorder :'octagon', scallopBorder :'scallop',
    circleBorder  :'circle', squareBorder  :'square',
  };

  Widget _clock(SettingsProvider settings, MapEntry<StarBorder, String> m) {
    return ChoiceChip(
      selected: m.key == currentBorder,
      onSelected: (_) => settings.setClockShape(m.key, m.value),
      shape: m.key,
      showCheckmark: false,
      label: SizedBox.square(dimension: 120, child: Center(child: Text(m.value))),
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Consumer<SettingsProvider>(
        builder: (context, settings, _) {
          currentBorder = settings.clockShape;
          return Wrap(
            spacing: 20, runSpacing: 20,
            children: List.generate(
              4,
              (int index) => _clock(settings, borders.entries.elementAt(index))
            )
          );
        }
      )
    );
  }
}


class AppearanceSettings extends StatefulWidget {
  const AppearanceSettings({super.key});

  @override
  State<AppearanceSettings> createState() => _AppearanceSettingsState();
}
class _AppearanceSettingsState extends State<AppearanceSettings> {
  
  Color pickedColor = Colors.blue;

  @override
  Widget build(BuildContext context) {
    final main = Provider.of<MainProvider>(context);
    return ListView(
      children: [
        ListTile(
          leading: Icon(Icons.color_lens),
          title: Text(
            'Generate Theme from Color',
            style: TextStyle(fontSize: 16),
        )),
        HueRingPicker(
          enableAlpha: false,
          pickerColor: pickedColor,
          onColorChanged: (color) async {
            pickedColor = color;
            Future.delayed(Duration(milliseconds: 0),
              () => main.setcolorScheme(color)); 
          }
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.image),
          title: Text('Generate Theme from an Image'),
          onTap: () async {
             FilePickerResult? result = await FilePicker.platform.pickFiles();
             main.setWallpaperColorScheme(result!.files.single.path!);
          }
        )
      ]
    );
  }
}

enum IconsSizes {small, mediam, large}

class AppsSettings extends StatelessWidget {
  const AppsSettings({super.key});

  double parseSize(IconsSizes size) {
    switch (size) {
      case IconsSizes.small: return 90;
      case IconsSizes.mediam: return 120;
      case IconsSizes.large: return 140;
    }
  }

  IconsSizes doubleToSize(double d) {
    switch (d) {
      case 90: return IconsSizes.small;
      case 120: return IconsSizes.mediam;
      case 140: return IconsSizes.large;
      default: return IconsSizes.mediam;
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Consumer<SettingsProvider>(
      builder: (context, settings, _) => Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text("Apps drawer icons size"),
          SizedBox(height: 10),
          SegmentedButton<IconsSizes>(
            selected: <IconsSizes>{doubleToSize(settings.iconSize)},
            onSelectionChanged: (Set<IconsSizes> iconsSize) {
              settings.setIconSize(parseSize(iconsSize.first));
            },
            segments: const [
              ButtonSegment<IconsSizes>(
                value: IconsSizes.small,
                label: Text('small')
              ),
              ButtonSegment<IconsSizes>(
                value: IconsSizes.mediam,
                label: Text('mediam')
              ),
              ButtonSegment<IconsSizes>(
                value: IconsSizes.large,
                label: Text('large')
              ),
            ],
          )
        ]
      )
    ));
  }
}
