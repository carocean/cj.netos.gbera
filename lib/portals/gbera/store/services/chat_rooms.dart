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
    site.onready.add(()async {
      AppDatabase db = site.database;
      env=site.getService('@.environment');
      friendDAO=db.friendDAO;
    });
  }

  @override
  Future<Friend> getFriendByOfficial(String official) async{
    return await friendDAO.getFriendByOfficial(env.principal.person,official,);
  }

  @override
  Future<bool> exists(String official) async{
    return await friendDAO.getFriend(official,env.principal.person)!=null;
  }

  @override
  Future<Function> addFriend(Friend friend) async{
    await friendDAO.addFriend(friend);
  }

  @override
  Future<List<Friend>> pageFriendLikeName(
      String name, List<String> officials, int limit, int offset) async{
    return await friendDAO.pageFriendLikeName(env.principal.person,name,name,name,officials,limit,offset);
  }

  @override
  Future<List<Friend>> pageFriend(int limit, int offset) async{
    return await friendDAO.pageFriend(env.principal.person,limit,offset);
  }

  @override
  Future<Function> removeFriendById(String id) async{
     await friendDAO.removeFriendById(id,env.principal.person);
  }
}

class ChatRoomService implements IChatRoomService {
  Environment env;
  IChatRoomDAO chatRoomDAO;
  IRoomMemberDAO roomMemberDAO;
  ChatRoomService({ServiceSite site}) {
    site.onready.add(()async {
      AppDatabase db = site.database;
      env = site.getService('@.environment');
      chatRoomDAO = db.chatRoomDAO;
      roomMemberDAO=db.roomMemberDAO;
    });
  }

  @override
  Future<List<RoomMember>> top20Members(String code) async{
    return chatRoomDAO.top20Members(env.principal.person,code);
  }

  @override
  Future<Function> updateRoomLeading(String roomid, String file) async{
    await chatRoomDAO.updateRoomLeading(file,env.principal.person,roomid,);
  }

  @override
  Future<List<Friend>> listWhoAddMember(String roomCode,String whoAdd) async{
    return await roomMemberDAO.listWhoAddMember(env.principal.person,roomCode,whoAdd);
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
    return await chatRoomDAO.listChatRoom(env.principal.person);
  }

  @override
  Future<List<RoomMember>> topMember10(String code) async{
    return await roomMemberDAO.topMember10(env.principal.person,code);
  }

  @transaction
  @override
  Future<Function> removeChatRoomById(String id) async{
    var room=await chatRoomDAO.getChatRoomById(id,env.principal.person);
    if(room==null) {
      return null;
    }
    await chatRoomDAO.removeChatRoomById(id,env.principal.person);
    await roomMemberDAO.removeChatRoomByRoomCode(room.code,env.principal.person);
  }
}

class P2PMessageService implements IP2PMessageService{
  Environment env;
  IP2PMessageDAO p2pMessageDAO;
  P2PMessageService({ServiceSite site}) {
    site.onready.add(() async{
      AppDatabase db = site.database;
      env = site.getService('@.environment');
      p2pMessageDAO = db.p2pMessageDAO;
    });
  }
  @override
  Future<Function> addMessage(P2PMessage message) async{
    await p2pMessageDAO.addMessage(message);
  }

  @override
  Future<List<P2PMessage>> pageMessage(String roomCode,int limit, int offset) {
    return p2pMessageDAO.pageMessage(env.principal.person,roomCode,limit,offset);
  }
}