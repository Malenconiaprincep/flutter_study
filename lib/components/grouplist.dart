import 'package:flutter/material.dart';

class GroupList extends StatefulWidget {
  @override
  _GroupListState createState() => _GroupListState();
}

class _GroupListState extends State<GroupList> {
  Widget _buildList() => ListView.builder(
      padding: const EdgeInsets.all(16.0),
      // 如果itemcount 为null 则为无限
      itemCount: 5,
      itemBuilder: /*1*/ (context, i) {
        return _buildRow('makuta1', 'fewew', Icons.people);
      });

  Widget _buildRow(String title, String subtitle, IconData icon) {
    return Container(
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          SizedBox(
            child: Row(
              children: <Widget>[
                Icon(
                  icon,
                  color: Colors.grey,
                ),
                Container(
                  margin: EdgeInsets.only(left: 10.0),
                  child: Text(title),
                )
              ],
            ),
          ),
          Icon(Icons.more_horiz)
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(child: _buildList());
  }
}
