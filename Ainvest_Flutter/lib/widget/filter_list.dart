import 'package:flutter/material.dart';

class FilterList extends StatefulWidget {
  const FilterList({Key? key}) : super(key: key);
  @override
  _FilterListState createState() => _FilterListState();
}

class _FilterListState extends State<FilterList> {
  // radio button group value
  int _radioGroupValue = 0;

  // dropbox selected value
  String _selectedDropdownValue = 'Option 1';

  // slider value
  double _sliderValue = 50.0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 300,
        height: 800,
        child: Column(
          children: [
            SizedBox(
              width: 48,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Radio(
                    value: 0,
                    groupValue: _radioGroupValue,
                    onChanged: (value) {
                      setState(() {
                        _radioGroupValue = value as int;
                      });
                    },
                  ),
                  Text('Option 1'),
                  Radio(
                    value: 1,
                    groupValue: _radioGroupValue,
                    onChanged: (value) {
                      setState(() {
                        _radioGroupValue = value as int;
                      });
                    },
                  ),
                  Text('Option 2'),
                ],
              ),
            ),
            SizedBox(
              height: double.infinity,
              width: double.infinity,
              child: DropdownButton<String>(
                value: _selectedDropdownValue,
                onChanged: (value) {
                  setState(() {
                    _selectedDropdownValue = value!;
                  });
                },
                items: [
                  DropdownMenuItem<String>(
                    value: 'Option 1',
                    child: Text('Option 1'),
                  ),
                  DropdownMenuItem<String>(
                    value: 'Option 2',
                    child: Text('Option 2'),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: double.infinity,
              width: double.infinity,
              child: Slider(
                value: _sliderValue,
                onChanged: (value) {
                  setState(() {
                    _sliderValue = value;
                  });
                },
                min: 0,
                max: 100,
              ),
            ),
          ],
        ));
  }
}
