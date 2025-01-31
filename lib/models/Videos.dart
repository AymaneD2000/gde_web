class Video {
  String idVideo;
  String video;
  String idPub;

  Video({
    required this.idPub,
    required this.idVideo,
    required this.video,
  });

  // toJson method to convert Photo object to a Map
  Map<String, dynamic> toJson() {
    return {
      'id_pub': idPub,
      'id': idVideo,
      'video': video,
    };
  }

  // fromJson method to create a Photo object from a Map
  factory Video.fromJson(Map<String, dynamic> json) {
    return Video(
      idPub: json['id_pub'],
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
