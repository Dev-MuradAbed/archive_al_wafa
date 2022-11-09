import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:printing/printing.dart';
import 'package:pdf/widgets.dart' as pw;
import '../providers/speak_get.dart';
import '../utils/util.dart';
import 'package:googleapis/drive/v3.dart' as drive;
import 'package:http/http.dart'as http;
class pdf_page extends StatefulWidget {
  const pdf_page({Key? key}) : super(key: key);

  @override
  State<pdf_page> createState() => _pdf_pageState();
}

class _pdf_pageState extends State<pdf_page> {
  bool _loginStatus = false;
  final googleSignIn = GoogleSignIn.standard(scopes: [
    drive.DriveApi.driveAppdataScope,
    drive.DriveApi.driveFileScope,
  ]);

  PrintingInfo? printingInfo;
  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    final info = await Printing.info();
    setState(() {
      printingInfo = info;
    });
  }
  Future<void> showMessage(BuildContext context, String msg, String title) async {
    final alert =  AlertDialog(
      title: Text(title),
      content: Text(msg),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text("OK"),
        ),
      ],
    );
    await showDialog(
      context: context,
      builder: (BuildContext context) => alert,
    );
  }
  Future<drive.DriveApi?> _getDriveApi() async {
    final googleUser = await googleSignIn.signIn();
    final headers = await googleUser?.authHeaders;
    if (headers == null) {
      await showMessage(context, "Sign-in first", "Error");
      return null;
    }

    final client = GoogleAuthClient(headers);
    final driveApi = drive.DriveApi(client);
    return driveApi;
  }

  Future<void> _uploadToNormal() async {
    final  c = Get.find<SpeakGet>();
    try {
      final driveApi = await _getDriveApi();
      if (driveApi == null) {
        return;
      }
      // Not allow a user to do something else
      showGeneralDialog(
        context: context,
        barrierDismissible: false,
        transitionDuration: Duration(seconds: 2),
        barrierColor: Colors.black.withOpacity(0.5),
        pageBuilder: (context, animation, secondaryAnimation) => Center(
          child: CircularProgressIndicator(),
        ),
      );

      final folderId = await _getFolderId(driveApi);
      if (folderId == null) {
        await showMessage(context, "Failure", "Error");
        return;
      }
      // Create data here instead of loading a file
      // final contents = "xxxxxxxxxxxxxxxxxxxxxxxxxxx";
      // final Stream<List<int>> mediaStream =
      // Future.value(contents.codeUnits).asStream().asBroadcastStream();
      // var media =  drive.Media(mediaStream, contents.length);
      // // Set up File info
      // var driveFile =  drive.File();
      // final timestamp = DateFormat("yyyy-MM-dd-hhmmss").format(DateTime.now());
      // driveFile.name = "اسم الحالة-$timestamp.pdf";
      // driveFile.modifiedTime = DateTime.now().toUtc();
      // driveFile.parents = [folderId];

      // Upload
      final response =
      await driveApi.files.create(c.file as drive.File);
      print("response: $response");

      // simulate a slow process
      await Future.delayed(Duration(seconds: 2));
    } finally {
      // Remove a dialog
      Navigator.pop(context);
    }
  }
  Future<String?> _getFolderId(drive.DriveApi driveApi) async {
    final mimeType = "application/vnd.google-apps.folder";
    String folderName = "اسم الحالة";

    try {
      final found = await driveApi.files.list(
        q: "mimeType = '$mimeType' and name = '$folderName'",
        $fields: "files(id, name)",
      );
      final files = found.files;
      if (files == null) {
        await showMessage(context, "Sign-in first", "Error");
        return null;
      }

      if (files.isNotEmpty) {
        return files.first.id;
      }

      // Create a folder
      var folder =  drive.File();
      folder.name = folderName;
      folder.mimeType = mimeType;
      final folderCreation = await driveApi.files.create(folder);
      print("Folder ID: ${folderCreation.id}");

      return folderCreation.id;
    } catch (e) {
      print(e);
      // I/flutter ( 6132): DetailedApiRequestError(status: 403, message: The granted scopes do not give access to all of the requested spaces.)
      return null;
    }
  }
  @override
  Widget build(BuildContext context) {
    pw.RichText.debug = true;
    final action = <PdfPreviewAction>[
      if (!kIsWeb)
        const PdfPreviewAction(icon: Icon(Icons.add_to_drive), onPressed: saveAsFile)
    ];
    return Scaffold(
        appBar: AppBar(
          title: const Text("Flutter Pdf"),
        ),
        body: PdfPreview(
            maxPageWidth: 700,
            actions: action,
            onPrinted: showPrintedToast,
            onShared: showSharedToast,
            build: generatedPdf));
  }
}
class GoogleAuthClient extends http.BaseClient {
  final Map<String, String> _headers;
  final _client =  http.Client();

  GoogleAuthClient(this._headers);

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    request.headers.addAll(_headers);
    return _client.send(request);
  }
}