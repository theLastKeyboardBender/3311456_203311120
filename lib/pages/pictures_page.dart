import 'package:flutter/material.dart';
//import 'imp/my_data_type.dart';

class ResimlerPage extends StatefulWidget {
  const ResimlerPage({
    super.key,
    /*this.listOfReceipts*/
  });

  //final List<Receipt> listOfReceipts;
  @override
  State<StatefulWidget> createState() {
    return ResimlerPageState();
  }
}

class ResimlerPageState extends State<ResimlerPage> {
  @override
  Widget build(BuildContext context) {
    /*List<Image> myReceipts;
    int length;


    if(widget.listOfReceipts?.length==null)
    {
      length=0;
    }
    else
    {
      length=widget.listOfReceipts!.length;
    }
  
    for(int i=0;i<length;i++)
    {
      myReceipts?.add(widget.listOfReceipts![i].receiptImage);
    }*/
    return Container(
      margin: const EdgeInsets.all(5),
      padding: const EdgeInsets.all(5),
      child: GridView.count(
        crossAxisCount: 3,
        children: [
          Image.asset(
            'lib/receipts/receipt1.jpg',
          ),
        ],
      ),
    );
  }
}
