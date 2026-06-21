class AppData {
  final String title;
  final String price;
  final String imageUrl;
  final String description;
  final String downloadFile;
  bool whishlist;

  bool isDownloaded;
  String installLocation;
  
  final List<String> screenshots;
  
  AppData({
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

  factory AppData.fromJson(Map<String, dynamic> json) {
    return AppData(
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
