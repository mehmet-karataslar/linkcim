// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get appTitle => 'Linkcim';

  @override
  String get home => '主页';

  @override
  String get addVideo => '添加视频';

  @override
  String get editVideo => '编辑视频';

  @override
  String get search => '搜索';

  @override
  String get settings => '设置';

  @override
  String get videoTitle => '视频标题';

  @override
  String get videoDescription => '视频描述';

  @override
  String get category => '类别';

  @override
  String get tags => '标签';

  @override
  String get save => '保存';

  @override
  String get update => '更新';

  @override
  String get cancel => '取消';

  @override
  String get delete => '删除';

  @override
  String get edit => '编辑';

  @override
  String get noVideos => '尚未添加视频';

  @override
  String get addFirstVideo => '添加您的第一个视频';

  @override
  String get allCategories => '所有类别';

  @override
  String get videoUrl => '视频网址';

  @override
  String get enterVideoUrl => '输入视频网址';

  @override
  String get invalidUrl => '请输入有效的视频网址';

  @override
  String get required => '必填';

  @override
  String get optional => '可选';

  @override
  String get language => '语言';

  @override
  String get turkish => '土耳其语';

  @override
  String get english => '英语';

  @override
  String get german => '德语';

  @override
  String get russian => '俄语';

  @override
  String get french => '法语';

  @override
  String get chinese => '中文';

  @override
  String get theme => '主题';

  @override
  String get lightTheme => '浅色';

  @override
  String get darkTheme => '深色';

  @override
  String get systemTheme => '系统';

  @override
  String get colorScheme => '配色方案';

  @override
  String get permissions => '权限';

  @override
  String get storagePermissions => '存储权限';

  @override
  String get managePermissions => '管理权限';

  @override
  String get systemSettings => '系统设置';

  @override
  String get dataManagement => '数据管理';

  @override
  String get clearAllData => '清除所有数据';

  @override
  String get clearDataWarning => '此操作将删除您的所有视频且无法撤销。您确定要继续吗？';

  @override
  String get about => '关于';

  @override
  String get appInfo => '智能视频录制和分类应用';

  @override
  String get addTag => '添加标签';

  @override
  String get enterTag => '输入标签并按 Enter';

  @override
  String get newVideo => '新视频';

  @override
  String get editVideoInfo => '编辑视频信息';

  @override
  String get videoInfoDescription => '输入视频信息并添加到您的收藏';

  @override
  String get selectCategory => '选择视频类别';

  @override
  String get videoSaved => '视频保存成功';

  @override
  String get videoUpdated => '视频已更新';

  @override
  String get saveError => '保存错误';

  @override
  String get allPermissionsGranted => '已授予所有权限';

  @override
  String get permissionsMissing => '缺少权限';

  @override
  String get permissionInfo => 'Linkcim 应用需要以下权限：';

  @override
  String get storageAccess => '存储访问';

  @override
  String get storageAccessDesc => '访问应用数据';

  @override
  String get videoMediaAccess => '视频/媒体访问';

  @override
  String get videoMediaAccessDesc => '访问视频文件';

  @override
  String get fileManagement => '文件管理';

  @override
  String get fileManagementDesc => '整理视频文件';

  @override
  String get dataPrivacy => '您的数据是安全的，仅用于应用功能。';

  @override
  String get requestingPermissions => '请求权限...';

  @override
  String get permissionsGranted => '已授予所有权限！';

  @override
  String get permissionsDenied => '某些权限被拒绝。';

  @override
  String get dataCleared => '所有数据已清除';

  @override
  String get clearDataError => '清除数据时出错';

  @override
  String get appVersion => '应用版本';

  @override
  String get developedWith => '使用 Flutter 开发。';

  @override
  String get searchVideos => '搜索您的视频...';

  @override
  String get videosLoading => '正在加载视频...';

  @override
  String get noVideoFound => '未找到视频';

  @override
  String get tryDifferentKeywords => '尝试不同的关键词。';

  @override
  String get addFirstVideoButton => '添加您的第一个视频';

  @override
  String get videoDelete => '删除视频';

  @override
  String get confirmDelete => '您确定要删除此视频吗？';

  @override
  String get videoDeleted => '视频已删除';

  @override
  String get videoDeleteError => '无法删除视频';

  @override
  String get dataLoadError => '加载数据时出错';

  @override
  String get videoUrlRequired => '需要视频网址';

  @override
  String get titleRequired => '需要标题';

  @override
  String get categoryRequired => '需要类别';

  @override
  String get enterTitle => '输入视频标题';

  @override
  String get enterDescription => '写一个关于视频的描述（可选）';

  @override
  String tagsCount(int count) {
    return '标签 ($count/10)';
  }

  @override
  String get videoSearch => '视频搜索';

  @override
  String get searchPlaceholder => '搜索视频...（标题、作者、平台、标签）';

  @override
  String get clearSearch => '清除搜索';

  @override
  String videosFound(int count) {
    return '找到 $count 个视频';
  }

  @override
  String get searchError => '搜索错误';

  @override
  String get noVideoMatch => '未找到符合您搜索条件的视频。\n尝试不同的关键词。';

  @override
  String get videoStatistics => '视频统计';

  @override
  String get totalVideos => '视频总数';

  @override
  String get categories => '类别';

  @override
  String get platformDistribution => '平台分布';

  @override
  String get popularCategories => '热门类别';

  @override
  String get refresh => '刷新';

  @override
  String get share => '分享';

  @override
  String get preview => '预览';

  @override
  String get open => '打开';

  @override
  String get openInPlatform => '在平台中打开';

  @override
  String get openInInstagram => '在 Instagram 中打开';

  @override
  String get openInYouTube => '在 YouTube 中打开';

  @override
  String get openInTikTok => '在 TikTok 中打开';

  @override
  String get openInTwitter => '在 Twitter 中打开';

  @override
  String get videoInfo => '视频信息';

  @override
  String get duration => '时长';

  @override
  String get resolution => '分辨率';

  @override
  String get fileSize => '文件大小';

  @override
  String get filePath => '文件路径';

  @override
  String get calculating => '计算中...';

  @override
  String get videoLoading => '正在加载视频...';

  @override
  String get videoCannotPlay => '无法播放视频';

  @override
  String get retry => '重试';

  @override
  String get goBack => '返回';

  @override
  String get unknownError => '发生未知错误';

  @override
  String get videoFileNotFound => '未找到视频文件';

  @override
  String get videoFileEmpty => '视频文件为空或无法读取';

  @override
  String get videoLoadTimeout => '视频加载超时';

  @override
  String get videoFormatNotSupported => '不支持的视频格式';

  @override
  String get noPermission => '无权访问视频文件';

  @override
  String get videoPlayError => '无法播放视频';

  @override
  String get linkOpenError => '打开链接错误';

  @override
  String get platformCannotOpen => '无法打开';

  @override
  String get organizeVideos => '整理您的视频并轻松找到它们。';

  @override
  String get manualEditPermissions => '手动编辑应用权限';

  @override
  String get checkingPermissions => '检查权限...';

  @override
  String get permissionRequestError => '权限请求错误';

  @override
  String get iosAutoPermission => '在 iOS 设备上自动授予权限';

  @override
  String get carefulUse => '谨慎使用 - 无法撤销';

  @override
  String get appInformation => '应用信息';

  @override
  String get searchPlaceholderShort => '搜索...';

  @override
  String get shareVideoLink => '分享视频链接';

  @override
  String get shareVideoLinkDesc => '通过手机分享菜单';

  @override
  String get shareDetailedInfo => '分享详细信息';

  @override
  String get shareDetailedInfoDesc => '包含标题、描述和标签';

  @override
  String get copyLink => '复制链接';

  @override
  String get copyLinkDesc => '复制到剪贴板';

  @override
  String get linkCopied => '链接已复制到剪贴板';

  @override
  String get shareError => '分享错误';

  @override
  String get copyError => '复制错误';

  @override
  String get videoLinkShared => '视频链接已分享';

  @override
  String get videoDetailsShared => '视频详情已分享';

  @override
  String get loading => '加载中...';

  @override
  String get previewLoading => '预览\n加载中...';

  @override
  String get previewUnavailable => '预览\n不可用';

  @override
  String get platformInstagram => 'Instagram';

  @override
  String get platformYouTube => 'YouTube';

  @override
  String get platformTikTok => 'TikTok';

  @override
  String get platformTwitter => 'Twitter';

  @override
  String get platformFacebook => 'Facebook';

  @override
  String get platformVimeo => 'Vimeo';

  @override
  String get platformReddit => 'Reddit';

  @override
  String get platformGeneral => '通用';

  @override
  String get categoryGeneral => '通用';

  @override
  String get categorySoftware => '软件';

  @override
  String get categoryEducation => '教育';

  @override
  String get categoryEntertainment => '娱乐';

  @override
  String get categorySports => '体育';

  @override
  String get categoryFood => '美食';

  @override
  String get categoryMusic => '音乐';

  @override
  String get categoryArt => '艺术';

  @override
  String get categoryScience => '科学';

  @override
  String get categoryTechnology => '技术';

  @override
  String get noDescription => '无描述';

  @override
  String get descriptionNotAvailable => '描述不可用';

  @override
  String get noTags => '无标签';

  @override
  String get sharedFromLinkcim => '来自 Linkcim 应用';

  @override
  String videoCollection(int count) {
    return '视频集合（$count 个视频）';
  }

  @override
  String categoryVideos(String category) {
    return '$category 类别';
  }

  @override
  String videosFoundInCategory(int count) {
    return '找到 $count 个视频';
  }

  @override
  String andMoreVideos(int count) {
    return '... 还有 $count 个视频';
  }

  @override
  String get videoTitleFromUrl => '视频标题';

  @override
  String get instagramPost => 'Instagram 帖子';

  @override
  String get instagramReel => 'Instagram Reel';

  @override
  String get instagramTV => 'Instagram TV';

  @override
  String get instagramVideo => 'Instagram 视频';

  @override
  String get youtubeVideo => 'YouTube 视频';

  @override
  String get youtubeShorts => 'YouTube Shorts';

  @override
  String get tiktokVideo => 'TikTok 视频';

  @override
  String get tiktokVideoShortLink => 'TikTok 视频（短链接）';

  @override
  String get twitterPost => 'Twitter 帖子';

  @override
  String twitterUser(String username) {
    return 'Twitter (@$username)';
  }

  @override
  String get xTwitterPost => 'X/Twitter 帖子';

  @override
  String xTwitterUser(String username) {
    return 'X/Twitter (@$username)';
  }

  @override
  String get facebookVideo => 'Facebook 视频';

  @override
  String get vimeoVideo => 'Vimeo 视频';

  @override
  String get redditVideo => 'Reddit 视频';

  @override
  String get unknownChannel => '未知频道';

  @override
  String get quickShare => '快速分享';

  @override
  String get videoShared => '视频已分享';

  @override
  String shareFailed(String error) {
    return '分享失败：$error';
  }

  @override
  String get grantPermission => '授予权限';

  @override
  String get later => '稍后';

  @override
  String get videoAccess => '视频访问';

  @override
  String get videoAccessDescription => '保存和整理视频链接';

  @override
  String get collections => '收藏';

  @override
  String get collection => '收藏';

  @override
  String get newCollection => '新建收藏';

  @override
  String get collectionName => '收藏名称';

  @override
  String get collectionDescription => '描述';

  @override
  String get addToCollection => '添加到收藏';

  @override
  String get removeFromCollection => '从收藏中移除';

  @override
  String get collectionCreated => '收藏已创建';

  @override
  String get collectionUpdated => '收藏已更新';

  @override
  String get collectionDeleted => '收藏已删除';

  @override
  String get videoAddedToCollection => '视频已添加到收藏';

  @override
  String get videoRemovedFromCollection => '视频已从收藏中移除';

  @override
  String get noCollections => '尚无收藏';

  @override
  String get createFirstCollection => '创建您的第一个收藏';

  @override
  String videosInCollection(int count) {
    return '$count 个视频';
  }

  @override
  String get advancedSearch => '高级搜索';

  @override
  String get filterBy => '筛选条件';

  @override
  String get sortBy => '排序方式';

  @override
  String get sortNewest => '最新的在前';

  @override
  String get sortOldest => '最旧的在前';

  @override
  String get sortTitle => '标题 (A-Z)';

  @override
  String get sortPlatform => '平台';

  @override
  String get filterPlatform => '平台';

  @override
  String get filterCategory => '类别';

  @override
  String get filterTags => '标签';

  @override
  String get filterDateRange => '日期范围';

  @override
  String get fromDate => '开始日期';

  @override
  String get toDate => '结束日期';

  @override
  String get clearFilters => '清除筛选';

  @override
  String get applyFilters => '应用筛选';

  @override
  String get selectMultiple => '多选';

  @override
  String get allPlatforms => '所有平台';

  @override
  String get detailedInformation => '详细信息';

  @override
  String get linkDetails => '链接详情';

  @override
  String get videoType => '视频类型';

  @override
  String get urlLength => '网址长度';

  @override
  String get fullUrl => '完整网址';

  @override
  String get characters => '字符';

  @override
  String get playInApp => '在应用中播放';

  @override
  String get instagramInfo => 'Instagram 信息';

  @override
  String get loadingInstagramInfo => '正在加载 Instagram 信息...';

  @override
  String get author => '作者';

  @override
  String get postType => '类型';

  @override
  String get postId => '帖子 ID';

  @override
  String get igtv => 'IGTV';

  @override
  String get twitterVideo => 'Twitter 视频';

  @override
  String get video => '视频';

  @override
  String couldNotOpen(String platform) {
    return '无法打开 $platform';
  }

  @override
  String get platform => '平台';

  @override
  String get appDescription =>
      '视频整理应用。整理来自 Instagram、YouTube、TikTok 和 Twitter 的视频。';

  @override
  String get technicalInformation => '技术信息';

  @override
  String get framework => '框架';

  @override
  String get systemVersion => '系统版本';

  @override
  String get packageName => '包名';

  @override
  String get developer => '开发者';

  @override
  String get developerName => '开发者';

  @override
  String get profession => '职业';

  @override
  String get visitWebsite => '访问我的网站';

  @override
  String get close => '关闭';

  @override
  String get computerEngineer => '计算机工程师';
}
