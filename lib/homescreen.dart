import 'dart:developer';
import 'dart:io';

import 'package:bloc_sample/model/memeModel.dart';
import 'package:http/http.dart' as mubs;
import 'package:flutter/material.dart';

class Homeee extends StatelessWidget {
  const Homeee({Key? key}) : super(key: key);
 Future<MemeModel?>? loadData() async {
    const url = "https://api.imgflip.com/get_memes";
    var pathUrl = Uri.parse(url);
    try {
      var response = await mubs.get(
        pathUrl,
      );
      if (response.statusCode == 200) {
        String responseString = response.body;
        MemeModel data = memeModelFromJson(responseString);
        return data;
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: loadData(),
          builder: (
            BuildContext context,
            AsyncSnapshot<MemeModel?> snapshot,
          ) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  return Center(
                    child: Image.network(
                      snapshot.data!.data!.memes![index].url!,
                    ),
                  );
                },
                itemCount: snapshot.data!.data!.memes!.length,
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );

            }
          }),
    );
  }
}
