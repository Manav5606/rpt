class WalletModel {
  String name;
  String image;
  String percentage;
  String currency;
  String balance;

  WalletModel({
    required this.image,
    required this.name,
    required this.currency,
    required this.percentage,
    required this.balance,
  });
}

List<WalletModel> walletList = [
  WalletModel(
    image: 'assets/images/image1.png',
    name: "Ethereum",
    currency: "ETH",
    percentage: "+4.93%",
    balance: "0",
  ),
  WalletModel(
      balance: "0",
      image: 'assets/images/image2.png',
      name: "Binance Coin",
      currency: "BNB",
      percentage: "+7.33%"),
  WalletModel(
      balance: "0",
      image: 'assets/images/image4.png',
      name: "Bitcoin",
      currency: "BTC",
      percentage: "-4.93%"),
  WalletModel(
      balance: "0",
      image: 'assets/images/image1.png',
      name: "Dash",
      currency: "DASH",
      percentage: "+4.93%"),
  WalletModel(
      balance: "0",
      image: 'assets/images/image2.png',
      name: "Cardano",
      currency: "ADA",
      percentage: "+14.93%"),
  WalletModel(
      balance: "0",
      image: 'assets/images/image3.png',
      name: "Polygon",
      currency: "MATIC",
      percentage: "+9.03%"),
  WalletModel(
      balance: "0",
      image: 'assets/images/image4.png',
      name: "Tron",
      currency: "TRX",
      percentage: "+4.93%"),
  WalletModel(
      balance: "0",
      image: 'assets/images/image1.png',
      name: "Ethereum",
      currency: "ETH",
      percentage: "+4.93%"),
  WalletModel(
      balance: "0",
      image: 'assets/images/image2.png',
      name: "Binance Coin",
      currency: "BNB",
      percentage: "+7.33%"),
  WalletModel(
      balance: "0",
      image: 'assets/images/image4.png',
      name: "Bitcoin",
      currency: "BTC",
      percentage: "-4.93%"),
  WalletModel(
      balance: "0",
      image: 'assets/images/image1.png',
      name: "Dash",
      currency: "DASH",
      percentage: "+4.93%"),
  WalletModel(
      balance: "0",
      image: 'assets/images/image2.png',
      name: "Cardano",
      currency: "ADA",
      percentage: "+14.93%"),
  WalletModel(
      balance: "0",
      image: 'assets/images/image3.png',
      name: "Polygon",
      currency: "MATIC",
      percentage: "+9.03%"),
  WalletModel(
      balance: "0",
      image: 'assets/images/image4.png',
      name: "Tron",
      currency: "TRX",
      percentage: "+4.93%"),
];
