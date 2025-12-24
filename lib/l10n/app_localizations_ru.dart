// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get appTitle => 'Linkcim';

  @override
  String get home => 'Главная';

  @override
  String get addVideo => 'Добавить видео';

  @override
  String get editVideo => 'Редактировать видео';

  @override
  String get search => 'Поиск';

  @override
  String get settings => 'Настройки';

  @override
  String get videoTitle => 'Название видео';

  @override
  String get videoDescription => 'Описание видео';

  @override
  String get category => 'Категория';

  @override
  String get tags => 'Теги';

  @override
  String get save => 'Сохранить';

  @override
  String get update => 'Обновить';

  @override
  String get cancel => 'Отмена';

  @override
  String get delete => 'Удалить';

  @override
  String get edit => 'Редактировать';

  @override
  String get noVideos => 'Видео еще не добавлены';

  @override
  String get addFirstVideo => 'Добавьте свое первое видео';

  @override
  String get allCategories => 'Все категории';

  @override
  String get videoUrl => 'URL видео';

  @override
  String get enterVideoUrl => 'Введите URL видео';

  @override
  String get invalidUrl => 'Пожалуйста, введите действительный URL видео';

  @override
  String get required => 'Обязательно';

  @override
  String get optional => 'Необязательно';

  @override
  String get language => 'Язык';

  @override
  String get turkish => 'Турецкий';

  @override
  String get english => 'Английский';

  @override
  String get german => 'Немецкий';

  @override
  String get russian => 'Русский';

  @override
  String get french => 'Французский';

  @override
  String get chinese => 'Китайский';

  @override
  String get theme => 'Тема';

  @override
  String get lightTheme => 'Светлая';

  @override
  String get darkTheme => 'Тёмная';

  @override
  String get systemTheme => 'Системная';

  @override
  String get colorScheme => 'Цветовая схема';

  @override
  String get permissions => 'Разрешения';

  @override
  String get storagePermissions => 'Разрешения на хранение';

  @override
  String get managePermissions => 'Управление разрешениями';

  @override
  String get systemSettings => 'Системные настройки';

  @override
  String get dataManagement => 'Управление данными';

  @override
  String get clearAllData => 'Очистить все данные';

  @override
  String get clearDataWarning =>
      'Это действие удалит все ваши видео и не может быть отменено. Вы уверены, что хотите продолжить?';

  @override
  String get about => 'О приложении';

  @override
  String get appInfo => 'Умное приложение для записи и категоризации видео';

  @override
  String get addTag => 'Добавить тег';

  @override
  String get enterTag => 'Введите тег и нажмите Enter';

  @override
  String get newVideo => 'Новое видео';

  @override
  String get editVideoInfo => 'Редактировать информацию о видео';

  @override
  String get videoInfoDescription =>
      'Введите информацию о видео и добавьте в свою коллекцию';

  @override
  String get selectCategory => 'Выберите категорию видео';

  @override
  String get videoSaved => 'Видео успешно сохранено';

  @override
  String get videoUpdated => 'Видео обновлено';

  @override
  String get saveError => 'Ошибка сохранения';

  @override
  String get allPermissionsGranted => 'Все разрешения предоставлены';

  @override
  String get permissionsMissing => 'Разрешения отсутствуют';

  @override
  String get permissionInfo =>
      'Приложение Linkcim требует следующие разрешения:';

  @override
  String get storageAccess => 'Доступ к хранилищу';

  @override
  String get storageAccessDesc => 'Для доступа к данным приложения';

  @override
  String get videoMediaAccess => 'Доступ к видео/медиа';

  @override
  String get videoMediaAccessDesc => 'Для доступа к видеофайлам';

  @override
  String get fileManagement => 'Управление файлами';

  @override
  String get fileManagementDesc => 'Для организации видеофайлов';

  @override
  String get dataPrivacy =>
      'Ваши данные в безопасности и используются только для функциональности приложения.';

  @override
  String get requestingPermissions => 'Запрос разрешений...';

  @override
  String get permissionsGranted => 'Все разрешения предоставлены!';

  @override
  String get permissionsDenied => 'Некоторые разрешения были отклонены.';

  @override
  String get dataCleared => 'Все данные очищены';

  @override
  String get clearDataError => 'Ошибка при очистке данных';

  @override
  String get appVersion => 'Версия приложения';

  @override
  String get developedWith => 'Разработано с использованием Flutter.';

  @override
  String get searchVideos => 'Поиск ваших видео...';

  @override
  String get videosLoading => 'Загрузка видео...';

  @override
  String get noVideoFound => 'Видео не найдено';

  @override
  String get tryDifferentKeywords => 'Попробуйте другие ключевые слова.';

  @override
  String get addFirstVideoButton => 'Добавьте свое первое видео';

  @override
  String get videoDelete => 'Удалить видео';

  @override
  String get confirmDelete => 'Вы уверены, что хотите удалить это видео?';

  @override
  String get videoDeleted => 'Видео удалено';

  @override
  String get videoDeleteError => 'Не удалось удалить видео';

  @override
  String get dataLoadError => 'Ошибка при загрузке данных';

  @override
  String get videoUrlRequired => 'URL видео обязателен';

  @override
  String get titleRequired => 'Название обязательно';

  @override
  String get categoryRequired => 'Категория обязательна';

  @override
  String get enterTitle => 'Введите название видео';

  @override
  String get enterDescription => 'Напишите описание видео (необязательно)';

  @override
  String tagsCount(int count) {
    return 'Теги ($count/10)';
  }

  @override
  String get videoSearch => 'Поиск видео';

  @override
  String get searchPlaceholder =>
      'Поиск видео... (название, автор, платформа, тег)';

  @override
  String get clearSearch => 'Очистить поиск';

  @override
  String videosFound(int count) {
    return 'Найдено $count видео';
  }

  @override
  String get searchError => 'Ошибка поиска';

  @override
  String get noVideoMatch =>
      'Не найдено видео, соответствующего вашим критериям поиска.\nПопробуйте другие ключевые слова.';

  @override
  String get videoStatistics => 'Статистика видео';

  @override
  String get totalVideos => 'Всего видео';

  @override
  String get categories => 'Категории';

  @override
  String get platformDistribution => 'Распределение по платформам';

  @override
  String get popularCategories => 'Популярные категории';

  @override
  String get refresh => 'Обновить';

  @override
  String get share => 'Поделиться';

  @override
  String get preview => 'Предпросмотр';

  @override
  String get open => 'Открыть';

  @override
  String get openInPlatform => 'Открыть на платформе';

  @override
  String get openInInstagram => 'Открыть в Instagram';

  @override
  String get openInYouTube => 'Открыть в YouTube';

  @override
  String get openInTikTok => 'Открыть в TikTok';

  @override
  String get openInTwitter => 'Открыть в Twitter';

  @override
  String get videoInfo => 'Информация о видео';

  @override
  String get duration => 'Длительность';

  @override
  String get resolution => 'Разрешение';

  @override
  String get fileSize => 'Размер файла';

  @override
  String get filePath => 'Путь к файлу';

  @override
  String get calculating => 'Вычисление...';

  @override
  String get videoLoading => 'Загрузка видео...';

  @override
  String get videoCannotPlay => 'Не удается воспроизвести видео';

  @override
  String get retry => 'Повторить';

  @override
  String get goBack => 'Назад';

  @override
  String get unknownError => 'Произошла неизвестная ошибка';

  @override
  String get videoFileNotFound => 'Видеофайл не найден';

  @override
  String get videoFileEmpty => 'Видеофайл пуст или не может быть прочитан';

  @override
  String get videoLoadTimeout => 'Время загрузки видео истекло';

  @override
  String get videoFormatNotSupported => 'Формат видео не поддерживается';

  @override
  String get noPermission => 'Нет разрешения на доступ к видеофайлу';

  @override
  String get videoPlayError => 'Видео не может быть воспроизведено';

  @override
  String get linkOpenError => 'Ошибка открытия ссылки';

  @override
  String get platformCannotOpen => 'не может быть открыт';

  @override
  String get organizeVideos => 'Организуйте свои видео и легко найдите их.';

  @override
  String get manualEditPermissions =>
      'Вручную редактировать разрешения приложения';

  @override
  String get checkingPermissions => 'Проверка разрешений...';

  @override
  String get permissionRequestError => 'Ошибка запроса разрешения';

  @override
  String get iosAutoPermission =>
      'Автоматическое разрешение предоставлено на устройствах iOS';

  @override
  String get carefulUse => 'Используйте осторожно - нельзя отменить';

  @override
  String get appInformation => 'Информация о приложении';

  @override
  String get searchPlaceholderShort => 'Поиск...';

  @override
  String get shareVideoLink => 'Поделиться ссылкой на видео';

  @override
  String get shareVideoLinkDesc => 'Через меню обмена телефона';

  @override
  String get shareDetailedInfo => 'Поделиться подробной информацией';

  @override
  String get shareDetailedInfoDesc => 'С названием, описанием и тегами';

  @override
  String get copyLink => 'Копировать ссылку';

  @override
  String get copyLinkDesc => 'Копировать в буфер обмена';

  @override
  String get linkCopied => 'Ссылка скопирована в буфер обмена';

  @override
  String get shareError => 'Ошибка обмена';

  @override
  String get copyError => 'Ошибка копирования';

  @override
  String get videoLinkShared => 'Ссылка на видео поделена';

  @override
  String get videoDetailsShared => 'Детали видео поделены';

  @override
  String get loading => 'Загрузка...';

  @override
  String get previewLoading => 'Предпросмотр\nЗагрузка...';

  @override
  String get previewUnavailable => 'Предпросмотр\nНедоступен';

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
  String get platformGeneral => 'Общее';

  @override
  String get categoryGeneral => 'Общее';

  @override
  String get categorySoftware => 'Программное обеспечение';

  @override
  String get categoryEducation => 'Образование';

  @override
  String get categoryEntertainment => 'Развлечения';

  @override
  String get categorySports => 'Спорт';

  @override
  String get categoryFood => 'Еда';

  @override
  String get categoryMusic => 'Музыка';

  @override
  String get categoryArt => 'Искусство';

  @override
  String get categoryScience => 'Наука';

  @override
  String get categoryTechnology => 'Технологии';

  @override
  String get noDescription => 'Нет описания';

  @override
  String get descriptionNotAvailable => 'Описание недоступно';

  @override
  String get noTags => 'Нет тегов';

  @override
  String get sharedFromLinkcim => 'Поделено из приложения Linkcim';

  @override
  String videoCollection(int count) {
    return 'Коллекция видео ($count видео)';
  }

  @override
  String categoryVideos(String category) {
    return 'Категория $category';
  }

  @override
  String videosFoundInCategory(int count) {
    return 'Найдено $count видео';
  }

  @override
  String andMoreVideos(int count) {
    return '... и еще $count видео';
  }

  @override
  String get videoTitleFromUrl => 'Название видео';

  @override
  String get instagramPost => 'Публикация в Instagram';

  @override
  String get instagramReel => 'Instagram Reel';

  @override
  String get instagramTV => 'Instagram TV';

  @override
  String get instagramVideo => 'Видео Instagram';

  @override
  String get youtubeVideo => 'Видео YouTube';

  @override
  String get youtubeShorts => 'YouTube Shorts';

  @override
  String get tiktokVideo => 'Видео TikTok';

  @override
  String get tiktokVideoShortLink => 'Видео TikTok (короткая ссылка)';

  @override
  String get twitterPost => 'Публикация в Twitter';

  @override
  String twitterUser(String username) {
    return 'Twitter (@$username)';
  }

  @override
  String get xTwitterPost => 'Публикация в X/Twitter';

  @override
  String xTwitterUser(String username) {
    return 'X/Twitter (@$username)';
  }

  @override
  String get facebookVideo => 'Видео Facebook';

  @override
  String get vimeoVideo => 'Видео Vimeo';

  @override
  String get redditVideo => 'Видео Reddit';

  @override
  String get unknownChannel => 'Неизвестный канал';

  @override
  String get quickShare => 'Быстрый обмен';

  @override
  String get videoShared => 'Видео поделено';

  @override
  String shareFailed(String error) {
    return 'Не удалось поделиться: $error';
  }

  @override
  String get grantPermission => 'Предоставить разрешение';

  @override
  String get later => 'Позже';

  @override
  String get videoAccess => 'Доступ к видео';

  @override
  String get videoAccessDescription =>
      'Для сохранения и организации ссылок на видео';

  @override
  String get collections => 'Коллекции';

  @override
  String get collection => 'Коллекция';

  @override
  String get newCollection => 'Новая коллекция';

  @override
  String get collectionName => 'Название коллекции';

  @override
  String get collectionDescription => 'Описание';

  @override
  String get addToCollection => 'Добавить в коллекцию';

  @override
  String get removeFromCollection => 'Удалить из коллекции';

  @override
  String get collectionCreated => 'Коллекция создана';

  @override
  String get collectionUpdated => 'Коллекция обновлена';

  @override
  String get collectionDeleted => 'Коллекция удалена';

  @override
  String get videoAddedToCollection => 'Видео добавлено в коллекцию';

  @override
  String get videoRemovedFromCollection => 'Видео удалено из коллекции';

  @override
  String get noCollections => 'Пока нет коллекций';

  @override
  String get createFirstCollection => 'Создайте свою первую коллекцию';

  @override
  String videosInCollection(int count) {
    return '$count видео';
  }

  @override
  String get advancedSearch => 'Расширенный поиск';

  @override
  String get filterBy => 'Фильтровать по';

  @override
  String get sortBy => 'Сортировать по';

  @override
  String get sortNewest => 'Сначала новые';

  @override
  String get sortOldest => 'Сначала старые';

  @override
  String get sortTitle => 'Название (А-Я)';

  @override
  String get sortPlatform => 'Платформа';

  @override
  String get filterPlatform => 'Платформа';

  @override
  String get filterCategory => 'Категория';

  @override
  String get filterTags => 'Теги';

  @override
  String get filterDateRange => 'Диапазон дат';

  @override
  String get fromDate => 'С даты';

  @override
  String get toDate => 'По дату';

  @override
  String get clearFilters => 'Очистить фильтры';

  @override
  String get applyFilters => 'Применить фильтры';

  @override
  String get selectMultiple => 'Выбрать несколько';

  @override
  String get allPlatforms => 'Все платформы';

  @override
  String get detailedInformation => 'Подробная информация';

  @override
  String get linkDetails => 'Детали ссылки';

  @override
  String get videoType => 'Тип видео';

  @override
  String get urlLength => 'Длина URL';

  @override
  String get fullUrl => 'Полный URL';

  @override
  String get characters => 'символов';

  @override
  String get playInApp => 'Воспроизвести в приложении';

  @override
  String get instagramInfo => 'Информация Instagram';

  @override
  String get loadingInstagramInfo => 'Загрузка информации Instagram...';

  @override
  String get author => 'Автор';

  @override
  String get postType => 'Тип';

  @override
  String get postId => 'ID публикации';

  @override
  String get igtv => 'IGTV';

  @override
  String get twitterVideo => 'Видео Twitter';

  @override
  String get video => 'Видео';

  @override
  String couldNotOpen(String platform) {
    return 'Не удалось открыть $platform';
  }

  @override
  String get platform => 'Платформа';

  @override
  String get appDescription =>
      'Приложение для организации видео. Организуйте видео с Instagram, YouTube, TikTok и Twitter.';

  @override
  String get technicalInformation => 'Техническая информация';

  @override
  String get framework => 'Фреймворк';

  @override
  String get systemVersion => 'Версия системы';

  @override
  String get packageName => 'Имя пакета';

  @override
  String get developer => 'Разработчик';

  @override
  String get developerName => 'Разработчик';

  @override
  String get profession => 'Профессия';

  @override
  String get visitWebsite => 'Посетить мой сайт';

  @override
  String get close => 'Закрыть';

  @override
  String get computerEngineer => 'Инженер-программист';
}
