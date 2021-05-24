import 'Comment.dart';

class Combination {
  String id;
  String name;
  String brand;
  List<String> menuList;
  List<String> tags;
  List<String> imageUrls;
  String description;
  String createdDateTime;
  int like;
  List<String> likePerson;
  String uid;
  String maker;
  List<Comment> comments;

  Combination({
    this.id,
    this.name,
    this.brand,
    this.menuList,
    this.tags,
    this.imageUrls,
    this.description,
    this.createdDateTime,
    this.like,
    this.likePerson,
    this.uid,
    this.maker,
    this.comments,

});
}