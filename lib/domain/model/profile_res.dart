import 'package:amplify/domain/model/base_res.dart';

class ProfileRes extends BaseRes {
  int? statusCode;
  Data? data;
  double? durationMs;

  ProfileRes({this.statusCode, this.data, this.durationMs}) : super();

  ProfileRes.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    statusCode = json['statusCode'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    durationMs = json['durationMs'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['statusCode'] = statusCode;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['durationMs'] = durationMs;
    return data;
  }
}

class Data {
  String? userName;
  String? displayName;
  Settings? settings;

  Data({this.userName, this.displayName, this.settings});

  Data.fromJson(Map<String, dynamic> json) {
    userName = json['userName'];
    displayName = json['displayName'];
    settings =
        json['settings'] != null ? Settings.fromJson(json['settings']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userName'] = userName;
    data['displayName'] = displayName;
    if (settings != null) {
      data['settings'] = settings!.toJson();
    }
    return data;
  }
}

class Settings {
  List<Feeds>? feeds;
  List<String>? subscribedCalendars;
  Features? features;
  ManagerConfig? managerConfig;
  DocsConfig? docsConfig;
  Options? options;
  AppConnections? appConnections;
  String? logoPath;

  Settings(
      {this.feeds,
      this.subscribedCalendars,
      this.features,
      this.managerConfig,
      this.docsConfig,
      this.options,
      this.appConnections,
      this.logoPath});

  Settings.fromJson(Map<String, dynamic> json) {
    if (json['feeds'] != null) {
      feeds = <Feeds>[];
      json['feeds'].forEach((v) {
        feeds!.add(Feeds.fromJson(v));
      });
    }
    subscribedCalendars = json['subscribedCalendars'].cast<String>();
    features =
        json['features'] != null ? Features.fromJson(json['features']) : null;
    managerConfig = json['managerConfig'] != null
        ? ManagerConfig.fromJson(json['managerConfig'])
        : null;
    docsConfig = json['docsConfig'] != null
        ? DocsConfig.fromJson(json['docsConfig'])
        : null;
    options =
        json['options'] != null ? Options.fromJson(json['options']) : null;
    appConnections = json['appConnections'] != null
        ? AppConnections.fromJson(json['appConnections'])
        : null;
    logoPath = json['logoPath'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (feeds != null) {
      data['feeds'] = feeds!.map((v) => v.toJson()).toList();
    }
    data['subscribedCalendars'] = subscribedCalendars;
    if (features != null) {
      data['features'] = features!.toJson();
    }
    if (managerConfig != null) {
      data['managerConfig'] = managerConfig!.toJson();
    }
    if (docsConfig != null) {
      data['docsConfig'] = docsConfig!.toJson();
    }
    if (options != null) {
      data['options'] = options!.toJson();
    }
    if (appConnections != null) {
      data['appConnections'] = appConnections!.toJson();
    }
    data['logoPath'] = logoPath;
    return data;
  }
}

class Feeds {
  int? order;
  String? title;
  String? topic;

  Feeds({
    this.order,
    this.title,
    this.topic,
  });

  Feeds.fromJson(Map<String, dynamic> json) {
    order = json['order'];
    title = json['title'];
    topic = json['topic'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['order'] = order;
    data['title'] = title;
    data['topic'] = topic;
    return data;
  }
}

class Features {
  Null allowModelCreation;

  Features({this.allowModelCreation});

  Features.fromJson(Map<String, dynamic> json) {
    allowModelCreation = json['allowModelCreation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['allowModelCreation'] = allowModelCreation;
    return data;
  }
}

class ManagerConfig {
  Null allowManagerBrowsing;

  ManagerConfig({this.allowManagerBrowsing});

  ManagerConfig.fromJson(Map<String, dynamic> json) {
    allowManagerBrowsing = json['allowManagerBrowsing'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['allowManagerBrowsing'] = allowManagerBrowsing;
    return data;
  }
}

class DocsConfig {
  Null allowLibraryCreation;
  Null termsAgreementDate;

  DocsConfig({this.allowLibraryCreation, this.termsAgreementDate});

  DocsConfig.fromJson(Map<String, dynamic> json) {
    allowLibraryCreation = json['allowLibraryCreation'];
    termsAgreementDate = json['termsAgreementDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['allowLibraryCreation'] = allowLibraryCreation;
    data['termsAgreementDate'] = termsAgreementDate;
    return data;
  }
}

class Options {
  bool? demoMode;
  String? viewMode;
  bool? betaFeatures;
  String? allocCompareMode;

  Options(
      {this.demoMode, this.viewMode, this.betaFeatures, this.allocCompareMode});

  Options.fromJson(Map<String, dynamic> json) {
    demoMode = json['demoMode'];
    viewMode = json['viewMode'];
    betaFeatures = json['betaFeatures'];
    allocCompareMode = json['allocCompareMode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['demoMode'] = demoMode;
    data['viewMode'] = viewMode;
    data['betaFeatures'] = betaFeatures;
    data['allocCompareMode'] = allocCompareMode;
    return data;
  }
}

class AppConnections {
  Null docuSign;
  Null redtail;

  AppConnections({this.docuSign, this.redtail});

  AppConnections.fromJson(Map<String, dynamic> json) {
    docuSign = json['docuSign'];
    redtail = json['redtail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['docuSign'] = docuSign;
    data['redtail'] = redtail;
    return data;
  }
}
