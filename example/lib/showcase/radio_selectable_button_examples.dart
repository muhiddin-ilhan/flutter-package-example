import 'package:flutter/material.dart';
import 'package:vc_product_widgets/components/buttons/radio_button_list/vc_product_radio_button_list.dart';
import 'package:vc_product_widgets/components/buttons/selectable_button_list/vc_product_selectable_button_list.dart';
import 'package:vc_product_widgets/utils/color_constant.dart';


class RadioSelectableButtonExamples extends StatefulWidget {
  const RadioSelectableButtonExamples({Key? key}) : super(key: key);

  @override
  State<RadioSelectableButtonExamples> createState() => _RadioSelectableButtonExamplesState();
}

class _RadioSelectableButtonExamplesState extends State<RadioSelectableButtonExamples> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
        "Radio/Selectable Button",
      )),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                VCProductSelectableButtonList(
                  buttons: const ["Today","Last 3 days", "This Month", "Last 3 Months", "Last 6 Months", "This Year"],
                  textAlign: TextAlign.center,
                  //padding: const EdgeInsets.symmetric(vertical: 30),
                  isRadio: true,
                  direction: Axis.vertical,
                  disabledButtons: const [0],
                  selectedButtonIndex: 0,
                  buttonWidth: 400,
                  unselectedColor: VCProductColors.instance.navyBlue6,
                  selectedColor: VCProductColors.instance.navyBlue,
                  onSelected: (value, index, selected) {
                    debugPrint(value.toString());
                  },),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: VCProductSelectableButtonList(
                    buttons: const ["Today","Last 3 days", "This Month", "Last 3 Months", "Last 6 Months", "This Year"],
                    textAlign: TextAlign.center,
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    isRadio: true,
                    disabledButtons: const [0],
                    selectedButtonIndex: 0,
                    isBorderVisible: true,
                    onSelected: (value, index, selected) {
                      debugPrint(value.toString());
                    },),
                ),


                VCProductRadioButtonList(
                  values: const ["Today","Last 3 days", "This Month", "Last 3 Months", "Last 6 Months", "This Year"],
                  disabledValues: const [3],
                  selectedValueIndex: 3,
                  padding: const EdgeInsets.symmetric(vertical: 3),
                  isRadio: true,
                  onSelected: (value, index, selected) {
                    debugPrint(value.toString());

                  },),

              ],
            ),
          ),
        ),
      ),
    );
  }


}

/*
class RadioExampleApp extends StatelessWidget {
  const RadioExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Radio Sample')),
        body: const Center(
          child: RadioListTileExample(),
        ),
      ),
    );
  }
}
class RadioListTileApp extends StatelessWidget {
  const RadioListTileApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      home: Scaffold(
        appBar: AppBar(title: const Text('RadioListTile Sample')),
        body: const RadioListTileExample(),
      ),
    );
  }
}

enum SingingCharacter { lafayette, jefferson }

class RadioListTileExample extends StatefulWidget {
  const RadioListTileExample({super.key});

  @override
  State<RadioListTileExample> createState() => _RadioListTileExampleState();
}

class _RadioListTileExampleState extends State<RadioListTileExample> {
  SingingCharacter? _character = SingingCharacter.lafayette;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        VCProductRadioButtonList(
          values: ["Today","Last 3 days", "This Month", "Last 3 Months", "Last 6 Months", "This Year"],
          padding: const EdgeInsets.symmetric(vertical: 10),
          isRadio: true,
          onSelected: (value, index, selected) {
            debugPrint(value.toString());

          },),
          //selectedTextStyle: TextStyle(color: Colors.white),
          //selectedColor: Colors.blue,
          //unselectedBorderColor: Colors.grey,


      ],
    );
  }
}

enum SingingCharacter { lafayette, jefferson }

class RadioExample extends StatefulWidget {
  const RadioExample({super.key});

  @override
  State<RadioExample> createState() => _RadioExampleState();
}

class _RadioExampleState extends State<RadioExample> {
  SingingCharacter? _character = SingingCharacter.lafayette;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          title: const Text('Lafayette'),
          leading: RadioButton<SingingCharacter>(
            value: SingingCharacter.lafayette,
            groupValue: _character,
            onChanged: (SingingCharacter? value) {
              setState(() {
                _character = value;
              });
            },
          ),
        ),
        ListTile(
          title: const Text('Thomas Jefferson'),
          leading: RadioButton<SingingCharacter>(
            value: SingingCharacter.jefferson,
            groupValue: _character,
            onChanged: (SingingCharacter? value) {
              setState(() {
                _character = value;
              });
            },
          ),
        ),
      ],
    );
  }
}
*/