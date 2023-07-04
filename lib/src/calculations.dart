import 'my_data_types.dart';

class Calculations {
  static double yuzdelikArtis(
      {required Product olderReceipt, required Product newerReceipt}) {
    if (olderReceipt.brand != newerReceipt.brand ||
        olderReceipt.amount.unit != newerReceipt.amount.unit ||
        olderReceipt.amount.howMany != newerReceipt.amount.howMany) {
      throw "ayni turde urun degil";
    } else {
      double degisimYuzde = (newerReceipt.price- olderReceipt.price) /
          olderReceipt.price*
          100;
      return degisimYuzde;
    }
  }

}
