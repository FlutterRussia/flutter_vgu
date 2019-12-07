import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_vgu/models/news_model.dart';
import 'package:intl/intl.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

class ListItem extends StatelessWidget {
  ListItem(this.model);
  final Articles model;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      child: GestureDetector(
        onTap: () => logicWeb(),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Container(
            color: Colors.deepPurple,
            child: Stack(
              children: <Widget>[
                if (model.urlToImage != null && model.urlToImage.isNotEmpty)
                  Image.network(
                    model.urlToImage ?? '',
                    fit: BoxFit.contain,
                  ),
                _columnWithContent(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _columnWithContent() {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          _headerItemBuild(),
          _textItemBuild(),
          _dateItemBuild(),
        ],
      ),
    );
  }

  Widget _headerItemBuild() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          model.source.name,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        Container(
          child: Row(
            children: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.share,
                  color: Colors.white,
                ),
                onPressed: () {
                  Share.share(model.url);
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _dateItemBuild() {
    // Parse date to normal format
    DateFormat format = DateFormat("yyyy-MM-dd'T'HH:mm:ss");
    final unformedDate = format.parse(model.publishedAt);
    Duration difference = unformedDate.difference(DateTime.now());

    return Container(
      padding: EdgeInsets.only(top: 12),
      child: Text(
        (int.tryParse(difference.inHours.abs().toString()) < 12)
            ? difference.inHours.abs().toString() + " hours ago"
            : difference.inDays.abs().toString() + " days ago",
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
      ),
      alignment: Alignment.centerLeft,
    );
  }

  void logicWeb() async {
    if (await canLaunch(model.url)) {
      await launch(model.url);
    } else {
      throw 'Could not launch ${model.url}';
    }
  }

  Widget _textItemBuild() {
    return Text(
      model.title,
      maxLines: 3,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white),
    );
  }
}
