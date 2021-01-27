import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:frontend/models/lirad_user.dart';
import 'package:frontend/services/storage.dart';
import 'package:provider/provider.dart';

class CertificatesScreen extends StatefulWidget {
  @override
  _CertificatesScreenState createState() => _CertificatesScreenState();
}

class _CertificatesScreenState extends State<CertificatesScreen> {
  List<FullMetadata> _certificates;

  @override
  void initState() {
    print('alo porra');
    LiradUser user = Provider.of<LiradUser>(context, listen: false);
    _getCertificatesList(user);
  }

  void _getCertificatesList(LiradUser user) async {
    List<String> filesFullPath = await StorageService.instance.findAllFilesReferenceByUserEmail(user.email);
    filesFullPath.forEach((element) {print(element);});
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
    return Card(child: Container(
      padding: EdgeInsets.all(12),
      child: Column(
        children: [
          Row(children: [
            Text(certificate.name, style: TextStyle(fontWeight: FontWeight.bold)),
            // Spacer(),
            // Text(event['pratica'] ? 'Prática' : ''),
          ],),
        //   Row(children: [
        //     Text(horario)
        //   ],),
        //   SizedBox(height: 12),
        //   Row(
        //     children: [
        //       Flexible(child: Text(event['description'])) 
        //     ],
          // )
        ]
      )
    ));
  }
}