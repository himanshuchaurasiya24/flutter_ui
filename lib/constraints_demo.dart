import 'package:flutter/material.dart';

class ConstraintsDemo extends StatefulWidget {
  const ConstraintsDemo({super.key});

  @override
  State<ConstraintsDemo> createState() => _ConstraintsDemoState();
}

class _ConstraintsDemoState extends State<ConstraintsDemo> {
  bool _showError = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Constraints Demo'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Understanding Unbounded Height Errors',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'When you put a scrollable widget (like ListView or GridView) inside another scrollable widget (like SingleChildScrollView or another ListView) without a fixed size, Flutter tries to give the inner scrollable widget infinite height. Since the outer widget also allows infinite height, this causes an error.',
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Show Error (Unbounded)'),
                Switch(
                  value: _showError,
                  onChanged: (value) {
                    setState(() {
                      _showError = value;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),
            if (_showError)
              Container(
                color: Colors.red.withOpacity(0.2),
                padding: const EdgeInsets.all(8),
                child: Column(
                  children: [
                    const Text(
                      'ERROR SCENARIO:\nListView inside Column inside SingleChildScrollView',
                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
                      textAlign: TextAlign.center,
                    ),
                    // This will cause the "Vertical viewport was given unbounded height" error
                    // because ListView tries to take all available vertical space,
                    // but SingleChildScrollView gives it infinite vertical space.
                    ListView.builder(
                      itemCount: 5,
                      itemBuilder: (context, index) => ListTile(
                        title: Text('Item $index'),
                        tileColor: Colors.red[100],
                      ),
                    ),
                  ],
                ),
              )
            else
              Container(
                color: Colors.green.withOpacity(0.2),
                padding: const EdgeInsets.all(8),
                child: Column(
                  children: [
                    const Text(
                      'FIXED SCENARIO:\nUsing SizedBox or shrinkWrap',
                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 10),
                    const Text('Option 1: Wrap in SizedBox (Fixed Height)'),
                    SizedBox(
                      height: 150, // Give it a fixed height constraint
                      child: ListView.builder(
                        itemCount: 5,
                        itemBuilder: (context, index) => ListTile(
                          title: Text('Expected Item $index'),
                          tileColor: Colors.green[100],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text('Option 2: shrinkWrap: true + Physics'),
                    // shrinkWrap: true calculates the height based on children.
                    // NeverScrollableScrollPhysics disables the inner scroll so it scrolls with the outer view.
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: 5,
                      itemBuilder: (context, index) => ListTile(
                        title: Text('ShrinkWrapped Item $index'),
                        tileColor: Colors.blue[100],
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
