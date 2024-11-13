class AppFirebaseStorageException implements Exception {
  final String code;

  AppFirebaseStorageException(this.code);

  String get message {
    switch (code) {
      case 'unknown':
        return 'An unknown error occurred while accessing Firebase Storage. Please try again later.';
      case 'object-not-found':
        return 'The requested file could not be found. Please check the file path and try again.';
      case 'bucket-not-found':
        return 'The specified storage bucket could not be found. Please check your Firebase Storage configuration.';
      case 'project-not-found':
        return 'The specified project could not be found. Please check your Firebase project configuration.';
      case 'quota-exceeded':
        return 'The storage quota has been exceeded. Please delete some files or upgrade your plan.';
      case 'unauthenticated':
        return 'You are not authenticated. Please log in to access Firebase Storage.';
      case 'unauthorized':
        return 'You do not have permission to access this file. Please check your permissions and try again.';
      case 'retry-limit-exceeded':
        return 'The retry limit for this operation has been exceeded. Please try again later.';
      case 'invalid-checksum':
        return 'The file\'s checksum does not match. Please verify the file and try again.';
      case 'canceled':
        return 'The operation was canceled. Please try again if this was a mistake.';
      case 'invalid-event-name':
        return 'An invalid event name was provided. Please provide a valid event name.';
      case 'invalid-url':
        return 'The provided URL is not valid. Please check the URL and try again.';
      case 'invalid-argument':
        return 'An invalid argument was provided. Please check the input and try again.';
      case 'no-default-bucket':
        return 'No default bucket has been configured. Please specify a bucket name and try again.';
      case 'cannot-slice-blob':
        return 'The file could not be sliced for uploading. Please try uploading the file again.';
      case 'server-file-wrong-size':
        return 'The uploaded file size does not match the server\'s expectations. Please verify the file and try again.';
      case 'invalid-file-type':
        return 'The file type is not supported. Please choose a valid file type.';
      case 'timeout':
        return 'The operation timed out. Please check your internet connection and try again.';
      case 'storage-retry-limit-exceeded':
        return 'The retry limit for this operation has been exceeded. Please try again later.';
      case 'invalid-json':
        return 'The provided JSON is invalid. Please check the JSON format and try again.';
      case 'invalid-user':
        return 'The provided user does not have access to this file. Please check the user permissions and try again.';
      case 'download-size-exceeded':
        return 'The download size has exceeded the allowed limit. Please try a smaller file or request more storage.';
      case 'internal-error':
        return 'An internal server error occurred. Please try again later.';
      case 'not-found':
        return 'The specified file or directory was not found.';
      default:
        return 'An unexpected storage error occurred. Please try again.';
    }
  }
}
