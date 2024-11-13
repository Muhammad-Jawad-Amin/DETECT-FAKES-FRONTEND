import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:detect_fakes/models/image_model.dart';
import 'package:detect_fakes/models/video_model.dart';
import 'package:path_provider/path_provider.dart';

class ApiService {
  static const baseUrl = "https://bursting-intimate-weasel.ngrok-free.app";
  static const String detectImageUrl = '/detect/image';
  static const String detectVideoUrl = '/detect/video';
  static const String deleteFileUrl = '/delete/file';

  Future<ImageModel> detectImage(File image) async {
    try {
      const completeImageUrl = "$baseUrl$detectImageUrl";
      final request =
          http.MultipartRequest('POST', Uri.parse(completeImageUrl));
      request.files.add(await http.MultipartFile.fromPath('Image', image.path));

      final response = await request.send();
      final responseData = await response.stream.bytesToString();
      final data = json.decode(responseData);

      if (response.statusCode == 200) {
        return ImageModel.fromMap(data);
      } else {
        throw data["error"];
      }
    } catch (e) {
      throw e.toString();
    }
  }

  Future<VideoModel> detectVideo(
    File video,
    String framesToProcess,
  ) async {
    try {
      const completeVideoUrl = "$baseUrl$detectVideoUrl";
      final request =
          http.MultipartRequest('POST', Uri.parse(completeVideoUrl));
      request.files.add(await http.MultipartFile.fromPath('Video', video.path));
      request.fields['framesToProcess'] = framesToProcess;

      final response = await request.send();
      final responseData = await response.stream.bytesToString();
      final data = json.decode(responseData);

      if (response.statusCode == 200) {
        return VideoModel.fromMap(data);
      } else {
        throw data["error"];
      }
    } catch (e) {
      throw e.toString();
    }
  }

  Future<File> downloadFile(
    String fileUrl,
    String fileName,
  ) async {
    try {
      String completeUrl = "$baseUrl$fileUrl";
      final response = await http.get(Uri.parse(completeUrl));
      if (response.statusCode == 200) {
        Directory tempDir = await getTemporaryDirectory();
        String tempPath = tempDir.path;
        File file = File('$tempPath/$fileName');
        await file.writeAsBytes(response.bodyBytes);
        return file;
      } else {
        throw Exception('Failed to load the file.');
      }
    } catch (e) {
      throw e.toString();
    }
  }

  Future<void> deleteFile(String filePath, String fileType) async {
    String completeUrl = "$baseUrl$deleteFileUrl";
    final url = Uri.parse(completeUrl);
    final body = jsonEncode({
      "filePath": filePath,
      "fileType": fileType,
    });

    try {
      await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: body,
      );
    } catch (e) {
      throw e.toString();
    }
  }
}
