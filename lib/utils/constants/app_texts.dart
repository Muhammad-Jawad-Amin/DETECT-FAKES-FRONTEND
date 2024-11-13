/// This class contains all the App Text in String formats.
class AppTexts {
  // Firebase Collections
  static const String usersCollection = 'Users';
  static const String imagesCollection = 'Images';
  static const String videosCollection = 'Videos';
  static const String profilePicsCollection = 'ProfilePics';

  // Firebase Storage
  static const String imagesStorage = 'Images';
  static const String videosStorage = 'Videos';
  static const String profilePicsStorage = 'ProfilePics';

  // -- GLOBAL Texts
  static const String goBack = "Go Back";
  static const String cancel = "Cancel";
  static const String done = "Done";
  static const String next = "Next";
  static const String skip = "Skip";
  static const String submit = "Submit";
  static const String appName = "Detect Fakes";
  static const String tContinue = "Continue";
  static const String google = "Google Account";
  static const String guest = "Guest Account";

  // -- Authentication Forms
  static const String firstName = "First Name";
  static const String lastName = "Last Name";
  static const String email = "E-Mail";
  static const String password = "Password";
  static const String newPassword = "New Password";
  static const String confPassword = "Confirm Password";
  static const String username = "Username";
  static const String country = "Country";
  static const String gender = "Gender";
  static const String dateOfBirth = "Date Of Birth";
  static const String forgetPassword = "Forget Password?";
  static const String signIn = "Sign In";
  static const String createAccount = "Create Account";
  static const String orSignUpSignInWith = "Or Sign Up/ Sign In With";
  static const String verificationCode = "verificationCode";
  static const String resendEmail = "Resend Email";
  static const String resendEmailIn = "Resend email in";
  static const String reAuthenticate = "ReAuthenticate";
  static const String changePassword = "Change Password";

  // -- Authentication Headings
  static const String loginTitle = "Welcome Back";
  static const String loginSubTitle = "Your digital shield against Deepfakes.";
  static const String signupTitle = "Let's Create Your Account";
  static const String forgetPasswordTitle = "Forget Password";
  static const String forgetPasswordQuestion = "Don't remember your password?";
  static const String rememberMe = "Remember Me";

  static const String forgetPasswordSubTitle =
      "Don't worry sometimes people can forget too, enter your email and we will send you a password reset link.";
  static const String resetPasswordTitle = "Password Reset Email Sent";
  static const String resetPasswordSubTitle =
      "Your Account Security is Our Priority! We've Sent You a Secure Link to Safely Change Your Password and Keep Your Account Protected.";
  static const String confirmEmail = "Verify your email address!";
  static const String confirmEmailSubTitle =
      "Congratulations! Your Account Awaits: Verify your Email to start using our app to Detect Fakes.";
  static const String emailNotReceivedMessage =
      "Didn't get the email? Check your junk/spam or resend it.";
  static const String yourAccountCreatedTitle =
      "Your account successfully created!";
  static const String yourAccountCreatedSubTitle =
      "Welcome to your ultimate DeepFake Detection Platform: Your account is created, unleash the power of deeplearning base deepfake tool!";
  static const String reAuthenticationTitle = "Re-Authenticating User";
  static const String reAuthenticationSubTitle =
      "Reauthentication is necessary to make sure that its actullay you who is trying to change the account's password";
  static const String changePasswordTitle = "Change Account's Password";
  static const String channgePassswordSubTitle =
      "Ensure your account stays secure by updating your password regularly. This will prevent intruders from interfering with your accout.";

  // Internet Connection
  static const noInternetTitle = "No Internet Connection";
  static const noInternetSubTitle =
      "You have lost the internet connection. Please check your Wifi connection or Mobile Data or try to connect to a stable internet connection.";

  // FAQs Texts

  // General Questions
  static const String gQuestion1 = 'How can I use your product?';
  static const String gAnswer1 =
      'We provide Detect Fakes Scanner in a mobile app. You can simply select a video/image file from your mobile gallery and upload it to check its authenticity.';

  static const String gQuestion2 = 'Do you detect any fake videos/images?';
  static const String gAnswer2 =
      'No, we are only dedicated to detecting AI-generated face manipulations in the videos/images.';

  static const String gQuestion3 =
      'What does the no deepfake detected result mean?';
  static const String gAnswer3 =
      'The model is looking for signs of manipulation on the human face. If there is no face in the video/image, you get this result.';

  static const String gQuestion4 =
      'What is the maximum video length we can scan?';
  static const String gAnswer4 =
      'We don\'t have any limit on the length of the video but we asked the user to select the number of frames he want to scan, but there is a limit on the size of the file. The vidoe file size should be smaller than 50 MB and the image file size should be smaller than 5 MB.';

  static const String gQuestion5 =
      'What are the platforms visitors can scan video from?';
  static const String gAnswer5 =
      'We currently scan videos/images from platforms such as YouTube, Facebook, and Twitter.';

  static const String gQuestion6 = 'Can I trust your result 100%?';
  static const String gAnswer6 =
      'Deepfakes are not a solved problem yet. So our results are stating the chances of a specific video can be whether deepfake or not.';

  // Technical Questions
  static const String tQuestion1 =
      'What are the things Detect Fakes Scanner focuses on while scanning?';
  static const String tAnswer1 =
      'Detect Fakes Scanner focuses on deepfake manipulation that uses a real video/image of a person and modifies or swaps their face with another person. We do not detect whether the voice is manipulated but only the face of a person in the video.';

  static const String tQuestion2 =
      'What is the technical explanation of the video/image scanning process?';
  static const String tAnswer2 =
      'We extract the faces from the vidoe/image and keep only those frames which have the higher chances of having faces and remove noise such as falsely detected faces. Then the consistently detected faces will be used for detection, and the detection score will be calculated only for them.';

  static const String tQuestion3 =
      'Do you scan and detect all types of synthetic media files?';
  static const String tAnswer3 =
      'No, we currently scan and detect only video and image files. We are working on detecting synthetically generated voice media files.';

  static const String tQuestion4 =
      'What is the best video/image resolution to scan to get the best Detect Fakes Scanner detection result?';
  static const String tAnswer4 =
      'We recommend scanning videos/images that are 1080p or less.';

  static const String tQuestion5 =
      'Does Deepware create deepfake videos/images as well?';
  static const String tAnswer5 =
      'No, as Detect Fakes, we do not generate deepfake video/images, we only detect the deepfake videos and images.';

// DeepFake Timelines Data

  static const List<Map<String, String>> eventsData = [
    {
      'date': 'June 2021',
      'title': 'Facebook doubles down on detecting deepfakes',
      'description':
          'Facebook has collaborated with researchers at the Michigan State University (MSU) to develop a method of detecting and attributing deepfakes.',
      'videoUrl': '',
    },
    {
      'date': 'May 2021',
      'title':
          'New York\'s Right to Publicity and Deepfakes Law Breaks New Ground',
      'description':
          'A path-breaking law signed by New York Governor Andrew M. Cuomo addresses synthetic or digitally manipulated media.',
      'videoUrl': '',
    },
    {
      'date': 'May 2021',
      'title':
          'A “beautiful” female biker was actually a 50-year-old man using FaceApp',
      'description':
          'He said he used photo editing apps such as FaceApp to make himself appear like a youthful woman.',
      'videoUrl': '',
    },
    {
      'date': 'March 2021',
      'title':
          'The video of one minister\'s corruption confession divided people',
      'description':
          'Myanmar military has shown another confession, this time by Yangon Chief Minister apparently admitting to alleged corruption.',
      'videoUrl': 'https://www.youtube.com/embed/iyiOVUbsPcM',
    },
    {
      'date': 'January 2021',
      'title': 'President of Algeria\'s video',
      'description':
          'The President of Algeria\'s video created great confusion in the public as he was too sick to speak to his citizens.',
      'videoUrl': '',
    },
    {
      'date': 'October 2020',
      'title': 'Deepfake Telegram bot',
      'description':
          'Deepfake bot on Telegram is violating women by forging nudes from regular pics.',
      'videoUrl': '',
    },
    {
      'date': 'October 2020',
      'title': 'Twitter introducing new policy towards deepfake',
      'description':
          'Twitter drafts a deepfake policy that would label and warn, but not always remove, manipulated media.',
      'videoUrl': '',
    },
    {
      'date': 'September 2020',
      'title': 'Putin deepfake video',
      'description':
          'A new advertising campaign from anti-corruption non-profit RepresentUs uses deepfake technology to deliver a message about democracy.',
      'videoUrl': 'https://www.youtube.com/embed/KbaKTz9FW2E',
    },
    {
      'date': 'September 2020',
      'title': 'Microsoft deepfake detection tool',
      'description':
          'Microsoft made public that they are developing a Deepfake detection software tool.',
      'videoUrl': '',
    },
    {
      'date': 'August 2020',
      'title': 'AI-generated Elon Musk joined a Zoom call',
      'description':
          'A new deepfake-powered filter allows video conferencing participants to make themselves look like practically any famous person.',
      'videoUrl': 'https://www.youtube.com/embed/JiJKXCkWH3w',
    },
    {
      'date': 'December 2019',
      'title':
          'Deepfake detection challenge and David Beckham\'s deepfake video',
      'description':
          'The global campaign showing Malaria survivors speaking through David Beckham to help raise awareness around the Malaria Must Die initiative.',
      'videoUrl': 'https://www.youtube.com/embed/QiiSAvKJIHo',
    },
    {
      'date': 'October 2019',
      'title': 'Deepware scanner released',
      'description':
          'Deepware Scanner released as the first deepfake detection tool where people can easily scan and detect deepfake videos.',
      'videoUrl': '',
    },
    {
      'date': 'September 2019',
      'title': 'CEO deepfake scam',
      'description':
          'Criminals used AI-based software to impersonate a chief executive\'s voice and demand a fraudulent transfer of €220,000.',
      'videoUrl': '',
    },
    {
      'date': 'August 2019',
      'title': 'ZAO APP',
      'description':
          'Chinese deepfake app that allows users to substitute their own faces onto those of characters in scenes from films and television shows.',
      'videoUrl': '',
    },
    {
      'date': 'July 2019',
      'title': 'FaceApp',
      'description':
          'AI photo editor FaceApp goes viral after adding AI-based age filter.',
      'videoUrl': '',
    },
    {
      'date': 'June 2019',
      'title': 'DeepNude',
      'description':
          'In June 2019, a downloadable application called DeepNude was released, which used neural networks to remove clothing from women\'s images.',
      'videoUrl': '',
    },
    {
      'date': 'May 2018',
      'title': 'US Senator concerns about deepfake',
      'description':
          'US Senator Marco Rubio voices his concerns about deepfakes at the Senate Intelligence Committee nomination hearing.',
      'videoUrl': '',
    },
    {
      'date': 'April 2018',
      'title': 'Obama deepfake video',
      'description':
          'This video contins the deepfake video of the United States president Mr Obama.',
      'videoUrl': 'https://www.youtube.com/embed/cQ54GDm1eL0',
    },
    {
      'date': 'February 2018',
      'title': 'Platforms banning deepfakes',
      'description':
          'Several websites, including Discord, Gfycat, Pornhub, and Twitter, ban deepfakes with varying degrees of success.',
      'videoUrl': '',
    },
    {
      'date': 'January 2018',
      'title': 'Deepfake creation services',
      'description':
          'The first website offering deepfake creation service is launched, funded by user donations.',
      'videoUrl': '',
    },
    {
      'date': 'November 2017',
      'title': 'Deepfakes subreddit created',
      'description':
          'The term deepfakes originated from a Reddit user named "deepfakes" who shared deepfakes in the Reddit community r/deepfakes.',
      'videoUrl': '',
    },
  ];

  // About Us Paragraphs

  static const String paragraph1 =
      "Welcome to Detect Fakes, an innovative platform designed to combat the ever-evolving world of AI-generated deepfakes. Our mission is to empower individuals, organizations, and governments to protect themselves from the dangers of fake media by offering advanced deepfake detection solutions.";

  static const String paragraph2 =
      "With the rapid advancement of deep learning technologies, creating hyper-realistic, AI-generated videos and images, known as deepfakes, has become easier and more accessible. Unfortunately, while these technologies can be used for creative purposes, they also pose a significant threat when used maliciously, leading to identity theft, misinformation, and fraud.";

  static const String paragraph3 =
      "At Detect Fakes, we are committed to addressing these challenges by utilizing cutting-edge deep learning techniques, including Convolutional Vision Transformers (CViT). Our detection model combines the power of Convolutional Neural Networks (CNNs) and Transformers to identify manipulated media with exceptional accuracy. Trained on the largest and most diverse deepfake dataset available, our solution provides reliable detection of AI-generated face manipulations across various environments and orientations.";

  static const String paragraph4 =
      "Our deepfake detection tool is designed to be user-friendly, allowing users to easily upload videos or images for analysis. Whether you're concerned about the authenticity of a media file or want to ensure the legitimacy of online content, Detect Fakes is here to provide you with accurate results you can trust.";

  static const String paragraph5 =
      "Our platform also plays an important role in advancing the research and development of deepfake detection technologies. We continuously improve our models, incorporating the latest advancements in the field, to offer the most effective solutions for detecting malicious media.";
}
