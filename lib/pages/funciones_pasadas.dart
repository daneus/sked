import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sked/main.dart';

class FuncionesPasadas extends StatefulWidget {
  const FuncionesPasadas({super.key});

  @override
  State<FuncionesPasadas> createState() => _FuncionesPasadasState();
}

class _FuncionesPasadasState extends State<FuncionesPasadas> {
  @override
  Widget build(BuildContext context) {
    final dataModel = Provider.of<DataModel>(context);

    return FutureBuilder(
      future: dataModel.fetchDataFromAPI(),
      builder: (context, snapshot) {
        final List<dynamic> pictures = snapshot.data?.fotosVisitas ?? [];
        return ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: pictures.length,
          itemBuilder: (context, index) {
            final picture = pictures[index];
            return Container(
                width: 300, height: 100, child: Image.network(picture));
          },
        );
      },
    );
  }
}
