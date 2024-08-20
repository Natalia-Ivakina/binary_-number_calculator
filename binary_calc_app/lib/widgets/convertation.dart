import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:auto_size_text_field/auto_size_text_field.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:binary_calc_app/utils/math.dart';
import 'package:binary_calc_app/utils/vibration.dart';
import 'package:binary_calc_app/providers/settigns_model.dart';
import 'package:binary_calc_app/widgets/buttons_widget.dart';

class Convertation extends StatefulWidget {
  const Convertation({super.key});

  @override
  State<Convertation> createState() => _ConvertationState();
}

class _ConvertationState extends State<Convertation> {
  late TextEditingController _controller;

  String value1 = '';
  String result = '';

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _addDigit(String digit) async {
    bool isVibrationOn = context.read<SettingsModel>().isVibrationOn;
    await handleVibration(isVibrationOn);
    setState(() {
      if (_controller.text.length < 40) {
        _controller.text += digit;
        value1 = _controller.text;
      }
    });
  }

  void _removeDigit() async {
    bool isVibrationOn = context.read<SettingsModel>().isVibrationOn;
    await handleVibration(isVibrationOn);
    setState(() {
      if (_controller.text.isNotEmpty) {
        _controller.text =
            _controller.text.substring(0, _controller.text.length - 1);
        value1 = _controller.text;
      }
    });
  }

  void _clear() async {
    bool isVibrationOn = context.read<SettingsModel>().isVibrationOn;
    await handleVibration(isVibrationOn);
    setState(() {
      _controller.clear();
      value1 = '';
      result = '';
    });
  }

  void _performOperation(String operation) async {
    bool isVibrationOn = context.read<SettingsModel>().isVibrationOn;
    await handleVibration(isVibrationOn);
    setState(() {
      if (operation == '2') {
        result = binaryToDecimal(value1);
      } else if (operation == '10') {
        result = decimalToBinary(value1);
      }
    });
  }

  void _pasteFromClipboard() async {
    bool isVibrationOn = context.read<SettingsModel>().isVibrationOn;
    await handleVibration(isVibrationOn);
    ClipboardData? clipboardData = await Clipboard.getData('text/plain');
    setState(() {
      if (clipboardData != null &&
          RegExp(r'^-?[0-9]+(\.[0-9]*)?$').hasMatch(clipboardData.text!)) {
        _controller.text = clipboardData.text!;
        value1 = _controller.text;
        // Очистка буфера обмена
        Clipboard.setData(const ClipboardData(text: ''));
      } else {
        _controller.text = 'No copied data';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Color colorAction = Theme.of(context).colorScheme.secondaryFixedDim;
    Color colorNum = Theme.of(context).colorScheme.onSecondary;

    // Access SettingsModel through Provider
    final settings = Provider.of<SettingsModel>(context);
    double screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth > settings.maxWidth) {
      screenWidth = settings.maxWidth; // Максимальная ширина для мобильных
    }
    double screenHeight = MediaQuery.of(context).size.height;
    if (screenHeight > settings.maxHeight) {
      screenHeight = settings.maxHeight; // Максимальная высота для мобильных
    }

    return Padding(
      padding: EdgeInsets.only(
          top: screenHeight * 0.03,
          left: screenWidth * 0.04,
          right: screenWidth * 0.04,
          bottom: screenHeight * 0.04),
      child: Column(
        children: [
          //_____________________________________________________________________________
          SizedBox(
            height: screenHeight * 0.12,
            child: Card(
              color: Theme.of(context).colorScheme.onPrimary,
              child: Padding(
                padding: EdgeInsets.only(
                  top: 0,
                  right: screenWidth * 0.02,
                  left: screenWidth * 0.02,
                  bottom: screenHeight * 0.002,
                ),
                child: AutoSizeTextField(
                  readOnly: true,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.surface,
                    fontSize: screenWidth * 0.06, // Устанавливаем размер шрифта
                  ),
                  minFontSize: 12,
                  maxLines: 1,
                  decoration: InputDecoration(
                    labelText: 'The number to convert',
                    labelStyle: TextStyle(
                      fontSize: screenWidth * 0.03, // Размер шрифта
                      color: Theme.of(context).colorScheme.surface,
                    ),
                    counterStyle: TextStyle(
                      color: Theme.of(context)
                          .colorScheme
                          .surface, // Устанавливаем цвет счётчика
                      fontSize: screenWidth *
                          0.03, // Задаем размер шрифта для счётчика
                    ),
                  ),
                  controller: _controller,
                  maxLength: 40,
                ),
              ),
            ),
          ),
          //_____________________________________________________________________________
          Text(
            '↑↓',
            style: TextStyle(
              color: Theme.of(context).colorScheme.inversePrimary,
              fontSize: screenWidth * 0.1,
            ),
          ),
          //_____________________________________________________________________________
          Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: screenHeight * 0.12,
                  child: Card(
                    color: Theme.of(context).colorScheme.onPrimary,
                    child: Padding(
                      padding: EdgeInsets.only(
                        top: 0,
                        right: screenWidth * 0.02,
                        left: screenWidth * 0.02,
                        bottom: screenHeight * 0.002,
                      ),
                      child: Center(
                        child: AutoSizeText(
                          result,
                          style: TextStyle(
                            fontSize: RegExp(r'[a-zA-Z]').hasMatch(result)
                                ? null
                                : screenWidth * 0.06,
                            color: RegExp(r'[a-zA-Z]').hasMatch(result)
                                ? Theme.of(context).colorScheme.error
                                : Theme.of(context).colorScheme.surface,
                          ),
                          maxLines: 3,
                          minFontSize: 12,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: screenHeight * 0.04,
          ),
          //_____________________________________________________________________________
          Expanded(
            child: StaggeredGrid.count(
              crossAxisCount: 5,
              mainAxisSpacing: screenWidth * 0.02,
              crossAxisSpacing: screenHeight * 0.005,
              children: [
                StaggeredGridTile.count(
                  crossAxisCellCount: 1,
                  mainAxisCellCount: 1,
                  child: RoundElevatedButton(
                    text: '6',
                    color: colorNum,
                    onPressed: () => _addDigit('6'),
                  ),
                ),
                StaggeredGridTile.count(
                  crossAxisCellCount: 1,
                  mainAxisCellCount: 1,
                  child: RoundElevatedButton(
                    text: '7',
                    color: colorNum,
                    onPressed: () => _addDigit('7'),
                  ),
                ),
                StaggeredGridTile.count(
                  crossAxisCellCount: 1,
                  mainAxisCellCount: 1,
                  child: RoundElevatedButton(
                    text: '8',
                    color: colorNum,
                    onPressed: () => _addDigit('8'),
                  ),
                ),
                StaggeredGridTile.count(
                  crossAxisCellCount: 1,
                  mainAxisCellCount: 1,
                  child: RoundElevatedButton(
                    text: '9',
                    color: colorNum,
                    onPressed: () => _addDigit('9'),
                  ),
                ),
                StaggeredGridTile.count(
                  crossAxisCellCount: 1,
                  mainAxisCellCount: 1,
                  child: IconButton(
                    onPressed: _pasteFromClipboard,
                    icon: Icon(Icons.paste,
                        color: Theme.of(context).colorScheme.inversePrimary),
                  ),
                ),
                StaggeredGridTile.count(
                  crossAxisCellCount: 1,
                  mainAxisCellCount: 1,
                  child: RoundElevatedButton(
                    text: '2',
                    color: colorNum,
                    onPressed: () => _addDigit('2'),
                  ),
                ),
                StaggeredGridTile.count(
                  crossAxisCellCount: 1,
                  mainAxisCellCount: 1,
                  child: RoundElevatedButton(
                    text: '3',
                    color: colorNum,
                    onPressed: () => _addDigit('3'),
                  ),
                ),
                StaggeredGridTile.count(
                  crossAxisCellCount: 1,
                  mainAxisCellCount: 1,
                  child: RoundElevatedButton(
                    text: '4',
                    color: colorNum,
                    onPressed: () => _addDigit('4'),
                  ),
                ),
                StaggeredGridTile.count(
                  crossAxisCellCount: 1,
                  mainAxisCellCount: 1,
                  child: RoundElevatedButton(
                    text: '5',
                    color: colorNum,
                    onPressed: () => _addDigit('5'),
                  ),
                ),
                StaggeredGridTile.count(
                  crossAxisCellCount: 1,
                  mainAxisCellCount: 1,
                  child: SquareElevatedButton(
                    text: '⌫',
                    color: colorAction,
                    onPressed: _removeDigit,
                  ),
                ),
                StaggeredGridTile.count(
                  crossAxisCellCount: 2,
                  mainAxisCellCount: 1,
                  child: OvalElevatedButton(
                    text: '1',
                    color: colorNum,
                    onPressed: () => _addDigit('1'),
                  ),
                ),
                StaggeredGridTile.count(
                  crossAxisCellCount: 2,
                  mainAxisCellCount: 1,
                  child: OvalElevatedButton(
                    text: '0',
                    color: colorNum,
                    onPressed: () => _addDigit('0'),
                  ),
                ),
                StaggeredGridTile.count(
                  crossAxisCellCount: 1,
                  mainAxisCellCount: 1,
                  child: RoundElevatedButton(
                    text: '.',
                    color: colorNum,
                    onPressed: () => _addDigit('.'),
                  ),
                ),
                StaggeredGridTile.count(
                  crossAxisCellCount: 2,
                  mainAxisCellCount: 1,
                  child: SquareElevatedButton(
                    text: '2 → 10',
                    color: colorAction,
                    onPressed: () => _performOperation('2'),
                  ),
                ),
                StaggeredGridTile.count(
                  crossAxisCellCount: 2,
                  mainAxisCellCount: 1,
                  child: SquareElevatedButton(
                    text: '10 → 2',
                    color: colorAction,
                    onPressed: () => _performOperation('10'),
                  ),
                ),
                StaggeredGridTile.count(
                  crossAxisCellCount: 1,
                  mainAxisCellCount: 1,
                  child: SquareElevatedButton(
                    text: 'C',
                    color: colorAction,
                    onPressed: _clear,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
