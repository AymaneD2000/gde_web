class Video {
  String idVideo;
  String video;
  String id_pub;

  Video({
    required this.id_pub,
    required this.idVideo,
    required this.video,
  });

  // toJson method to convert Photo object to a Map
  Map<String, dynamic> toJson() {
    return {
      'id_pub': id_pub,
      'id': idVideo,
      'video': video,
    };
  }

  // fromJson method to create a Photo object from a Map
  factory Video.fromJson(Map<String, dynamic> json) {
    return Video(
      id_pub: json['id_pub'],
      idVideo: json['id'],
      video: json['video'],
    );
  }

  // You can add a toString method for debugging purposes
  @override
  String toString() {
    return 'Photo(idPhoto: $idVideo, photo: $video)';
  }
}
