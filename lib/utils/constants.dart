part of utils;

// const String kServerUrl = 'https://retail.fuyungroup.com';
const String kServerUrl = 'http://oa.ecpa888.cn/waterProjectWebApitest';

const String kLocalToken = 'local_token';
const String kLocalAccount = 'local_account';
const String kLocalPassword = 'local_password';
const String kLocalShop = 'local_shop';
const String kLocalAuth = 'local_auth'; //个人信息
const String kLocalIsBgUser = 'local_auth_bg'; //个人信息
const String kLocalThemeMode = 'local_theme_mode';
const String kLocalLanguage = 'local_language';
const String kLocalPrinter = 'local_printer';
const String kLocalMyPrinters = 'local_my_printers';
const String kLocalLabelContents = 'local_label_contents';
const String kLocalLabelLayout = 'local_label_layout';

const String kThemeSystem = '0';
const String kThemeLight = '1';
const String kThemeDark = '2';

final kDefaultColors = [CommoditySpecModel(id: '1', type: 1, name: '均色')];
final kDefaultSizes = [
  CommoditySpecModel(id: '2', type: 2, name: '均码'),
  CommoditySpecModel(id: '517278', type: 2, name: '70'),
  CommoditySpecModel(id: '517279', type: 2, name: '80'),
  CommoditySpecModel(id: '517280', type: 2, name: '90'),
  CommoditySpecModel(id: '517281', type: 2, name: '100'),
  CommoditySpecModel(id: '517282', type: 2, name: '110'),
  CommoditySpecModel(id: '517283', type: 2, name: '120'),
  CommoditySpecModel(id: '517284', type: 2, name: '130'),
  CommoditySpecModel(id: '517285', type: 2, name: '140'),
  CommoditySpecModel(id: '517286', type: 2, name: '150'),
  CommoditySpecModel(id: '517287', type: 2, name: '160'),
];
// 工程施工-施工状态
final kProjBuildStatus = [
  ProjectBuildStatusModel(id: 1, name: '均码'),
  ProjectBuildStatusModel(id: 5, name: '70'),
];

final List<String> kBarcodeChars1 = '0,1,2,3,4,5,6,7,8,9'.split(',');
final List<String> kBarcodeChars2 =
    'A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z'.split(',');

const kLabelContentNames = {
  '0': '店铺',
  '1': '名称',
  '2': '款号',
  '3': '零售价',
  '4': '条码',
};

final List<LabelContentModel> kLabelContents = [
  LabelContentModel(name: kLabelContentNames['0'], value: '0', sort: 0),
  LabelContentModel(name: kLabelContentNames['1'], value: '1', sort: 1),
  LabelContentModel(name: kLabelContentNames['2'], value: '2', sort: 2),
  LabelContentModel(name: kLabelContentNames['3'], value: '3', sort: 3),
  LabelContentModel(name: kLabelContentNames['4'], value: '4', sort: 4),
];

const List<LabelLayoutModel> kLabelLayouts = [
  LabelLayoutModel(
    value: '0',
    name: '30 * 20(mm)',
    size: Size(30, 20),
  ),
  LabelLayoutModel(
    value: '1',
    name: '40 * 30(mm)',
    size: Size(40, 30),
  ),
  LabelLayoutModel(
    value: '2',
    name: '40 * 60(mm)',
    size: Size(40, 60),
  ),
  LabelLayoutModel(
    value: '3',
    name: '40 * 80(mm)',
    size: Size(40, 80),
  ),
  LabelLayoutModel(
    value: '4',
    name: '60 * 40(mm)',
    size: Size(60, 40),
  ),
];
