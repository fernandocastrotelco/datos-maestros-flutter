import 'package:flutter/material.dart';

class DashBoardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('La persona se registró con exito'),
            SizedBox(height: 7.0),
            Text('El número id es 1'),
            SizedBox(height: 50.0),
            ElevatedButton(
                onPressed: () => Navigator.pop(context), child: Text('Volver'))
          ],
        ),
      ),
    ));
  }
}
