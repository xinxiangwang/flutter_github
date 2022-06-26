import 'package:json_annotation/json_annotation.dart';

part 'owner.g.dart';

@JsonSerializable()
class Owner {
  Owner();

  late String type;
  late String following_url;
  late String organizations_url;
  late String gravatar_id;
  late String repos_url;
  late String login;
  late String followers_url;
  late String starred_url;
  late String html_url;
  late String url;
  late String received_events_url;
  late String avatar_url;
  late String gists_url;
  late num id;
  late String subscriptions_url;
  late bool site_admin;
  late String node_id;
  late String events_url;
  
  factory Owner.fromJson(Map<String,dynamic> json) => _$OwnerFromJson(json);
  Map<String, dynamic> toJson() => _$OwnerToJson(this);
}
