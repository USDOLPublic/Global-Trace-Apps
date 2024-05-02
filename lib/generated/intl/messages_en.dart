// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  static String m0(field) => "${field} Added!";

  static String m1(present) =>
      "Estimation based on ${present}% conversion rate.";

  static String m2(time) => "Last update: ${time}";

  static String m3(role) => "Non-participating ${role}";

  static String m4(num) => "${num} indicators added";

  static String m5(field) => "${field} Contact";

  static String m6(field) => "${field} Information";

  static String m7(step, totalStep) => "${step} of ${totalStep}";

  static String m8(totalWeight) =>
      "Total Weight must not be less than ${totalWeight}";

  static String m9(value) => "${value} month";

  static String m10(value) => "${value} months";

  static String m11(tracedValue, total) =>
      "Verified: ${tracedValue} of ${total}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "abrapa": MessageLookupByLibrary.simpleMessage("ABRAPA"),
        "account": MessageLookupByLibrary.simpleMessage("Account"),
        "add": MessageLookupByLibrary.simpleMessage("Add"),
        "addAnother": MessageLookupByLibrary.simpleMessage("Add Another"),
        "addBusinessPartner":
            MessageLookupByLibrary.simpleMessage("Add Business Partner"),
        "addBusinessPartnerInformation": MessageLookupByLibrary.simpleMessage(
            "Add Business Partner Information"),
        "addInputProduct":
            MessageLookupByLibrary.simpleMessage("Add Input Product"),
        "addOutputProduct":
            MessageLookupByLibrary.simpleMessage("Add Output Product"),
        "addPartner": MessageLookupByLibrary.simpleMessage("Add Partner"),
        "addProduct": MessageLookupByLibrary.simpleMessage("Add Products"),
        "addProductsManually":
            MessageLookupByLibrary.simpleMessage("Add Products Manually"),
        "addSuccess": m0,
        "addedTime": MessageLookupByLibrary.simpleMessage("Added Time"),
        "address": MessageLookupByLibrary.simpleMessage("Address"),
        "appName": MessageLookupByLibrary.simpleMessage("Global Trace"),
        "apply": MessageLookupByLibrary.simpleMessage("Apply"),
        "assignLotId": MessageLookupByLibrary.simpleMessage("Assign Lot ID"),
        "back": MessageLookupByLibrary.simpleMessage("Back"),
        "backToLogin": MessageLookupByLibrary.simpleMessage("Back to Login"),
        "basfE3": MessageLookupByLibrary.simpleMessage("BASF e3"),
        "betterCotton": MessageLookupByLibrary.simpleMessage(
            "Better Cotton Initiative (BCI)"),
        "broker": MessageLookupByLibrary.simpleMessage("Broker"),
        "brokerName": MessageLookupByLibrary.simpleMessage(
            "Broker Name (Business Registration Number)"),
        "businessInformation":
            MessageLookupByLibrary.simpleMessage("Business Information"),
        "businessName": MessageLookupByLibrary.simpleMessage("Business Name"),
        "businessNameLower":
            MessageLookupByLibrary.simpleMessage("Business name"),
        "businessPartnerContact":
            MessageLookupByLibrary.simpleMessage("Business Partner Contact"),
        "businessPartnerInformation": MessageLookupByLibrary.simpleMessage(
            "Business Partner Information"),
        "businessRegisterNumber": MessageLookupByLibrary.simpleMessage(
            "Business Registration Number"),
        "businessRegisterNumberOptional": MessageLookupByLibrary.simpleMessage(
            "Business Registration Number (Optional)"),
        "businessRegisterPrefix":
            MessageLookupByLibrary.simpleMessage("Reg No: "),
        "businessSpecial": MessageLookupByLibrary.simpleMessage(
            "Business registration number cannot empty"),
        "bussinessInformationInValid": MessageLookupByLibrary.simpleMessage(
            "Business Information is invalid!"),
        "bussinessNameLength":
            MessageLookupByLibrary.simpleMessage("Business Name cannot empty"),
        "byProduct": MessageLookupByLibrary.simpleMessage("By-product"),
        "cameraAccessDenied": MessageLookupByLibrary.simpleMessage(
            "Camera access denied. Let open the app setting to enable it!"),
        "cancel": MessageLookupByLibrary.simpleMessage("Cancel"),
        "certification": MessageLookupByLibrary.simpleMessage("Certification"),
        "certificationAndCustodyModel": MessageLookupByLibrary.simpleMessage(
            "Certification And Custody Model"),
        "chainOfCustody":
            MessageLookupByLibrary.simpleMessage("Chain of Custody"),
        "checkYourEmail":
            MessageLookupByLibrary.simpleMessage("Check your email"),
        "childPartnerHadExits":
            MessageLookupByLibrary.simpleMessage("Child partner has exits"),
        "chooseFromFileDirectory":
            MessageLookupByLibrary.simpleMessage("Choose file from Directory"),
        "chooseFromGallery":
            MessageLookupByLibrary.simpleMessage("Choose from Gallery"),
        "cleanerCotton": MessageLookupByLibrary.simpleMessage("Cleaner Cotton"),
        "clickHere":
            MessageLookupByLibrary.simpleMessage(" Click here to create."),
        "communityRiskScan":
            MessageLookupByLibrary.simpleMessage("Community Risk Scan"),
        "completed": MessageLookupByLibrary.simpleMessage("Completed"),
        "confirmPassword":
            MessageLookupByLibrary.simpleMessage("Confirm Password"),
        "confirmPasswordLower":
            MessageLookupByLibrary.simpleMessage("Confirm password"),
        "confirmPasswordNotMatch": MessageLookupByLibrary.simpleMessage(
            "Confirm password does not match with new password"),
        "contact": MessageLookupByLibrary.simpleMessage("Contact"),
        "contactName": MessageLookupByLibrary.simpleMessage("Contact Name"),
        "continueSAQ": MessageLookupByLibrary.simpleMessage(
            "Continue Self Assessment Questionnaire"),
        "conventionalCotton":
            MessageLookupByLibrary.simpleMessage("Conventional Cotton"),
        "cottonCertification":
            MessageLookupByLibrary.simpleMessage("Cotton Certification"),
        "cottonCertificationBCI": MessageLookupByLibrary.simpleMessage("BCI"),
        "cottonCertificationGOTS": MessageLookupByLibrary.simpleMessage("GOTS"),
        "cottonCertificationGRS": MessageLookupByLibrary.simpleMessage("GRS"),
        "cottonCertificationLeather":
            MessageLookupByLibrary.simpleMessage("Leather Working Group"),
        "cottonCertificationOEKO":
            MessageLookupByLibrary.simpleMessage("OEKO Tex"),
        "cottonCertificationOptional": MessageLookupByLibrary.simpleMessage(
            "Cotton Certification (Optional)"),
        "cottonCertificationOrganic":
            MessageLookupByLibrary.simpleMessage("Organic Cotton"),
        "cottonCertificationOther":
            MessageLookupByLibrary.simpleMessage("Other"),
        "cottonMadeInAfrica": MessageLookupByLibrary.simpleMessage(
            "Cotton made in Africa (CmiA)"),
        "country": MessageLookupByLibrary.simpleMessage("Country"),
        "createYourNewPassword":
            MessageLookupByLibrary.simpleMessage("Create your new password"),
        "currency": MessageLookupByLibrary.simpleMessage("Currency"),
        "currentPassword":
            MessageLookupByLibrary.simpleMessage("Current Password"),
        "currentPasswordLower":
            MessageLookupByLibrary.simpleMessage("Current password"),
        "cycle": MessageLookupByLibrary.simpleMessage("Cycle"),
        "dangerZone": MessageLookupByLibrary.simpleMessage("Danger zone"),
        "dataSaved": MessageLookupByLibrary.simpleMessage("Data Saved!"),
        "dateAndTime": MessageLookupByLibrary.simpleMessage("Date/time"),
        "dateRange": MessageLookupByLibrary.simpleMessage("Date Range"),
        "deleteAccount":
            MessageLookupByLibrary.simpleMessage("Delete my account"),
        "deleteAccountConfirm": MessageLookupByLibrary.simpleMessage(
            "Are you sure you want to delete your account? Deleting your account will result in permanently losing access to the platform."),
        "deleteAccountWarning": MessageLookupByLibrary.simpleMessage(
            "If you delete your account, you will lose your account."),
        "deleteAccountWarningDetails": MessageLookupByLibrary.simpleMessage(
            "This action cannot be undone."),
        "detectLocationFail": MessageLookupByLibrary.simpleMessage(
            "There was an error while detect location. Please try again later"),
        "district": MessageLookupByLibrary.simpleMessage("District"),
        "dnaId": MessageLookupByLibrary.simpleMessage("DNA identifier"),
        "dnaIdOptinal":
            MessageLookupByLibrary.simpleMessage("DNA identifier (Optional)"),
        "done": MessageLookupByLibrary.simpleMessage("Done"),
        "dot": MessageLookupByLibrary.simpleMessage("⦁⦁⦁⦁⦁⦁⦁⦁⦁⦁"),
        "download": MessageLookupByLibrary.simpleMessage("Download"),
        "downloadCertification":
            MessageLookupByLibrary.simpleMessage("Download Certification"),
        "duplicateProduct":
            MessageLookupByLibrary.simpleMessage("Duplicate product ID"),
        "edit": MessageLookupByLibrary.simpleMessage("Edit"),
        "email": MessageLookupByLibrary.simpleMessage("Email"),
        "emailLength":
            MessageLookupByLibrary.simpleMessage("Email cannot empty"),
        "enterYourEmailBelow": MessageLookupByLibrary.simpleMessage(
            "Enter your email below to receive your password reset instructions"),
        "erEmailOrPasswordIncorrect": MessageLookupByLibrary.simpleMessage(
            "Your email address or password is incorrect."),
        "erEmailOrPasswordInvalid": MessageLookupByLibrary.simpleMessage(
            "Your email address or password is incorrect."),
        "estimatedBasedOnPersent": m1,
        "estimatedLintCottonConversion": MessageLookupByLibrary.simpleMessage(
            "Estimated lint cotton conversion"),
        "facility": MessageLookupByLibrary.simpleMessage("Facility"),
        "facilityName": MessageLookupByLibrary.simpleMessage("Facility Name"),
        "failed": MessageLookupByLibrary.simpleMessage("Failed"),
        "failedBy": MessageLookupByLibrary.simpleMessage("Failed by:"),
        "fairtrade": MessageLookupByLibrary.simpleMessage("Fairtrade"),
        "fairtradeOrganic":
            MessageLookupByLibrary.simpleMessage("Fairtrade Organic"),
        "farm": MessageLookupByLibrary.simpleMessage("Farm"),
        "farmGroup": MessageLookupByLibrary.simpleMessage("Farm Group"),
        "farmName": MessageLookupByLibrary.simpleMessage("Farm Name"),
        "fieldInvalid": MessageLookupByLibrary.simpleMessage("Field invalid"),
        "fieldToMarket":
            MessageLookupByLibrary.simpleMessage("Field to Market"),
        "fileAlreadyExists":
            MessageLookupByLibrary.simpleMessage("File already exists!"),
        "fileAndAttachment":
            MessageLookupByLibrary.simpleMessage("File & attachment"),
        "fileInvalid":
            MessageLookupByLibrary.simpleMessage("File error. can\'t open"),
        "fileTooLarge": MessageLookupByLibrary.simpleMessage(
            "File upload must be smaller than 10 Mb"),
        "filters": MessageLookupByLibrary.simpleMessage("Filters"),
        "finishCreatingAccount":
            MessageLookupByLibrary.simpleMessage("Finish creating an account"),
        "firstName": MessageLookupByLibrary.simpleMessage("First Name"),
        "firstNameLength":
            MessageLookupByLibrary.simpleMessage("First Name cannot empty"),
        "forgotPassword":
            MessageLookupByLibrary.simpleMessage("Forgot password?"),
        "forgotPasswordTitle":
            MessageLookupByLibrary.simpleMessage("Forgot Password"),
        "genericErrorDescriptionShort": MessageLookupByLibrary.simpleMessage(
            "Something went wrong. Please try again later"),
        "goods": MessageLookupByLibrary.simpleMessage("Goods"),
        "grade": MessageLookupByLibrary.simpleMessage("Grade"),
        "gradeOptional":
            MessageLookupByLibrary.simpleMessage("Grade (Optional)"),
        "haveNoFileForDownload":
            MessageLookupByLibrary.simpleMessage("Have no file for download"),
        "haventOsId": MessageLookupByLibrary.simpleMessage("Didn\'t have one?"),
        "highSevrity": MessageLookupByLibrary.simpleMessage("High"),
        "history": MessageLookupByLibrary.simpleMessage("History"),
        "home": MessageLookupByLibrary.simpleMessage("Home"),
        "indicatorSub":
            MessageLookupByLibrary.simpleMessage("Indicator/Sub-indicator"),
        "indicators": MessageLookupByLibrary.simpleMessage("Indicators"),
        "information": MessageLookupByLibrary.simpleMessage("Information"),
        "invalidConfirmPassword":
            MessageLookupByLibrary.simpleMessage("Password doesn\'t match"),
        "invalidEmailAddress": MessageLookupByLibrary.simpleMessage(
            "Please enter your email address in format: yourname@example.com"),
        "invalidPassword":
            MessageLookupByLibrary.simpleMessage("The Password is invalid"),
        "invalidPasswordLength":
            MessageLookupByLibrary.simpleMessage("At least eight characters"),
        "invalidPasswordOneCapitalLetter":
            MessageLookupByLibrary.simpleMessage("At least one capital letter"),
        "invalidPasswordOneLetter":
            MessageLookupByLibrary.simpleMessage("At least one letter"),
        "invalidPasswordOneNumber":
            MessageLookupByLibrary.simpleMessage("At least one number"),
        "invalidPasswordOneSpecialLetter":
            MessageLookupByLibrary.simpleMessage("At least one special letter"),
        "inviteTokenInvalid":
            MessageLookupByLibrary.simpleMessage("Token is invalid or expired"),
        "invoiceNumber": MessageLookupByLibrary.simpleMessage("Invoice Number"),
        "iscc": MessageLookupByLibrary.simpleMessage("ISCC"),
        "kg": MessageLookupByLibrary.simpleMessage("KG"),
        "laborName": MessageLookupByLibrary.simpleMessage("Name"),
        "language": MessageLookupByLibrary.simpleMessage("Language"),
        "lasUpdateTime": m2,
        "lastName": MessageLookupByLibrary.simpleMessage("Last Name"),
        "lastNameLength":
            MessageLookupByLibrary.simpleMessage("Last Name cannot empty"),
        "latestTrade": MessageLookupByLibrary.simpleMessage("Latest Trade:"),
        "lbs": MessageLookupByLibrary.simpleMessage("LBS"),
        "lintCottonGrade1":
            MessageLookupByLibrary.simpleMessage("Lint Cotton Grade 1"),
        "lintCottonGrade2":
            MessageLookupByLibrary.simpleMessage("Lint Cotton Grade 2"),
        "lintCottonGrade3":
            MessageLookupByLibrary.simpleMessage("Lint Cotton Grade 3"),
        "lintCottonGrade4":
            MessageLookupByLibrary.simpleMessage("Lint Cotton Grade 4"),
        "lintCottonGrade5":
            MessageLookupByLibrary.simpleMessage("Lint Cotton Grade 5"),
        "lintCottonSuper":
            MessageLookupByLibrary.simpleMessage("Lint Cotton Super"),
        "loadFailedClick":
            MessageLookupByLibrary.simpleMessage("Load Failed! Click retry!"),
        "location": MessageLookupByLibrary.simpleMessage("Location"),
        "locationAccessDenied": MessageLookupByLibrary.simpleMessage(
            "Location access denied. Let open the app setting to enable it!"),
        "locationIsOff":
            MessageLookupByLibrary.simpleMessage("Location Services is off!!"),
        "logIn": MessageLookupByLibrary.simpleMessage("Login"),
        "lowSevrity": MessageLookupByLibrary.simpleMessage("Low"),
        "m": MessageLookupByLibrary.simpleMessage("M"),
        "makeAnAccountHere":
            MessageLookupByLibrary.simpleMessage("Make an account here.."),
        "manageBusinessPartners":
            MessageLookupByLibrary.simpleMessage("Manage Business Partners"),
        "managePartners":
            MessageLookupByLibrary.simpleMessage("Manage Partners"),
        "marginOfError":
            MessageLookupByLibrary.simpleMessage("Margin of Error"),
        "massBalance": MessageLookupByLibrary.simpleMessage("Mass Balance"),
        "mediumSevrity": MessageLookupByLibrary.simpleMessage("Medium"),
        "messageFromRequestor":
            MessageLookupByLibrary.simpleMessage("Message from requestor"),
        "messageTutorialRequest": MessageLookupByLibrary.simpleMessage(
            "View list of grievance requests assigned to you."),
        "moistureLevel":
            MessageLookupByLibrary.simpleMessage("Moisture Level (Percentage)"),
        "moistureLevelMustGreater": MessageLookupByLibrary.simpleMessage(
            "Moisture Level must be greater than 0"),
        "moistureLevelMustNotGreater": MessageLookupByLibrary.simpleMessage(
            "Moisture Level must not be greater than 100"),
        "myBMP": MessageLookupByLibrary.simpleMessage("myBMP"),
        "myProfile": MessageLookupByLibrary.simpleMessage("My Profile"),
        "name": MessageLookupByLibrary.simpleMessage("Name"),
        "nameLength": MessageLookupByLibrary.simpleMessage("Name cannot empty"),
        "newFacilityHasRegitered": MessageLookupByLibrary.simpleMessage(
            "New facility has been registered with supplied details."),
        "newPasswordLower":
            MessageLookupByLibrary.simpleMessage("New password"),
        "newPasswordMustBeDifferent": MessageLookupByLibrary.simpleMessage(
            "New password must be different from current password"),
        "newStatus": MessageLookupByLibrary.simpleMessage("New"),
        "next": MessageLookupByLibrary.simpleMessage("Next"),
        "no": MessageLookupByLibrary.simpleMessage("No"),
        "noCameraPermissionDesctiption": MessageLookupByLibrary.simpleMessage(
            "This app needs camera access to scan QR codes"),
        "noInternetConnection":
            MessageLookupByLibrary.simpleMessage("No internet connection!"),
        "noInternetSubmitData": MessageLookupByLibrary.simpleMessage(
            "No internet connection available. The data will be submitted automatically when network is available"),
        "noLocationPermissionDesctiption": MessageLookupByLibrary.simpleMessage(
            "This app needs Location access to get coordinate"),
        "noMoreData": MessageLookupByLibrary.simpleMessage("No more Data"),
        "noRequestInformation": MessageLookupByLibrary.simpleMessage(
            "No requests for information!"),
        "noResultFound":
            MessageLookupByLibrary.simpleMessage("No results found"),
        "noStoragePermissionDesctiption": MessageLookupByLibrary.simpleMessage(
            "This app needs storage access to save files"),
        "noTransactionsMessage":
            MessageLookupByLibrary.simpleMessage("No transactions."),
        "nonParticipating":
            MessageLookupByLibrary.simpleMessage("Non-participating"),
        "nonParticipatingRole": m3,
        "notMe": MessageLookupByLibrary.simpleMessage("Not me. "),
        "notMePleaseEnterNewOsId": MessageLookupByLibrary.simpleMessage(
            "Please enter the new information to register new OS ID !"),
        "notMePleaseRegisterOsIdAbove": MessageLookupByLibrary.simpleMessage(
            "Please register using details supplied above !"),
        "notSupportBusiness": MessageLookupByLibrary.simpleMessage(
            "Sorry, Your role is not currently supported."),
        "notVerified": MessageLookupByLibrary.simpleMessage("Not Verified"),
        "note": MessageLookupByLibrary.simpleMessage("Note:"),
        "notes": MessageLookupByLibrary.simpleMessage("Notes"),
        "notesMustShorterThan": MessageLookupByLibrary.simpleMessage(
            "Message must be shorter than or equal to 255 characters"),
        "numIndicatorAdded": m4,
        "numericInvalid":
            MessageLookupByLibrary.simpleMessage("Numeric invalid"),
        "ok": MessageLookupByLibrary.simpleMessage("Ok"),
        "okay": MessageLookupByLibrary.simpleMessage("Okay"),
        "onBoard": MessageLookupByLibrary.simpleMessage("Onboard"),
        "oneIndicatorAdded":
            MessageLookupByLibrary.simpleMessage("1 indicator added"),
        "optional": MessageLookupByLibrary.simpleMessage("(Optional)"),
        "organicCotton": MessageLookupByLibrary.simpleMessage("Organic Cotton"),
        "organizationDetail":
            MessageLookupByLibrary.simpleMessage("Organization Details"),
        "osId": MessageLookupByLibrary.simpleMessage("OS ID"),
        "osIdDoesNotExist":
            MessageLookupByLibrary.simpleMessage("OS ID does not exist."),
        "osIdLength":
            MessageLookupByLibrary.simpleMessage("OS ID cannot empty"),
        "osIdPrefix": MessageLookupByLibrary.simpleMessage("OS ID: "),
        "osIdRegistered":
            MessageLookupByLibrary.simpleMessage("OS ID registered!"),
        "other": MessageLookupByLibrary.simpleMessage("Other"),
        "overview": MessageLookupByLibrary.simpleMessage("Overview"),
        "packingListNumber":
            MessageLookupByLibrary.simpleMessage("Packing List Number"),
        "partnerContact": m5,
        "partnerHasBeenRemoved":
            MessageLookupByLibrary.simpleMessage("Partner has been removed!"),
        "partnerHintTest": MessageLookupByLibrary.simpleMessage(
            "Partner Name (Business Registration Number)"),
        "partnerInformation": m6,
        "partnerType": MessageLookupByLibrary.simpleMessage("Partner Type"),
        "password": MessageLookupByLibrary.simpleMessage("Password"),
        "passwordToolTips": MessageLookupByLibrary.simpleMessage(
            "Your password should be at least 8 characters and include all of the following - one letter, one capital letter, one number, one special character"),
        "pending": MessageLookupByLibrary.simpleMessage("Pending"),
        "percentMust": MessageLookupByLibrary.simpleMessage(
            "Percent must be greater than 0"),
        "percentMustNotBe": MessageLookupByLibrary.simpleMessage(
            "Percent must not be greater than 100"),
        "phone": MessageLookupByLibrary.simpleMessage("Phone"),
        "phoneInput": MessageLookupByLibrary.simpleMessage(
            "Phone (including country code) (Optional)"),
        "pickeFileUsing":
            MessageLookupByLibrary.simpleMessage("Pick file using?"),
        "pkr": MessageLookupByLibrary.simpleMessage("PKR"),
        "pleaseFinishTheFollowing": MessageLookupByLibrary.simpleMessage(
            "Please finish the following details to have the full function of the app."),
        "price": MessageLookupByLibrary.simpleMessage("Price"),
        "priceInvalid": MessageLookupByLibrary.simpleMessage("Price invalid"),
        "priceOptional":
            MessageLookupByLibrary.simpleMessage("Price (Optional)"),
        "priority": MessageLookupByLibrary.simpleMessage("Report priority"),
        "processing": MessageLookupByLibrary.simpleMessage("Processing..."),
        "processingFacility":
            MessageLookupByLibrary.simpleMessage("Processing Facility"),
        "product": MessageLookupByLibrary.simpleMessage("Product"),
        "productAlreadyPurchased":
            MessageLookupByLibrary.simpleMessage("Product already purchased"),
        "productAlreadySold":
            MessageLookupByLibrary.simpleMessage("Product is invalid or sold"),
        "productAlreadyTransformed":
            MessageLookupByLibrary.simpleMessage("Product already transformed"),
        "productAlreadyTransported":
            MessageLookupByLibrary.simpleMessage("Product already transported"),
        "productId": MessageLookupByLibrary.simpleMessage("Product ID"),
        "productList": MessageLookupByLibrary.simpleMessage("Product List"),
        "productQuantitiesCantCalculatedMarginError":
            MessageLookupByLibrary.simpleMessage(
                "Product quantities cannot be automatically converted so <margin of error> cannot be calculated."),
        "productQuantitiesCantCalculatedMassBalance":
            MessageLookupByLibrary.simpleMessage(
                "Product quantities cannot be automatically converted so <Mass Balance> cannot be calculated."),
        "productSegregation":
            MessageLookupByLibrary.simpleMessage("Product Segregation"),
        "products": MessageLookupByLibrary.simpleMessage("Products"),
        "profile": MessageLookupByLibrary.simpleMessage("Profile"),
        "profileSuccessfully": MessageLookupByLibrary.simpleMessage(
            "Your profile has been successfully updated"),
        "provinceState": MessageLookupByLibrary.simpleMessage("Province/State"),
        "pullUpLoad": MessageLookupByLibrary.simpleMessage("Pull up load"),
        "purchase": MessageLookupByLibrary.simpleMessage("Purchase"),
        "purchaseOrderNumber":
            MessageLookupByLibrary.simpleMessage("Purchase Order Number"),
        "purchaser": MessageLookupByLibrary.simpleMessage("Purchaser"),
        "quality": MessageLookupByLibrary.simpleMessage("Quality"),
        "question": MessageLookupByLibrary.simpleMessage("Question"),
        "reconciliationWindowDuration": MessageLookupByLibrary.simpleMessage(
            "Reconciliation Window Duration"),
        "reconciliationWindowStartDate": MessageLookupByLibrary.simpleMessage(
            "Reconciliation Window Start Date"),
        "recordByProduct":
            MessageLookupByLibrary.simpleMessage("Record by-product"),
        "recycledCotton":
            MessageLookupByLibrary.simpleMessage("Recycled Cotton"),
        "reelCotton": MessageLookupByLibrary.simpleMessage("REEL Cotton"),
        "regenerativeCotton":
            MessageLookupByLibrary.simpleMessage("Regenerative Cotton"),
        "registerBroker":
            MessageLookupByLibrary.simpleMessage("Register Broker"),
        "registerOsID": MessageLookupByLibrary.simpleMessage("Register OS ID"),
        "registerProcessingFacility": MessageLookupByLibrary.simpleMessage(
            "Register Processing Facility"),
        "registerTransporter":
            MessageLookupByLibrary.simpleMessage("Register Transporter"),
        "releaseToLoad":
            MessageLookupByLibrary.simpleMessage("Release to load more"),
        "rememberYourPassword":
            MessageLookupByLibrary.simpleMessage("Remember your password? "),
        "reportNumber": MessageLookupByLibrary.simpleMessage("Report Number"),
        "requestHome": MessageLookupByLibrary.simpleMessage("Requests"),
        "requestOsID": MessageLookupByLibrary.simpleMessage("Request OS ID"),
        "requestsForInformation":
            MessageLookupByLibrary.simpleMessage("Requests for Information"),
        "reset": MessageLookupByLibrary.simpleMessage("Reset"),
        "resetPassword": MessageLookupByLibrary.simpleMessage("Reset Password"),
        "respondToRequest":
            MessageLookupByLibrary.simpleMessage("Respond to request"),
        "responded": MessageLookupByLibrary.simpleMessage("Responded"),
        "responseSent": MessageLookupByLibrary.simpleMessage("Response sent"),
        "responseSubmitted":
            MessageLookupByLibrary.simpleMessage("Response Submitted!"),
        "sale": MessageLookupByLibrary.simpleMessage("Sale"),
        "saqSuccessfullyCompleted": MessageLookupByLibrary.simpleMessage(
            "SAQ has been completed successfully"),
        "save": MessageLookupByLibrary.simpleMessage("Save"),
        "searchProcessingFacilityHint": MessageLookupByLibrary.simpleMessage(
            "Facility Name (Business Registration Number)"),
        "seedCottonGrade1":
            MessageLookupByLibrary.simpleMessage("Seed Cotton Grade 1"),
        "seedCottonGrade2":
            MessageLookupByLibrary.simpleMessage("Seed Cotton Grade 2"),
        "seedCottonGrade3":
            MessageLookupByLibrary.simpleMessage("Seed Cotton Grade 3"),
        "seedCottonGrade4":
            MessageLookupByLibrary.simpleMessage("Seed Cotton Grade 4"),
        "seedCottonGrade5":
            MessageLookupByLibrary.simpleMessage("Seed Cotton Grade 5"),
        "seedCottonSuper":
            MessageLookupByLibrary.simpleMessage("Seed Cotton Super"),
        "selectDate": MessageLookupByLibrary.simpleMessage("Select date"),
        "selfAssessment": MessageLookupByLibrary.simpleMessage(
            "Self Assessment Questionnaire"),
        "selfAssessmentQuestionnaire": MessageLookupByLibrary.simpleMessage(
            "Self Assessment Questionnaire"),
        "sell": MessageLookupByLibrary.simpleMessage("Sell"),
        "seller": MessageLookupByLibrary.simpleMessage("Seller"),
        "send": MessageLookupByLibrary.simpleMessage("Send"),
        "setPasswordToFinishCreating": MessageLookupByLibrary.simpleMessage(
            "Set a password to finish creating your account."),
        "severity": MessageLookupByLibrary.simpleMessage("Severity"),
        "showPhone": MessageLookupByLibrary.simpleMessage(
            "Phone (including country code) "),
        "signIn": MessageLookupByLibrary.simpleMessage("Sign in"),
        "signOut": MessageLookupByLibrary.simpleMessage("Sign Out"),
        "signUp": MessageLookupByLibrary.simpleMessage("Sign up"),
        "source": MessageLookupByLibrary.simpleMessage("Source"),
        "spinnerName": MessageLookupByLibrary.simpleMessage(
            "Spinner Name (OS ID, Business Registration Number)"),
        "status": MessageLookupByLibrary.simpleMessage("Status"),
        "stepOfStep": m7,
        "storageAccessDenied": MessageLookupByLibrary.simpleMessage(
            "Storage access denied. Let open the app setting to enable it!"),
        "streetAddress": MessageLookupByLibrary.simpleMessage("Street Address"),
        "streetAddressOptional":
            MessageLookupByLibrary.simpleMessage("Street Address (Optional)"),
        "subIndicators": MessageLookupByLibrary.simpleMessage("Sub-Indicator"),
        "submission": MessageLookupByLibrary.simpleMessage("Submission"),
        "submit": MessageLookupByLibrary.simpleMessage("Submit"),
        "submitFurtherInformation":
            MessageLookupByLibrary.simpleMessage("Submit Further Information"),
        "takePhoto": MessageLookupByLibrary.simpleMessage("Take Photo"),
        "theFllowingQuestionIncomplete": MessageLookupByLibrary.simpleMessage(
            "The following questions are incomplete"),
        "theWeightTransportMustBeLeast": m8,
        "thisEmailDoesNotExist":
            MessageLookupByLibrary.simpleMessage("The Email does not exist."),
        "totalInput": MessageLookupByLibrary.simpleMessage("Total Inputs"),
        "totalOutput": MessageLookupByLibrary.simpleMessage("Total Outputs"),
        "totalPrice": MessageLookupByLibrary.simpleMessage("Total Price"),
        "totalPriceOptional":
            MessageLookupByLibrary.simpleMessage("Total Price (Optional)"),
        "totalSeedCottonPurchased":
            MessageLookupByLibrary.simpleMessage("Total seed cotton purchased"),
        "totalWeight": MessageLookupByLibrary.simpleMessage("Total Weight"),
        "totalWeightInvalid":
            MessageLookupByLibrary.simpleMessage("Total weight invalid"),
        "totalWeightIsRequired": MessageLookupByLibrary.simpleMessage(
            "This total weight is required"),
        "tradeFromLabel": MessageLookupByLibrary.simpleMessage(" from "),
        "tradeToLabel": MessageLookupByLibrary.simpleMessage(" to "),
        "transformation":
            MessageLookupByLibrary.simpleMessage("Transformation"),
        "transitionalCotton":
            MessageLookupByLibrary.simpleMessage("Transitional Cotton"),
        "transport": MessageLookupByLibrary.simpleMessage("Transport"),
        "transporter": MessageLookupByLibrary.simpleMessage("Transporter"),
        "transporterName": MessageLookupByLibrary.simpleMessage(
            "Transporter Name (Business Registration Number)"),
        "trashContent": MessageLookupByLibrary.simpleMessage("Trash Content"),
        "turnOnLocation": MessageLookupByLibrary.simpleMessage(
            "The location services had been turned off. Please, turn on the location services and try again!"),
        "tutorialRecordByProduct":
            MessageLookupByLibrary.simpleMessage("Record by-product here"),
        "tutorialRecordLotId": MessageLookupByLibrary.simpleMessage(
            "Record product transformation here"),
        "tutorialRecordPurchases": MessageLookupByLibrary.simpleMessage(
            "Record product purchases here"),
        "tutorialRequestInfor": MessageLookupByLibrary.simpleMessage(
            "View a list of requests for information that have been assigned to you."),
        "tutorialSales": MessageLookupByLibrary.simpleMessage(
            "Record Sale of products here"),
        "tutorialSubmitCommunity": MessageLookupByLibrary.simpleMessage(
            "Submit a community risk scan here."),
        "tutorialTransportation":
            MessageLookupByLibrary.simpleMessage("Record transportation here"),
        "tutorialUpdatePersonalDetail": MessageLookupByLibrary.simpleMessage(
            "Update personal details, self assessment questionnaire responses and business partners here."),
        "type": MessageLookupByLibrary.simpleMessage("Type"),
        "unableToAccessCamera":
            MessageLookupByLibrary.simpleMessage("Unable to access camera!"),
        "unableToAccessLocation":
            MessageLookupByLibrary.simpleMessage("Unable to access Location!"),
        "unableToAccessStorage":
            MessageLookupByLibrary.simpleMessage("Unable to access storage!"),
        "unableToConnectToServer": MessageLookupByLibrary.simpleMessage(
            "Unable to connect to server. Please try again later."),
        "unableToUploadTheFile":
            MessageLookupByLibrary.simpleMessage("Unable to upload the file"),
        "unit": MessageLookupByLibrary.simpleMessage("Unit"),
        "unitUpcase": MessageLookupByLibrary.simpleMessage("UNIT"),
        "updateYourProfileHere":
            MessageLookupByLibrary.simpleMessage("Update your profile here."),
        "uploadAnother": MessageLookupByLibrary.simpleMessage("Upload Another"),
        "uploadCertification":
            MessageLookupByLibrary.simpleMessage("Upload Certificate"),
        "uploadFile": MessageLookupByLibrary.simpleMessage("Upload File"),
        "uploadInvoice": MessageLookupByLibrary.simpleMessage("Upload Invoice"),
        "uploadPackingList":
            MessageLookupByLibrary.simpleMessage("Upload Packing List"),
        "uploadProof": MessageLookupByLibrary.simpleMessage("Upload Proof"),
        "uploadReceiptOrPurchaseRecord": MessageLookupByLibrary.simpleMessage(
            "Upload Receipt or Purchase Record"),
        "uploadTransportationLog": MessageLookupByLibrary.simpleMessage(
            "Upload Transportation Log/Packing List"),
        "usCotton": MessageLookupByLibrary.simpleMessage(
            "United States Cotton Trust Protocol"),
        "usd": MessageLookupByLibrary.simpleMessage("USD"),
        "useMyCurrentLocation":
            MessageLookupByLibrary.simpleMessage("Use my current location"),
        "valueMonth": m9,
        "valueMonths": m10,
        "verified": MessageLookupByLibrary.simpleMessage("Verified"),
        "verifiedSumup": m11,
        "viewAll": MessageLookupByLibrary.simpleMessage("View All"),
        "viewSAQ": MessageLookupByLibrary.simpleMessage(
            "Start New Self Assessment Questionnaire"),
        "viewed": MessageLookupByLibrary.simpleMessage("Viewed"),
        "weFoundSimilarResultsToDetails": MessageLookupByLibrary.simpleMessage(
            "We found similar results to your details. \nPlease confirm which record to use:"),
        "weSentYouAPassword": MessageLookupByLibrary.simpleMessage(
            "If an account registered to this email exists, a password reset link will be sent to your inbox. The link is only valid for 15 minutes."),
        "welcome": MessageLookupByLibrary.simpleMessage("Welcome!"),
        "yes": MessageLookupByLibrary.simpleMessage("Yes"),
        "yesDelete": MessageLookupByLibrary.simpleMessage("Yes, delete"),
        "youAreAllSet": MessageLookupByLibrary.simpleMessage("You\'re all set"),
        "yourAccountSuccessfullyCreated": MessageLookupByLibrary.simpleMessage(
            "Your account has been successfully created. You can use it to log in now."),
        "yourEmail": MessageLookupByLibrary.simpleMessage("Your email"),
        "yourLinkHasExpired":
            MessageLookupByLibrary.simpleMessage("Your link has expired"),
        "yourPasswordHasUpdated": MessageLookupByLibrary.simpleMessage(
            "Your password has been successfully updated. You can use it to log in now."),
        "yourPasswordResetLinkIsOnlyVadid": MessageLookupByLibrary.simpleMessage(
            "Your password reset link is only valid for 15 minutes.\nPlease return to the password reset page to request a new link"),
        "yourSAQCurrentProgressSaved": MessageLookupByLibrary.simpleMessage(
            "Your SAQ current progress has been saved")
      };
}
