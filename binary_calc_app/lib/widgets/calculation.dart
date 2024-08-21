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

class Calculation extends StatefulWidget {
  const Calculation({super.key});

  @override
  State<Calculation> createState() => _CalculationState();
}

class _CalculationState extends State<Calculation> {
  final TextEditingController _controller1 = TextEditingController();
  final TextEditingController _controller2 = TextEditingController();

  final FocusNode _focusNode1 = FocusNode();
  final FocusNode _focusNode2 = FocusNode();
  bool isField1Active = true; // Tracks which field is active

  String value1 = '';
  String value2 = '';
  String result = '';
  // Added state variable to manage the button text
  String buttonText = '?';

  void _addDigit(String digit) async {
    bool isVibrationOn = context.read<SettingsModel>().isVibrationOn;
    await handleVibration(isVibrationOn);
    setState(() {
      if (isField1Active) {
        if (_controller1.text.length < 30) {
          _controller1.text += digit;
          value1 = _controller1.text;
        }
      } else {
        if (_controller2.text.length < 30) {
          _controller2.text += digit;
          value2 = _controller2.text;
        }
      }
    });
  }

  void _removeDigit() async {
    bool isVibrationOn = context.read<SettingsModel>().isVibrationOn;
    await handleVibration(isVibrationOn);
    setState(() {
      if (isField1Active) {
        if (_controller1.text.isNotEmpty) {
          _controller1.text =
              _controller1.text.substring(0, _controller1.text.length - 1);
          value1 = _controller1.text;
        }
      } else {
        if (_controller2.text.isNotEmpty) {
          _controller2.text =
              _controller2.text.substring(0, _controller2.text.length - 1);
          value2 = _controller2.text;
        }
      }
    });
  }

  void _clear() async {
    bool isVibrationOn = context.read<SettingsModel>().isVibrationOn;
    await handleVibration(isVibrationOn);
    setState(() {
      _controller1.clear();
      _controller2.clear();
      value1 = '';
      value2 = '';
      result = '';
      buttonText = '?';
      isField1Active = true;
      _focusNode1.requestFocus();
    });
  }

  void _switchFocusToField2(String char) async {
    bool isVibrationOn = context.read<SettingsModel>().isVibrationOn;
    await handleVibration(isVibrationOn);
    setState(() {
      _focusNode2.requestFocus();
      buttonText = char;
      isField1Active = false;
    });
  }

  void _switchFocusToField2Tap() async {
    bool isVibrationOn = context.read<SettingsModel>().isVibrationOn;
    await handleVibration(isVibrationOn);
    setState(() {
      _focusNode2.requestFocus();
      isField1Active = false;
    });
  }

  void _switchFocusToField1Tap() async {
    bool isVibrationOn = context.read<SettingsModel>().isVibrationOn;
    await handleVibration(isVibrationOn);
    setState(() {
      _focusNode1.requestFocus();
      isField1Active = true;
    });
  }

  void _performOperation() async {
    bool isVibrationOn = context.read<SettingsModel>().isVibrationOn;
    await handleVibration(isVibrationOn);
    setState(() {
      if (buttonText == '?') {
        result = 'Operation not entered';
      } else if (value1.isNotEmpty && value2.isNotEmpty) {
        try {
          if (buttonText == '+') {
            result = addBinary(value1, value2);
          } else if (buttonText == '-') {
            result = subtractBinary(value1, value2);
          } else if (buttonText == '/') {
            result = divideBinary(value1, value2);
          } else if (buttonText == 'x') {
            result = multBinary(value1, value2);
          } else {
            result = 'Invalid operation';
          }
        } catch (e) {
          result = 'Error: ${e.toString()}';
        }
      } else {
        result = 'Numbers not entered';
      }
    });
  }

  @override
  void dispose() {
    _controller1.dispose();
    _controller2.dispose();
    _focusNode1.dispose();
    _focusNode2.dispose();
    super.dispose();
  }

  void _copyResult() async {
    bool isVibrationOn = context.read<SettingsModel>().isVibrationOn;
    await handleVibration(isVibrationOn);
    Clipboard.setData(ClipboardData(text: result)).then((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Result copied to clipboard')),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    Color colorAction = Theme.of(context).colorScheme.secondaryFixedDim;

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
          // Field 1
          Opacity(
            opacity: isField1Active ? 1.0 : 0.5,
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
                  child: AutoSizeTextField(
                    readOnly: true,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.surface,
                      fontSize: screenWidth * 0.06,
                    ),
                    minFontSize: 12,
                    maxLines: 1,
                    decoration: InputDecoration(
                      labelText: 'Number 1',
                      labelStyle: TextStyle(
                        fontSize: screenWidth * 0.03,
                        color: Theme.of(context).colorScheme.surface,
                      ),
                      counterStyle: TextStyle(
                        color: Theme.of(context).colorScheme.surface,
                        fontSize: screenWidth * 0.03,
                      ),
                    ),
                    controller: _controller1,
                    focusNode: _focusNode1,
                    maxLength: 30,
                    onTap: _switchFocusToField1Tap,
                  ),
                ),
              ),
            ),
          ),
          //_____________________________________________________________________________
          Padding(
            padding: EdgeInsets.only(bottom: screenHeight * 0.003),
            child: SizedBox(
              height: screenHeight * 0.07, // Уменьшенная высота
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      buttonText,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.inversePrimary,
                        fontSize: screenWidth * 0.1,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          //_____________________________________________________________________________
          // Field 2
          Opacity(
            opacity: isField1Active ? 0.5 : 1.0,
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
                  child: AutoSizeTextField(
                    readOnly: true,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.surface,
                      fontSize: screenWidth * 0.06, // font size of input field
                    ),
                    minFontSize: 12,
                    maxLines: 1,
                    decoration: InputDecoration(
                      labelText: 'Number 2',
                      labelStyle: TextStyle(
                        fontSize: screenWidth * 0.03,
                        color: Theme.of(context).colorScheme.surface,
                      ),
                      counterStyle: TextStyle(
                        color: Theme.of(context)
                            .colorScheme
                            .surface, // color of counter
                        fontSize: screenWidth * 0.03, // font size of counter
                      ),
                    ),
                    controller: _controller2,
                    focusNode: _focusNode2,
                    maxLength: 30,
                    onTap: _switchFocusToField2Tap,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: screenHeight * 0.04,
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: EdgeInsets.only(left: screenWidth * 0.04),
                child: Text(
                  'Result',
                  style: TextStyle(
                    fontSize: screenWidth * 0.03,
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),
                ),
              ),
            ),
          ),
          //_____________________________________________________________________________
          Expanded(
            child: StaggeredGrid.count(
              crossAxisCount: 5,
              mainAxisSpacing: screenWidth * 0.02,
              crossAxisSpacing: screenHeight * 0.005,
              children: [
                StaggeredGridTile.count(
                  crossAxisCellCount: 4,
                  mainAxisCellCount: 1,
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
                          maxLines: 2,
                          minFontSize: 12,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ),
                ),
                StaggeredGridTile.count(
                  crossAxisCellCount: 1,
                  mainAxisCellCount: 1,
                  child: IconButton(
                    onPressed: _copyResult,
                    icon: Icon(Icons.copy,
                        color: Theme.of(context).colorScheme.inversePrimary),
                  ),
                ),
                const StaggeredGridTile.count(
                    crossAxisCellCount: 3,
                    mainAxisCellCount: 1,
                    child: SizedBox(
                      width: 5,
                    )),
                StaggeredGridTile.count(
                  crossAxisCellCount: 1,
                  mainAxisCellCount: 1,
                  child: SquareElevatedButton(
                    text: 'C',
                    color: colorAction,
                    onPressed: _clear,
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
                    color: Theme.of(context).colorScheme.onSecondary,
                    onPressed: () => _addDigit('1'),
                  ),
                ),
                StaggeredGridTile.count(
                  crossAxisCellCount: 2,
                  mainAxisCellCount: 1,
                  child: OvalElevatedButton(
                    text: '0',
                    color: Theme.of(context).colorScheme.onSecondary,
                    onPressed: () => _addDigit('0'),
                  ),
                ),
                StaggeredGridTile.count(
                  crossAxisCellCount: 1,
                  mainAxisCellCount: 1,
                  child: RoundElevatedButton(
                    text: '.',
                    color: Theme.of(context).colorScheme.onSecondary,
                    onPressed: () => _addDigit('.'),
                  ),
                ),
                StaggeredGridTile.count(
                  crossAxisCellCount: 1,
                  mainAxisCellCount: 1,
                  child: SquareElevatedButton(
                    text: '+',
                    color: colorAction,
                    onPressed: () => _switchFocusToField2('+'),
                  ),
                ),
                StaggeredGridTile.count(
                  crossAxisCellCount: 1,
                  mainAxisCellCount: 1,
                  child: SquareElevatedButton(
                    text: '-',
                    color: colorAction,
                    onPressed: () => _switchFocusToField2('-'),
                  ),
                ),
                StaggeredGridTile.count(
                  crossAxisCellCount: 1,
                  mainAxisCellCount: 1,
                  child: SquareElevatedButton(
                    text: '/',
                    color: colorAction,
                    onPressed: () => _switchFocusToField2('/'),
                  ),
                ),
                StaggeredGridTile.count(
                  crossAxisCellCount: 1,
                  mainAxisCellCount: 1,
                  child: SquareElevatedButton(
                    text: 'x',
                    color: colorAction,
                    onPressed: () => _switchFocusToField2('x'),
                  ),
                ),
                StaggeredGridTile.count(
                  crossAxisCellCount: 1,
                  mainAxisCellCount: 1,
                  child: SquareElevatedButton(
                    text: '=',
                    color: colorAction,
                    onPressed: _performOperation, // Switch focus between fields
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
