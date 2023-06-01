class StoredFilePath {
  final String storedFilePath;

  StoredFilePath({
    required this.storedFilePath,
  });

  factory StoredFilePath.fromJson(Map<String, dynamic> json) {
    return StoredFilePath(
      storedFilePath: json['Data']['StoredFilePath'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'storedFilePath': storedFilePath,
    };
  }
}
