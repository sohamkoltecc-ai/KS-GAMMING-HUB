class GameData {
  final String title;
  final String price;
  final String imageUrl;
  final String description;
  final String downloadFile;
  bool whishlist;

  bool isDownloaded;
  String installLocation;
  
  final List<String> screenshots;
  
  GameData({
    required this.title,
    required this.price,
    required this.imageUrl,
    required this.description,
    required this.downloadFile,
    required this.whishlist,
    required this.isDownloaded,
    required this.installLocation,
    required this.screenshots,
  });

  factory GameData.fromJson(Map<String, dynamic> json) {
    return GameData(
      title: json["title"],
      price: json["price"],
      imageUrl: json["imageUrl"],
      description: json["description"] ?? "",
      downloadFile: json['downloadFile'],
      whishlist: json['whishlist'] ?? false,
      isDownloaded: json['isDownloaded'] ?? false,
      installLocation: json['installLocation'] ?? '',
      screenshots: List<String>.from(json["screenshots"]),
    );
  }
  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "price": price,
      "imageUrl": imageUrl,
      "description": description,
      "downloadFile": downloadFile,
      "whishlist": whishlist,
      "isDownloaded": isDownloaded,
      "installLocation": installLocation,
      "screenshots": screenshots,
    };
  }
}
