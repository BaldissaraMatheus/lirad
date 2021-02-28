import 'dart:io';
import 'package:dio/dio.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:frontend/models/lirad_user.dart';
import 'package:frontend/services/storage.dart';
import 'package:frontend/services/localNotification.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

class CertificatesScreen extends StatefulWidget {
  @override
  _CertificatesScreenState createState() => _CertificatesScreenState();
}

class _CertificatesScreenState extends State<CertificatesScreen> {
  List<FullMetadata> _certificates;
  PermissionStatus _permissionStatus;
  LocalNotificationService _localNotificationService = LocalNotificationService.instance;
  Dio _dio = Dio();

  @override
  void initState() {
    LiradUser user = Provider.of<LiradUser>(context, listen: false);
    _getCertificatesList(user);
  }

  void _getCertificatesList(LiradUser user) async {
    List<String> filesFullPath = await StorageService.instance.findAllFilesReferenceByUserEmail(user.email);
    var certificates = await Future.wait(filesFullPath.map((path) => StorageService.instance.findFileMetadataByFilePath(path)).toList());
    setState(() {
      _certificates = certificates;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        title: Text('Certificados'),
      ),
      body: _certificates != null
        ? ListView(children: _certificates.map((certificate) => _buildCertificateCard(certificate)).toList())
        : Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(
              Theme.of(context).primaryColor, // Red
            ),
          ),
        ), 
    );
  }


  Widget _buildCertificateCard(FullMetadata certificate) {
    return GestureDetector(
      onTap: () async {
        final permission = await this._requestPermission();
        if (permission != PermissionStatus.granted) {
          return;
        }
        final baseDir = await getExternalStorageDirectory();
        final certificadosDirectory = await new Directory(baseDir.path + '/certificados').create(recursive: true).then((dir) => dir.path);
        final filePath = '$certificadosDirectory/${certificate.name}';
        final fileExists = await File(filePath).exists();
        if (fileExists) {
          return OpenFile.open(filePath).then((value) => value.message);
        }
        _localNotificationService.showNotification('Baixando arquivo: ${certificate.name}');
        final url = await StorageService.instance.findDownloadUrlByFilePath(certificate.fullPath);
        await _dio.download(url, filePath, onReceiveProgress: (rec, total) => {
          print('${(rec/total * 100).truncate()}%'),
        }).then((res) {
          _localNotificationService.showNotification('Arquivo baixado: ${certificate.name}', '', filePath);
          OpenFile.open(filePath).then((value) => value.message);
        })
        .catchError((err) => print(err));
      },
      child: Card(child: Container(
        padding: EdgeInsets.all(12),
        child: Column(
          children: [
            Row(children: [
              Text(certificate.name, style: TextStyle(fontWeight: FontWeight.bold)),
            ],),
          ]
        ),
      )),
    ) ;
  }

  Future<PermissionStatus> _requestPermission() async {
    if (this._permissionStatus == PermissionStatus.granted) {
      return this._permissionStatus;
    }
    final status = await Permission.storage.request();
    setState(() {
      this._permissionStatus = status;
    });
    return status;
  }
}