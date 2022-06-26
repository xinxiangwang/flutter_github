// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'owner.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Owner _$OwnerFromJson(Map<String, dynamic> json) => Owner()
  ..type = json['type'] as String
  ..following_url = json['following_url'] as String
  ..organizations_url = json['organizations_url'] as String
  ..gravatar_id = json['gravatar_id'] as String
  ..repos_url = json['repos_url'] as String
  ..login = json['login'] as String
  ..followers_url = json['followers_url'] as String
  ..starred_url = json['starred_url'] as String
  ..html_url = json['html_url'] as String
  ..url = json['url'] as String
  ..received_events_url = json['received_events_url'] as String
  ..avatar_url = json['avatar_url'] as String
  ..gists_url = json['gists_url'] as String
  ..id = json['id'] as num
  ..subscriptions_url = json['subscriptions_url'] as String
  ..site_admin = json['site_admin'] as bool
  ..node_id = json['node_id'] as String
  ..events_url = json['events_url'] as String;

Map<String, dynamic> _$OwnerToJson(Owner instance) => <String, dynamic>{
      'type': instance.type,
      'following_url': instance.following_url,
      'organizations_url': instance.organizations_url,
      'gravatar_id': instance.gravatar_id,
      'repos_url': instance.repos_url,
      'login': instance.login,
      'followers_url': instance.followers_url,
      'starred_url': instance.starred_url,
      'html_url': instance.html_url,
      'url': instance.url,
      'received_events_url': instance.received_events_url,
      'avatar_url': instance.avatar_url,
      'gists_url': instance.gists_url,
      'id': instance.id,
      'subscriptions_url': instance.subscriptions_url,
      'site_admin': instance.site_admin,
      'node_id': instance.node_id,
      'events_url': instance.events_url,
    };
