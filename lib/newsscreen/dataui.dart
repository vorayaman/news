import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:news/newsscreen/contoler.dart';
import 'package:news/newsscreen/news%20modal.dart';

class UI extends StatefulWidget {
  const UI({Key? key}) : super(key: key);

  @override
  State<UI> createState() => _UIState();
}

class _UIState extends State<UI> {
  News news = Get.put(News());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            ElevatedButton(onPressed: () {
              news.post("yaman", "flutter");
            }, child: Text("post")),
            Expanded(
              child: FutureBuilder<Newsdata>(
                future: news.apicall(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(child: Text("${snapshot.error}"));
                  } else if (snapshot.hasData) {
                    Newsdata newsdata = snapshot.data!;

                    return ListView.builder(
                      itemBuilder: (context, index) {
                        print(newsdata.articles[index].urlToImage);
                        return Container(
                          alignment: Alignment.center,
                          child: Column(
                            children: [
                              Container(
                                height: 200,
                                child: Image.network(
                                  newsdata.articles[index].urlToImage.toString(),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text("${newsdata.articles[index].publishedAt}"),
                              Text("${newsdata.articles[index].source.name}"),
                            ],
                          ),
                        );
                      },
                      itemCount: newsdata.articles.length,
                    );
                  }
                  ;
                  return CircularProgressIndicator();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
