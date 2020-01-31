import 'dart:math';

import 'package:floor/floor.dart';
import 'package:gbera/netos/common.dart';
import 'package:gbera/portals/gbera/store/dao/daos.dart';
import 'package:gbera/portals/gbera/store/dao/database.dart';
import 'package:gbera/portals/gbera/store/services.dart';

import '../entities.dart';

class FriendService implements IFriendService{
  Environment env;
  IFriendDAO friendDAO;
  FriendService({ServiceSite site}) {
    site.onready.add(() {
      AppDatabase db = site.database;
      env=site.getService('@.environment');
      friendDAO=db.friendDAO;
    });
  }

  @override
  Future<Friend> getFriendByOfficial(String official) async{
    return await friendDAO.getFriendByOfficial(env.userPrincipal.person,official,);
  }

  @override
  Future<bool> exists(String official) async{
    return await friendDAO.getFriend(official,env.userPrincipal.person)!=null;
  }

  @override
  Future<Function> addFriend(Friend friend) async{
    await friendDAO.addFriend(friend);
  }

  @override
  Future<List<Friend>> pageFriendLikeName(
      String name, List<String> officials, int limit, int offset) async{
    return await friendDAO.pageFriendLikeName(env.userPrincipal.person,name,name,name,officials,limit,offset);
  }

  @override
  Future<List<Friend>> pageFriend(int limit, int offset) async{
    return await friendDAO.pageFriend(env.userPrincipal.person,limit,offset);
  }

  @override
  Future<Function> removeFriendById(String id) async{
     await friendDAO.removeFriendById(id,env.userPrincipal.person);
  }
}

class ChatRoomService implements IChatRoomService {
  Environment env;
  IChatRoomDAO chatRoomDAO;
  IRoomMemberDAO roomMemberDAO;
  ChatRoomService({ServiceSite site}) {
    site.onready.add(() {
      AppDatabase db = site.database;
      env = site.getService('@.environment');
      chatRoomDAO = db.chatRoomDAO;
      roomMemberDAO=db.roomMemberDAO;
    });
  }

  @override
  Future<List<Friend>> listWhoAddMember(String roomCode,String whoAdd) async{
    return await roomMemberDAO.listWhoAddMember(env.userPrincipal.person,roomCode,whoAdd);
  }

  @override
  Future<Function> addRoom(ChatRoom chatRoom) async{
    await chatRoomDAO.addRoom(chatRoom);
  }

  @override
  Future<Function> addMember(RoomMember roomMember) async{
    await roomMemberDAO.addMember(roomMember);
  }

  @override
  Future<List<ChatRoom>> listChatRoom() async{
    return await chatRoomDAO.listChatRoom(env.userPrincipal.person);
  }

  @override
  Future<List<RoomMember>> topMember10(String code) async{
    return await roomMemberDAO.topMember10(env.userPrincipal.person,code);
  }

  @transaction
  @override
  Future<Function> removeChatRoomById(String id) async{
    var room=await chatRoomDAO.getChatRoomById(id,env.userPrincipal.person);
    if(room==null) {
      return null;
    }
    await chatRoomDAO.removeChatRoomById(id,env.userPrincipal.person);
    await roomMemberDAO.removeChatRoomByRoomCode(room.code,env.userPrincipal.person);
  }
}