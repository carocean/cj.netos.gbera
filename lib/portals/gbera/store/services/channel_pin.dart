import 'package:gbera/netos/common.dart';
import 'package:gbera/portals/gbera/store/dao/daos.dart';
import 'package:gbera/portals/gbera/store/dao/database.dart';
import 'package:gbera/portals/gbera/store/services.dart';
import 'package:uuid/uuid.dart';

import '../entities.dart';

class ChannelPinService implements IChannelPinService {
  IChannelPinDAO channelPinDAO;
  IChannelInputPersonDAO inputPersonDAO;
  IChannelOutputPersonDAO outputPersonDAO;

  ChannelPinService({ServiceSite site}) {
    site.onready.add(() {
      AppDatabase db = site.database;
      channelPinDAO = db.channelPinDAO;
      inputPersonDAO = db.channelInputPersonDAO;
      outputPersonDAO = db.channelOutputPersonDAO;
    });
  }

  @override
  Future<Function> removePin(String channelid) async {
    await channelPinDAO.remove(channelid);
  }

  @override
  Future<List<ChannelOutputPerson>> pageOutputPerson(
      String channelid, int limit, int offset) async {
    return await this.outputPersonDAO.pageOutputPerson(channelid, limit, offset);
  }

  @override
  Future<List<ChannelOutputPerson>> listOutputPerson(String channelid)async {
    return await this.outputPersonDAO.listOutputPerson(channelid);
  }

  @override
  Future<Function> removeOutputPerson(String person, String channelid) async {
    await this.outputPersonDAO.removeOutputPerson(person, channelid);
  }

  @override
  Future<Function> emptyOutputPersons(String channelid) async{
    await this.outputPersonDAO.emptyOutputPersons(channelid);
  }

  @override
  Future<Function> addOutputPerson(ChannelOutputPerson person) async {
   await this.outputPersonDAO.addOutputPerson(person);
  }

  @override
  Future<List<ChannelInputPerson>> pageInputPerson(
      String channelid, int limit, int offset) async {
    return await this.inputPersonDAO.pageInputPerson(channelid, limit, offset);
  }

  @override
  Future<Function> removeInputPerson(String person, String channelid) async {
    await this.inputPersonDAO.removeInputPerson(person, channelid);
  }

  @override
  Future<Function> addInputPerson(ChannelInputPerson person) async {
    await this.inputPersonDAO.addInputPerson(person);
  }

  @override
  Future<Function> setOutputWechatHaoYouSelector(
      String channelid, bool isSet) async {}

  @override
  Future<Function> setOutputWechatCircleSelector(
      String channelid, bool isSet) async {}

  @override
  Future<Function> setOutputGeoSelector(String channelid, bool isSet) async {
    await this
        .channelPinDAO
        .setOutputGeoSelector(isSet ? 'true' : 'false', channelid);
  }

  @override
  Future<Function> setOutputPersonSelector(String channelid,
      OutsitePersonsSettingStrategy outsitePersonsSettingStrategy) async {
    var selector;
    switch (outsitePersonsSettingStrategy) {
      case OutsitePersonsSettingStrategy.only_select:
        selector = 'only_select';
        break;
      case OutsitePersonsSettingStrategy.all_except:
        selector = 'all_except';
        break;
    }
    await this.channelPinDAO.setOutputPersonSelector(selector, channelid);
  }

  @override
  Future<bool> getOutputGeoSelector(String channelid) async {
    ChannelPin pin = await channelPinDAO.getChannelPin(channelid);
    if (pin == null) {
      return false;
    }
    if (StringUtil.isEmpty(pin.outGeoSelector)) {
      return false;
    }
    if (pin.outGeoSelector == 'true') {
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<OutsitePersonsSettingStrategy> getOutputPersonSelector(
      String channelid) async {
    ChannelPin pin = await channelPinDAO.getChannelPin(channelid);
    if (pin == null) {
      return OutsitePersonsSettingStrategy.all_except;
    }
    if (StringUtil.isEmpty(pin.outPersonSelector)) {
      return OutsitePersonsSettingStrategy.all_except;
    }
    switch (pin.outPersonSelector) {
      case 'all_except':
        return OutsitePersonsSettingStrategy.all_except;
      case 'only_select':
        return OutsitePersonsSettingStrategy.only_select;
    }
    return OutsitePersonsSettingStrategy.all_except;
  }

  @override
  Future<OutsitePersonsSettingStrategy> getInputPersonSelector(
      String channelid) async {
    // 输入用户选择策略永远是从指定管道的输入端的所有用户中排除
    return OutsitePersonsSettingStrategy.all_except;
  }

  @override
  Future<Function> init(String channelid) async {
    var pin = await this.channelPinDAO.getChannelPin(channelid);
    if (pin == null) {
      await this.channelPinDAO.addChannelPin(
            ChannelPin(
              '${Uuid().v1()}',
              channelid,
              'all_except',
              'all_except',
              null,
              null,
              null,
              null,
              null,
              null,
            ),
          );
    }
  }
}
