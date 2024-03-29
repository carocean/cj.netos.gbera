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
  Environment env;
  ChannelPinService({ServiceSite site}) {
    site.onready.add(() async{
      AppDatabase db = site.database;
      channelPinDAO = db.channelPinDAO;
      inputPersonDAO = db.channelInputPersonDAO;
      outputPersonDAO = db.channelOutputPersonDAO;
      env=site.getService('@.environment');
    });
  }

  @override
  Future<Function> removePin(String channelcode) async {
    await channelPinDAO.remove(channelcode,env?.principal?.person);
  }

  @override
  Future<List<ChannelOutputPerson>> pageOutputPerson(
      String channelcode, int limit, int offset) async {
    return await this.outputPersonDAO.pageOutputPerson(channelcode,env?.principal?.person, limit, offset);
  }

  @override
  Future<List<ChannelOutputPerson>> listOutputPerson(String channelcode)async {
    return await this.outputPersonDAO.listOutputPerson(channelcode,env?.principal?.person);
  }

  @override
  Future<List<ChannelInputPerson>> listInputPerson(String channelcode) async{
    return await this.inputPersonDAO.listInputPerson(channelcode,env?.principal?.person);
  }

  @override
  Future<Function> removeOutputPerson(String person, String channelcode) async {
    await this.outputPersonDAO.removeOutputPerson(person, channelcode,env?.principal?.person);
  }

  @override
  Future<Function> emptyOutputPersons(String channelcode) async{
    await this.outputPersonDAO.emptyOutputPersons(channelcode,env?.principal?.person);
  }

  @override
  Future<Function> addOutputPerson(ChannelOutputPerson person) async {
   await this.outputPersonDAO.addOutputPerson(person);
  }

  @override
  Future<List<ChannelInputPerson>> pageInputPerson(
      String channelcode, int limit, int offset) async {
    return await this.inputPersonDAO.pageInputPerson(channelcode,env?.principal?.person, limit, offset);
  }

  @override
  Future<Function> removeInputPerson(String person, String channelcode) async {
    await this.inputPersonDAO.removeInputPerson(person, channelcode,env?.principal?.person);
  }

  @override
  Future<Function> addInputPerson(ChannelInputPerson person) async {
    await this.inputPersonDAO.addInputPerson(person);
  }

  @override
  Future<Function> setOutputWechatHaoYouSelector(
      String channelcode, bool isSet) async {}

  @override
  Future<Function> setOutputWechatCircleSelector(
      String channelcode, bool isSet) async {}

  @override
  Future<Function> setOutputGeoSelector(String channelcode, bool isSet) async {
    await this
        .channelPinDAO
        .setOutputGeoSelector(isSet ? 'true' : 'false', channelcode,env?.principal?.person);
  }

  @override
  Future<Function> setOutputPersonSelector(String channelcode,
      PinPersonsSettingsStrategy outsitePersonsSettingStrategy) async {
    var selector;
    switch (outsitePersonsSettingStrategy) {
      case PinPersonsSettingsStrategy.only_select:
        selector = 'only_select';
        break;
      case PinPersonsSettingsStrategy.all_except:
        selector = 'all_except';
        break;
    }
    await this.channelPinDAO.setOutputPersonSelector(selector, channelcode,env?.principal?.person);
  }

  @override
  Future<bool> getOutputGeoSelector(String channelcode) async {
    ChannelPin pin = await channelPinDAO.getChannelPin(channelcode,env?.principal?.person);
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
  Future<PinPersonsSettingsStrategy> getOutputPersonSelector(
      String channelcode) async {
    ChannelPin pin = await channelPinDAO.getChannelPin(channelcode,env?.principal?.person);
    if (pin == null) {
      return PinPersonsSettingsStrategy.all_except;
    }
    if (StringUtil.isEmpty(pin.outPersonSelector)) {
      return PinPersonsSettingsStrategy.all_except;
    }
    switch (pin.outPersonSelector) {
      case 'all_except':
        return PinPersonsSettingsStrategy.all_except;
      case 'only_select':
        return PinPersonsSettingsStrategy.only_select;
    }
    return PinPersonsSettingsStrategy.all_except;
  }

  @override
  Future<PinPersonsSettingsStrategy> getInputPersonSelector(
      String channelcode) async {
    // 输入用户选择策略永远是从指定管道的输入端的所有用户中排除
    return PinPersonsSettingsStrategy.all_except;
  }

  @override
  Future<Function> init(String channelcode) async {
    var pin = await this.channelPinDAO.getChannelPin(channelcode,env?.principal?.person);
    if (pin == null) {
      await this.channelPinDAO.addChannelPin(
            ChannelPin(
              '${Uuid().v1()}',
              channelcode,
              'all_except',
              'all_except',
              null,
              null,
              null,
              null,
              null,
              null,
                env?.principal?.person,
            ),
          );
    }
  }
}
