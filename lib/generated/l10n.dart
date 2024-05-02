// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Global Trace`
  String get appName {
    return Intl.message(
      'Global Trace',
      name: 'appName',
      desc: '',
      args: [],
    );
  }

  /// `Processing...`
  String get processing {
    return Intl.message(
      'Processing...',
      name: 'processing',
      desc: '',
      args: [],
    );
  }

  /// `Ok`
  String get ok {
    return Intl.message(
      'Ok',
      name: 'ok',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Yes`
  String get yes {
    return Intl.message(
      'Yes',
      name: 'yes',
      desc: '',
      args: [],
    );
  }

  /// `Done`
  String get done {
    return Intl.message(
      'Done',
      name: 'done',
      desc: '',
      args: [],
    );
  }

  /// `Welcome!`
  String get welcome {
    return Intl.message(
      'Welcome!',
      name: 'welcome',
      desc: '',
      args: [],
    );
  }

  /// `Set a password to finish creating your account.`
  String get setPasswordToFinishCreating {
    return Intl.message(
      'Set a password to finish creating your account.',
      name: 'setPasswordToFinishCreating',
      desc: '',
      args: [],
    );
  }

  /// `Sign in`
  String get signIn {
    return Intl.message(
      'Sign in',
      name: 'signIn',
      desc: '',
      args: [],
    );
  }

  /// `Sign up`
  String get signUp {
    return Intl.message(
      'Sign up',
      name: 'signUp',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Password`
  String get confirmPassword {
    return Intl.message(
      'Confirm Password',
      name: 'confirmPassword',
      desc: '',
      args: [],
    );
  }

  /// `Account`
  String get account {
    return Intl.message(
      'Account',
      name: 'account',
      desc: '',
      args: [],
    );
  }

  /// `Forgot password?`
  String get forgotPassword {
    return Intl.message(
      'Forgot password?',
      name: 'forgotPassword',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your email address in format: yourname@example.com`
  String get invalidEmailAddress {
    return Intl.message(
      'Please enter your email address in format: yourname@example.com',
      name: 'invalidEmailAddress',
      desc: '',
      args: [],
    );
  }

  /// `The Password is invalid`
  String get invalidPassword {
    return Intl.message(
      'The Password is invalid',
      name: 'invalidPassword',
      desc: '',
      args: [],
    );
  }

  /// `At least one letter`
  String get invalidPasswordOneLetter {
    return Intl.message(
      'At least one letter',
      name: 'invalidPasswordOneLetter',
      desc: '',
      args: [],
    );
  }

  /// `At least one capital letter`
  String get invalidPasswordOneCapitalLetter {
    return Intl.message(
      'At least one capital letter',
      name: 'invalidPasswordOneCapitalLetter',
      desc: '',
      args: [],
    );
  }

  /// `At least one special letter`
  String get invalidPasswordOneSpecialLetter {
    return Intl.message(
      'At least one special letter',
      name: 'invalidPasswordOneSpecialLetter',
      desc: '',
      args: [],
    );
  }

  /// `At least one number`
  String get invalidPasswordOneNumber {
    return Intl.message(
      'At least one number',
      name: 'invalidPasswordOneNumber',
      desc: '',
      args: [],
    );
  }

  /// `At least eight characters`
  String get invalidPasswordLength {
    return Intl.message(
      'At least eight characters',
      name: 'invalidPasswordLength',
      desc: '',
      args: [],
    );
  }

  /// `Password doesn't match`
  String get invalidConfirmPassword {
    return Intl.message(
      'Password doesn\'t match',
      name: 'invalidConfirmPassword',
      desc: '',
      args: [],
    );
  }

  /// `Your email address or password is incorrect.`
  String get erEmailOrPasswordIncorrect {
    return Intl.message(
      'Your email address or password is incorrect.',
      name: 'erEmailOrPasswordIncorrect',
      desc: '',
      args: [],
    );
  }

  /// `Onboard`
  String get onBoard {
    return Intl.message(
      'Onboard',
      name: 'onBoard',
      desc: '',
      args: [],
    );
  }

  /// `Please finish the following details to have the full function of the app.`
  String get pleaseFinishTheFollowing {
    return Intl.message(
      'Please finish the following details to have the full function of the app.',
      name: 'pleaseFinishTheFollowing',
      desc: '',
      args: [],
    );
  }

  /// `My Profile`
  String get myProfile {
    return Intl.message(
      'My Profile',
      name: 'myProfile',
      desc: '',
      args: [],
    );
  }

  /// `Self Assessment Questionnaire`
  String get selfAssessmentQuestionnaire {
    return Intl.message(
      'Self Assessment Questionnaire',
      name: 'selfAssessmentQuestionnaire',
      desc: '',
      args: [],
    );
  }

  /// `Manage Business Partners`
  String get manageBusinessPartners {
    return Intl.message(
      'Manage Business Partners',
      name: 'manageBusinessPartners',
      desc: '',
      args: [],
    );
  }

  /// `Next`
  String get next {
    return Intl.message(
      'Next',
      name: 'next',
      desc: '',
      args: [],
    );
  }

  /// `Sorry, Your role is not currently supported.`
  String get notSupportBusiness {
    return Intl.message(
      'Sorry, Your role is not currently supported.',
      name: 'notSupportBusiness',
      desc: '',
      args: [],
    );
  }

  /// `First Name`
  String get firstName {
    return Intl.message(
      'First Name',
      name: 'firstName',
      desc: '',
      args: [],
    );
  }

  /// `Last Name`
  String get lastName {
    return Intl.message(
      'Last Name',
      name: 'lastName',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get name {
    return Intl.message(
      'Name',
      name: 'name',
      desc: '',
      args: [],
    );
  }

  /// `Business Registration Number`
  String get businessRegisterNumber {
    return Intl.message(
      'Business Registration Number',
      name: 'businessRegisterNumber',
      desc: '',
      args: [],
    );
  }

  /// `Business Registration Number (Optional)`
  String get businessRegisterNumberOptional {
    return Intl.message(
      'Business Registration Number (Optional)',
      name: 'businessRegisterNumberOptional',
      desc: '',
      args: [],
    );
  }

  /// `OS ID`
  String get osId {
    return Intl.message(
      'OS ID',
      name: 'osId',
      desc: '',
      args: [],
    );
  }

  /// `Address`
  String get address {
    return Intl.message(
      'Address',
      name: 'address',
      desc: '',
      args: [],
    );
  }

  /// `Certification`
  String get certification {
    return Intl.message(
      'Certification',
      name: 'certification',
      desc: '',
      args: [],
    );
  }

  /// `Chain of Custody`
  String get chainOfCustody {
    return Intl.message(
      'Chain of Custody',
      name: 'chainOfCustody',
      desc: '',
      args: [],
    );
  }

  /// `Reconciliation Window Start Date`
  String get reconciliationWindowStartDate {
    return Intl.message(
      'Reconciliation Window Start Date',
      name: 'reconciliationWindowStartDate',
      desc: '',
      args: [],
    );
  }

  /// `Reconciliation Window Duration`
  String get reconciliationWindowDuration {
    return Intl.message(
      'Reconciliation Window Duration',
      name: 'reconciliationWindowDuration',
      desc: '',
      args: [],
    );
  }

  /// `Edit`
  String get edit {
    return Intl.message(
      'Edit',
      name: 'edit',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get save {
    return Intl.message(
      'Save',
      name: 'save',
      desc: '',
      args: [],
    );
  }

  /// `Self Assessment Questionnaire`
  String get selfAssessment {
    return Intl.message(
      'Self Assessment Questionnaire',
      name: 'selfAssessment',
      desc: '',
      args: [],
    );
  }

  /// `Profile`
  String get profile {
    return Intl.message(
      'Profile',
      name: 'profile',
      desc: '',
      args: [],
    );
  }

  /// `Sign Out`
  String get signOut {
    return Intl.message(
      'Sign Out',
      name: 'signOut',
      desc: '',
      args: [],
    );
  }

  /// `Your email address or password is incorrect.`
  String get erEmailOrPasswordInvalid {
    return Intl.message(
      'Your email address or password is incorrect.',
      name: 'erEmailOrPasswordInvalid',
      desc: '',
      args: [],
    );
  }

  /// `Forgot Password`
  String get forgotPasswordTitle {
    return Intl.message(
      'Forgot Password',
      name: 'forgotPasswordTitle',
      desc: '',
      args: [],
    );
  }

  /// `Enter your email below to receive your password reset instructions`
  String get enterYourEmailBelow {
    return Intl.message(
      'Enter your email below to receive your password reset instructions',
      name: 'enterYourEmailBelow',
      desc: '',
      args: [],
    );
  }

  /// `Send`
  String get send {
    return Intl.message(
      'Send',
      name: 'send',
      desc: '',
      args: [],
    );
  }

  /// `Check your email`
  String get checkYourEmail {
    return Intl.message(
      'Check your email',
      name: 'checkYourEmail',
      desc: '',
      args: [],
    );
  }

  /// `If an account registered to this email exists, a password reset link will be sent to your inbox. The link is only valid for 15 minutes.`
  String get weSentYouAPassword {
    return Intl.message(
      'If an account registered to this email exists, a password reset link will be sent to your inbox. The link is only valid for 15 minutes.',
      name: 'weSentYouAPassword',
      desc: '',
      args: [],
    );
  }

  /// `Back to Login`
  String get backToLogin {
    return Intl.message(
      'Back to Login',
      name: 'backToLogin',
      desc: '',
      args: [],
    );
  }

  /// `You're all set`
  String get youAreAllSet {
    return Intl.message(
      'You\'re all set',
      name: 'youAreAllSet',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get logIn {
    return Intl.message(
      'Login',
      name: 'logIn',
      desc: '',
      args: [],
    );
  }

  /// `Your link has expired`
  String get yourLinkHasExpired {
    return Intl.message(
      'Your link has expired',
      name: 'yourLinkHasExpired',
      desc: '',
      args: [],
    );
  }

  /// `Your password reset link is only valid for 15 minutes.\nPlease return to the password reset page to request a new link`
  String get yourPasswordResetLinkIsOnlyVadid {
    return Intl.message(
      'Your password reset link is only valid for 15 minutes.\nPlease return to the password reset page to request a new link',
      name: 'yourPasswordResetLinkIsOnlyVadid',
      desc: '',
      args: [],
    );
  }

  /// `Reset Password`
  String get resetPassword {
    return Intl.message(
      'Reset Password',
      name: 'resetPassword',
      desc: '',
      args: [],
    );
  }

  /// `No`
  String get no {
    return Intl.message(
      'No',
      name: 'no',
      desc: '',
      args: [],
    );
  }

  /// `Upload Another`
  String get uploadAnother {
    return Intl.message(
      'Upload Another',
      name: 'uploadAnother',
      desc: '',
      args: [],
    );
  }

  /// `Remember your password? `
  String get rememberYourPassword {
    return Intl.message(
      'Remember your password? ',
      name: 'rememberYourPassword',
      desc: '',
      args: [],
    );
  }

  /// `Your email`
  String get yourEmail {
    return Intl.message(
      'Your email',
      name: 'yourEmail',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get email {
    return Intl.message(
      'Email',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `The Email does not exist.`
  String get thisEmailDoesNotExist {
    return Intl.message(
      'The Email does not exist.',
      name: 'thisEmailDoesNotExist',
      desc: '',
      args: [],
    );
  }

  /// `Create your new password`
  String get createYourNewPassword {
    return Intl.message(
      'Create your new password',
      name: 'createYourNewPassword',
      desc: '',
      args: [],
    );
  }

  /// `Your password has been successfully updated. You can use it to log in now.`
  String get yourPasswordHasUpdated {
    return Intl.message(
      'Your password has been successfully updated. You can use it to log in now.',
      name: 'yourPasswordHasUpdated',
      desc: '',
      args: [],
    );
  }

  /// `Something went wrong. Please try again later`
  String get genericErrorDescriptionShort {
    return Intl.message(
      'Something went wrong. Please try again later',
      name: 'genericErrorDescriptionShort',
      desc: '',
      args: [],
    );
  }

  /// `Farm`
  String get farm {
    return Intl.message(
      'Farm',
      name: 'farm',
      desc: '',
      args: [],
    );
  }

  /// `Farm Group`
  String get farmGroup {
    return Intl.message(
      'Farm Group',
      name: 'farmGroup',
      desc: '',
      args: [],
    );
  }

  /// `Broker`
  String get broker {
    return Intl.message(
      'Broker',
      name: 'broker',
      desc: '',
      args: [],
    );
  }

  /// `Transporter`
  String get transporter {
    return Intl.message(
      'Transporter',
      name: 'transporter',
      desc: '',
      args: [],
    );
  }

  /// `Add`
  String get add {
    return Intl.message(
      'Add',
      name: 'add',
      desc: '',
      args: [],
    );
  }

  /// `Contact`
  String get contact {
    return Intl.message(
      'Contact',
      name: 'contact',
      desc: '',
      args: [],
    );
  }

  /// `Information`
  String get information {
    return Intl.message(
      'Information',
      name: 'information',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get home {
    return Intl.message(
      'Home',
      name: 'home',
      desc: '',
      args: [],
    );
  }

  /// `Purchase`
  String get purchase {
    return Intl.message(
      'Purchase',
      name: 'purchase',
      desc: '',
      args: [],
    );
  }

  /// `Sell`
  String get sell {
    return Intl.message(
      'Sell',
      name: 'sell',
      desc: '',
      args: [],
    );
  }

  /// `Transport`
  String get transport {
    return Intl.message(
      'Transport',
      name: 'transport',
      desc: '',
      args: [],
    );
  }

  /// `Requests for Information`
  String get requestsForInformation {
    return Intl.message(
      'Requests for Information',
      name: 'requestsForInformation',
      desc: '',
      args: [],
    );
  }

  /// `Community Risk Scan`
  String get communityRiskScan {
    return Intl.message(
      'Community Risk Scan',
      name: 'communityRiskScan',
      desc: '',
      args: [],
    );
  }

  /// `{step} of {totalStep}`
  String stepOfStep(Object step, Object totalStep) {
    return Intl.message(
      '$step of $totalStep',
      name: 'stepOfStep',
      desc: '',
      args: [step, totalStep],
    );
  }

  /// `View All`
  String get viewAll {
    return Intl.message(
      'View All',
      name: 'viewAll',
      desc: '',
      args: [],
    );
  }

  /// `Latest Trade:`
  String get latestTrade {
    return Intl.message(
      'Latest Trade:',
      name: 'latestTrade',
      desc: '',
      args: [],
    );
  }

  /// `Back`
  String get back {
    return Intl.message(
      'Back',
      name: 'back',
      desc: '',
      args: [],
    );
  }

  /// `Update personal details, self assessment questionnaire responses and business partners here.`
  String get tutorialUpdatePersonalDetail {
    return Intl.message(
      'Update personal details, self assessment questionnaire responses and business partners here.',
      name: 'tutorialUpdatePersonalDetail',
      desc: '',
      args: [],
    );
  }

  /// `Record product purchases here`
  String get tutorialRecordPurchases {
    return Intl.message(
      'Record product purchases here',
      name: 'tutorialRecordPurchases',
      desc: '',
      args: [],
    );
  }

  /// `Record product transformation here`
  String get tutorialRecordLotId {
    return Intl.message(
      'Record product transformation here',
      name: 'tutorialRecordLotId',
      desc: '',
      args: [],
    );
  }

  /// `Record by-product here`
  String get tutorialRecordByProduct {
    return Intl.message(
      'Record by-product here',
      name: 'tutorialRecordByProduct',
      desc: '',
      args: [],
    );
  }

  /// `Record Sale of products here`
  String get tutorialSales {
    return Intl.message(
      'Record Sale of products here',
      name: 'tutorialSales',
      desc: '',
      args: [],
    );
  }

  /// `Record transportation here`
  String get tutorialTransportation {
    return Intl.message(
      'Record transportation here',
      name: 'tutorialTransportation',
      desc: '',
      args: [],
    );
  }

  /// `View a list of requests for information that have been assigned to you.`
  String get tutorialRequestInfor {
    return Intl.message(
      'View a list of requests for information that have been assigned to you.',
      name: 'tutorialRequestInfor',
      desc: '',
      args: [],
    );
  }

  /// `Submit a community risk scan here.`
  String get tutorialSubmitCommunity {
    return Intl.message(
      'Submit a community risk scan here.',
      name: 'tutorialSubmitCommunity',
      desc: '',
      args: [],
    );
  }

  /// `Token is invalid or expired`
  String get inviteTokenInvalid {
    return Intl.message(
      'Token is invalid or expired',
      name: 'inviteTokenInvalid',
      desc: '',
      args: [],
    );
  }

  /// `Your account has been successfully created. You can use it to log in now.`
  String get yourAccountSuccessfullyCreated {
    return Intl.message(
      'Your account has been successfully created. You can use it to log in now.',
      name: 'yourAccountSuccessfullyCreated',
      desc: '',
      args: [],
    );
  }

  /// `Finish creating an account`
  String get finishCreatingAccount {
    return Intl.message(
      'Finish creating an account',
      name: 'finishCreatingAccount',
      desc: '',
      args: [],
    );
  }

  /// ` from `
  String get tradeFromLabel {
    return Intl.message(
      ' from ',
      name: 'tradeFromLabel',
      desc: '',
      args: [],
    );
  }

  /// ` to `
  String get tradeToLabel {
    return Intl.message(
      ' to ',
      name: 'tradeToLabel',
      desc: '',
      args: [],
    );
  }

  /// `Last update: {time}`
  String lasUpdateTime(Object time) {
    return Intl.message(
      'Last update: $time',
      name: 'lasUpdateTime',
      desc: '',
      args: [time],
    );
  }

  /// `Filters`
  String get filters {
    return Intl.message(
      'Filters',
      name: 'filters',
      desc: '',
      args: [],
    );
  }

  /// `Grade`
  String get grade {
    return Intl.message(
      'Grade',
      name: 'grade',
      desc: '',
      args: [],
    );
  }

  /// `Purchaser`
  String get purchaser {
    return Intl.message(
      'Purchaser',
      name: 'purchaser',
      desc: '',
      args: [],
    );
  }

  /// `Seller`
  String get seller {
    return Intl.message(
      'Seller',
      name: 'seller',
      desc: '',
      args: [],
    );
  }

  /// `Apply`
  String get apply {
    return Intl.message(
      'Apply',
      name: 'apply',
      desc: '',
      args: [],
    );
  }

  /// `Date Range`
  String get dateRange {
    return Intl.message(
      'Date Range',
      name: 'dateRange',
      desc: '',
      args: [],
    );
  }

  /// `Manage Partners`
  String get managePartners {
    return Intl.message(
      'Manage Partners',
      name: 'managePartners',
      desc: '',
      args: [],
    );
  }

  /// `Trash Content`
  String get trashContent {
    return Intl.message(
      'Trash Content',
      name: 'trashContent',
      desc: '',
      args: [],
    );
  }

  /// `Moisture Level (Percentage)`
  String get moistureLevel {
    return Intl.message(
      'Moisture Level (Percentage)',
      name: 'moistureLevel',
      desc: '',
      args: [],
    );
  }

  /// `Cotton Certification`
  String get cottonCertification {
    return Intl.message(
      'Cotton Certification',
      name: 'cottonCertification',
      desc: '',
      args: [],
    );
  }

  /// `Total Weight`
  String get totalWeight {
    return Intl.message(
      'Total Weight',
      name: 'totalWeight',
      desc: '',
      args: [],
    );
  }

  /// `Unit`
  String get unit {
    return Intl.message(
      'Unit',
      name: 'unit',
      desc: '',
      args: [],
    );
  }

  /// `Price`
  String get price {
    return Intl.message(
      'Price',
      name: 'price',
      desc: '',
      args: [],
    );
  }

  /// `Currency`
  String get currency {
    return Intl.message(
      'Currency',
      name: 'currency',
      desc: '',
      args: [],
    );
  }

  /// `Purchase Order Number`
  String get purchaseOrderNumber {
    return Intl.message(
      'Purchase Order Number',
      name: 'purchaseOrderNumber',
      desc: '',
      args: [],
    );
  }

  /// `Date/time`
  String get dateAndTime {
    return Intl.message(
      'Date/time',
      name: 'dateAndTime',
      desc: '',
      args: [],
    );
  }

  /// `First Name cannot empty`
  String get firstNameLength {
    return Intl.message(
      'First Name cannot empty',
      name: 'firstNameLength',
      desc: '',
      args: [],
    );
  }

  /// `Last Name cannot empty`
  String get lastNameLength {
    return Intl.message(
      'Last Name cannot empty',
      name: 'lastNameLength',
      desc: '',
      args: [],
    );
  }

  /// `Name cannot empty`
  String get nameLength {
    return Intl.message(
      'Name cannot empty',
      name: 'nameLength',
      desc: '',
      args: [],
    );
  }

  /// `Email cannot empty`
  String get emailLength {
    return Intl.message(
      'Email cannot empty',
      name: 'emailLength',
      desc: '',
      args: [],
    );
  }

  /// `Business Name cannot empty`
  String get bussinessNameLength {
    return Intl.message(
      'Business Name cannot empty',
      name: 'bussinessNameLength',
      desc: '',
      args: [],
    );
  }

  /// `OS ID cannot empty`
  String get osIdLength {
    return Intl.message(
      'OS ID cannot empty',
      name: 'osIdLength',
      desc: '',
      args: [],
    );
  }

  /// `Didn't have one?`
  String get haventOsId {
    return Intl.message(
      'Didn\'t have one?',
      name: 'haventOsId',
      desc: '',
      args: [],
    );
  }

  /// ` Click here to create.`
  String get clickHere {
    return Intl.message(
      ' Click here to create.',
      name: 'clickHere',
      desc: '',
      args: [],
    );
  }

  /// `Country`
  String get country {
    return Intl.message(
      'Country',
      name: 'country',
      desc: '',
      args: [],
    );
  }

  /// `Province/State`
  String get provinceState {
    return Intl.message(
      'Province/State',
      name: 'provinceState',
      desc: '',
      args: [],
    );
  }

  /// `District`
  String get district {
    return Intl.message(
      'District',
      name: 'district',
      desc: '',
      args: [],
    );
  }

  /// `Street Address`
  String get streetAddress {
    return Intl.message(
      'Street Address',
      name: 'streetAddress',
      desc: '',
      args: [],
    );
  }

  /// `Street Address (Optional)`
  String get streetAddressOptional {
    return Intl.message(
      'Street Address (Optional)',
      name: 'streetAddressOptional',
      desc: '',
      args: [],
    );
  }

  /// `Certification And Custody Model`
  String get certificationAndCustodyModel {
    return Intl.message(
      'Certification And Custody Model',
      name: 'certificationAndCustodyModel',
      desc: '',
      args: [],
    );
  }

  /// `Business registration number cannot empty`
  String get businessSpecial {
    return Intl.message(
      'Business registration number cannot empty',
      name: 'businessSpecial',
      desc: '',
      args: [],
    );
  }

  /// `Phone (including country code) (Optional)`
  String get phoneInput {
    return Intl.message(
      'Phone (including country code) (Optional)',
      name: 'phoneInput',
      desc: '',
      args: [],
    );
  }

  /// `Register OS ID`
  String get registerOsID {
    return Intl.message(
      'Register OS ID',
      name: 'registerOsID',
      desc: '',
      args: [],
    );
  }

  /// `Request OS ID`
  String get requestOsID {
    return Intl.message(
      'Request OS ID',
      name: 'requestOsID',
      desc: '',
      args: [],
    );
  }

  /// `Business Information`
  String get businessInformation {
    return Intl.message(
      'Business Information',
      name: 'businessInformation',
      desc: '',
      args: [],
    );
  }

  /// `Business Name`
  String get businessName {
    return Intl.message(
      'Business Name',
      name: 'businessName',
      desc: '',
      args: [],
    );
  }

  /// `Total weight invalid`
  String get totalWeightInvalid {
    return Intl.message(
      'Total weight invalid',
      name: 'totalWeightInvalid',
      desc: '',
      args: [],
    );
  }

  /// `Price invalid`
  String get priceInvalid {
    return Intl.message(
      'Price invalid',
      name: 'priceInvalid',
      desc: '',
      args: [],
    );
  }

  /// `Add Business Partner Information`
  String get addBusinessPartnerInformation {
    return Intl.message(
      'Add Business Partner Information',
      name: 'addBusinessPartnerInformation',
      desc: '',
      args: [],
    );
  }

  /// `Add Business Partner`
  String get addBusinessPartner {
    return Intl.message(
      'Add Business Partner',
      name: 'addBusinessPartner',
      desc: '',
      args: [],
    );
  }

  /// `Farm Name`
  String get farmName {
    return Intl.message(
      'Farm Name',
      name: 'farmName',
      desc: '',
      args: [],
    );
  }

  /// `Spinner Name (OS ID, Business Registration Number)`
  String get spinnerName {
    return Intl.message(
      'Spinner Name (OS ID, Business Registration Number)',
      name: 'spinnerName',
      desc: '',
      args: [],
    );
  }

  /// `Broker Name (Business Registration Number)`
  String get brokerName {
    return Intl.message(
      'Broker Name (Business Registration Number)',
      name: 'brokerName',
      desc: '',
      args: [],
    );
  }

  /// `Transporter Name (Business Registration Number)`
  String get transporterName {
    return Intl.message(
      'Transporter Name (Business Registration Number)',
      name: 'transporterName',
      desc: '',
      args: [],
    );
  }

  /// `Upload Packing List`
  String get uploadPackingList {
    return Intl.message(
      'Upload Packing List',
      name: 'uploadPackingList',
      desc: '',
      args: [],
    );
  }

  /// `Total Price`
  String get totalPrice {
    return Intl.message(
      'Total Price',
      name: 'totalPrice',
      desc: '',
      args: [],
    );
  }

  /// `Invoice Number`
  String get invoiceNumber {
    return Intl.message(
      'Invoice Number',
      name: 'invoiceNumber',
      desc: '',
      args: [],
    );
  }

  /// `Upload Invoice`
  String get uploadInvoice {
    return Intl.message(
      'Upload Invoice',
      name: 'uploadInvoice',
      desc: '',
      args: [],
    );
  }

  /// `Added Time`
  String get addedTime {
    return Intl.message(
      'Added Time',
      name: 'addedTime',
      desc: '',
      args: [],
    );
  }

  /// `Quality`
  String get quality {
    return Intl.message(
      'Quality',
      name: 'quality',
      desc: '',
      args: [],
    );
  }

  /// `Download Certification`
  String get downloadCertification {
    return Intl.message(
      'Download Certification',
      name: 'downloadCertification',
      desc: '',
      args: [],
    );
  }

  /// `Unable to access camera!`
  String get unableToAccessCamera {
    return Intl.message(
      'Unable to access camera!',
      name: 'unableToAccessCamera',
      desc: '',
      args: [],
    );
  }

  /// `This app needs camera access to scan QR codes`
  String get noCameraPermissionDesctiption {
    return Intl.message(
      'This app needs camera access to scan QR codes',
      name: 'noCameraPermissionDesctiption',
      desc: '',
      args: [],
    );
  }

  /// `Camera access denied. Let open the app setting to enable it!`
  String get cameraAccessDenied {
    return Intl.message(
      'Camera access denied. Let open the app setting to enable it!',
      name: 'cameraAccessDenied',
      desc: '',
      args: [],
    );
  }

  /// `Data Saved!`
  String get dataSaved {
    return Intl.message(
      'Data Saved!',
      name: 'dataSaved',
      desc: '',
      args: [],
    );
  }

  /// `DNA identifier`
  String get dnaId {
    return Intl.message(
      'DNA identifier',
      name: 'dnaId',
      desc: '',
      args: [],
    );
  }

  /// `DNA identifier (Optional)`
  String get dnaIdOptinal {
    return Intl.message(
      'DNA identifier (Optional)',
      name: 'dnaIdOptinal',
      desc: '',
      args: [],
    );
  }

  /// `Upload Certificate`
  String get uploadCertification {
    return Intl.message(
      'Upload Certificate',
      name: 'uploadCertification',
      desc: '',
      args: [],
    );
  }

  /// `Packing List Number`
  String get packingListNumber {
    return Intl.message(
      'Packing List Number',
      name: 'packingListNumber',
      desc: '',
      args: [],
    );
  }

  /// `Upload Transportation Log/Packing List`
  String get uploadTransportationLog {
    return Intl.message(
      'Upload Transportation Log/Packing List',
      name: 'uploadTransportationLog',
      desc: '',
      args: [],
    );
  }

  /// `{field} Added!`
  String addSuccess(Object field) {
    return Intl.message(
      '$field Added!',
      name: 'addSuccess',
      desc: '',
      args: [field],
    );
  }

  /// `Verified`
  String get verified {
    return Intl.message(
      'Verified',
      name: 'verified',
      desc: '',
      args: [],
    );
  }

  /// `Not Verified`
  String get notVerified {
    return Intl.message(
      'Not Verified',
      name: 'notVerified',
      desc: '',
      args: [],
    );
  }

  /// `Verified: {tracedValue} of {total}`
  String verifiedSumup(Object tracedValue, Object total) {
    return Intl.message(
      'Verified: $tracedValue of $total',
      name: 'verifiedSumup',
      desc: '',
      args: [tracedValue, total],
    );
  }

  /// `Reset`
  String get reset {
    return Intl.message(
      'Reset',
      name: 'reset',
      desc: '',
      args: [],
    );
  }

  /// `Moisture Level must not be greater than 100`
  String get moistureLevelMustNotGreater {
    return Intl.message(
      'Moisture Level must not be greater than 100',
      name: 'moistureLevelMustNotGreater',
      desc: '',
      args: [],
    );
  }

  /// `Moisture Level must be greater than 0`
  String get moistureLevelMustGreater {
    return Intl.message(
      'Moisture Level must be greater than 0',
      name: 'moistureLevelMustGreater',
      desc: '',
      args: [],
    );
  }

  /// `Current Password`
  String get currentPassword {
    return Intl.message(
      'Current Password',
      name: 'currentPassword',
      desc: '',
      args: [],
    );
  }

  /// `Current password`
  String get currentPasswordLower {
    return Intl.message(
      'Current password',
      name: 'currentPasswordLower',
      desc: '',
      args: [],
    );
  }

  /// `New password`
  String get newPasswordLower {
    return Intl.message(
      'New password',
      name: 'newPasswordLower',
      desc: '',
      args: [],
    );
  }

  /// `Confirm password`
  String get confirmPasswordLower {
    return Intl.message(
      'Confirm password',
      name: 'confirmPasswordLower',
      desc: '',
      args: [],
    );
  }

  /// `Confirm password does not match with new password`
  String get confirmPasswordNotMatch {
    return Intl.message(
      'Confirm password does not match with new password',
      name: 'confirmPasswordNotMatch',
      desc: '',
      args: [],
    );
  }

  /// `⦁⦁⦁⦁⦁⦁⦁⦁⦁⦁`
  String get dot {
    return Intl.message(
      '⦁⦁⦁⦁⦁⦁⦁⦁⦁⦁',
      name: 'dot',
      desc: '',
      args: [],
    );
  }

  /// `Cycle`
  String get cycle {
    return Intl.message(
      'Cycle',
      name: 'cycle',
      desc: '',
      args: [],
    );
  }

  /// `Add Partner`
  String get addPartner {
    return Intl.message(
      'Add Partner',
      name: 'addPartner',
      desc: '',
      args: [],
    );
  }

  /// `Partner Name (Business Registration Number)`
  String get partnerHintTest {
    return Intl.message(
      'Partner Name (Business Registration Number)',
      name: 'partnerHintTest',
      desc: '',
      args: [],
    );
  }

  /// `Not me. `
  String get notMe {
    return Intl.message(
      'Not me. ',
      name: 'notMe',
      desc: '',
      args: [],
    );
  }

  /// `Please register using details supplied above !`
  String get notMePleaseRegisterOsIdAbove {
    return Intl.message(
      'Please register using details supplied above !',
      name: 'notMePleaseRegisterOsIdAbove',
      desc: '',
      args: [],
    );
  }

  /// `Please enter the new information to register new OS ID !`
  String get notMePleaseEnterNewOsId {
    return Intl.message(
      'Please enter the new information to register new OS ID !',
      name: 'notMePleaseEnterNewOsId',
      desc: '',
      args: [],
    );
  }

  /// `OS ID registered!`
  String get osIdRegistered {
    return Intl.message(
      'OS ID registered!',
      name: 'osIdRegistered',
      desc: '',
      args: [],
    );
  }

  /// `History`
  String get history {
    return Intl.message(
      'History',
      name: 'history',
      desc: '',
      args: [],
    );
  }

  /// `Pull up load`
  String get pullUpLoad {
    return Intl.message(
      'Pull up load',
      name: 'pullUpLoad',
      desc: '',
      args: [],
    );
  }

  /// `Load Failed! Click retry!`
  String get loadFailedClick {
    return Intl.message(
      'Load Failed! Click retry!',
      name: 'loadFailedClick',
      desc: '',
      args: [],
    );
  }

  /// `Release to load more`
  String get releaseToLoad {
    return Intl.message(
      'Release to load more',
      name: 'releaseToLoad',
      desc: '',
      args: [],
    );
  }

  /// `No more Data`
  String get noMoreData {
    return Intl.message(
      'No more Data',
      name: 'noMoreData',
      desc: '',
      args: [],
    );
  }

  /// `Have no file for download`
  String get haveNoFileForDownload {
    return Intl.message(
      'Have no file for download',
      name: 'haveNoFileForDownload',
      desc: '',
      args: [],
    );
  }

  /// `Unable to access storage!`
  String get unableToAccessStorage {
    return Intl.message(
      'Unable to access storage!',
      name: 'unableToAccessStorage',
      desc: '',
      args: [],
    );
  }

  /// `This app needs storage access to save files`
  String get noStoragePermissionDesctiption {
    return Intl.message(
      'This app needs storage access to save files',
      name: 'noStoragePermissionDesctiption',
      desc: '',
      args: [],
    );
  }

  /// `Storage access denied. Let open the app setting to enable it!`
  String get storageAccessDenied {
    return Intl.message(
      'Storage access denied. Let open the app setting to enable it!',
      name: 'storageAccessDenied',
      desc: '',
      args: [],
    );
  }

  /// `Pick file using?`
  String get pickeFileUsing {
    return Intl.message(
      'Pick file using?',
      name: 'pickeFileUsing',
      desc: '',
      args: [],
    );
  }

  /// `Take Photo`
  String get takePhoto {
    return Intl.message(
      'Take Photo',
      name: 'takePhoto',
      desc: '',
      args: [],
    );
  }

  /// `Choose from Gallery`
  String get chooseFromGallery {
    return Intl.message(
      'Choose from Gallery',
      name: 'chooseFromGallery',
      desc: '',
      args: [],
    );
  }

  /// `Choose file from Directory`
  String get chooseFromFileDirectory {
    return Intl.message(
      'Choose file from Directory',
      name: 'chooseFromFileDirectory',
      desc: '',
      args: [],
    );
  }

  /// `Assign Lot ID`
  String get assignLotId {
    return Intl.message(
      'Assign Lot ID',
      name: 'assignLotId',
      desc: '',
      args: [],
    );
  }

  /// `Response Submitted!`
  String get responseSubmitted {
    return Intl.message(
      'Response Submitted!',
      name: 'responseSubmitted',
      desc: '',
      args: [],
    );
  }

  /// `Location`
  String get location {
    return Intl.message(
      'Location',
      name: 'location',
      desc: '',
      args: [],
    );
  }

  /// `Indicators`
  String get indicators {
    return Intl.message(
      'Indicators',
      name: 'indicators',
      desc: '',
      args: [],
    );
  }

  /// `Severity`
  String get severity {
    return Intl.message(
      'Severity',
      name: 'severity',
      desc: '',
      args: [],
    );
  }

  /// `Upload File`
  String get uploadFile {
    return Intl.message(
      'Upload File',
      name: 'uploadFile',
      desc: '',
      args: [],
    );
  }

  /// `Submit`
  String get submit {
    return Intl.message(
      'Submit',
      name: 'submit',
      desc: '',
      args: [],
    );
  }

  /// `Notes`
  String get notes {
    return Intl.message(
      'Notes',
      name: 'notes',
      desc: '',
      args: [],
    );
  }

  /// `Respond to request`
  String get respondToRequest {
    return Intl.message(
      'Respond to request',
      name: 'respondToRequest',
      desc: '',
      args: [],
    );
  }

  /// `Submission`
  String get submission {
    return Intl.message(
      'Submission',
      name: 'submission',
      desc: '',
      args: [],
    );
  }

  /// `Source`
  String get source {
    return Intl.message(
      'Source',
      name: 'source',
      desc: '',
      args: [],
    );
  }

  /// `Message from requestor`
  String get messageFromRequestor {
    return Intl.message(
      'Message from requestor',
      name: 'messageFromRequestor',
      desc: '',
      args: [],
    );
  }

  /// `No results found`
  String get noResultFound {
    return Intl.message(
      'No results found',
      name: 'noResultFound',
      desc: '',
      args: [],
    );
  }

  /// `Responded`
  String get responded {
    return Intl.message(
      'Responded',
      name: 'responded',
      desc: '',
      args: [],
    );
  }

  /// `No internet connection!`
  String get noInternetConnection {
    return Intl.message(
      'No internet connection!',
      name: 'noInternetConnection',
      desc: '',
      args: [],
    );
  }

  /// `Reg No: `
  String get businessRegisterPrefix {
    return Intl.message(
      'Reg No: ',
      name: 'businessRegisterPrefix',
      desc: '',
      args: [],
    );
  }

  /// `OS ID: `
  String get osIdPrefix {
    return Intl.message(
      'OS ID: ',
      name: 'osIdPrefix',
      desc: '',
      args: [],
    );
  }

  /// `No internet connection available. The data will be submitted automatically when network is available`
  String get noInternetSubmitData {
    return Intl.message(
      'No internet connection available. The data will be submitted automatically when network is available',
      name: 'noInternetSubmitData',
      desc: '',
      args: [],
    );
  }

  /// `File upload must be smaller than 10 Mb`
  String get fileTooLarge {
    return Intl.message(
      'File upload must be smaller than 10 Mb',
      name: 'fileTooLarge',
      desc: '',
      args: [],
    );
  }

  /// `Completed`
  String get completed {
    return Intl.message(
      'Completed',
      name: 'completed',
      desc: '',
      args: [],
    );
  }

  /// `Pending`
  String get pending {
    return Intl.message(
      'Pending',
      name: 'pending',
      desc: '',
      args: [],
    );
  }

  /// `Failed`
  String get failed {
    return Intl.message(
      'Failed',
      name: 'failed',
      desc: '',
      args: [],
    );
  }

  /// `Total seed cotton purchased`
  String get totalSeedCottonPurchased {
    return Intl.message(
      'Total seed cotton purchased',
      name: 'totalSeedCottonPurchased',
      desc: '',
      args: [],
    );
  }

  /// `Estimated lint cotton conversion`
  String get estimatedLintCottonConversion {
    return Intl.message(
      'Estimated lint cotton conversion',
      name: 'estimatedLintCottonConversion',
      desc: '',
      args: [],
    );
  }

  /// `Estimation based on {present}% conversion rate.`
  String estimatedBasedOnPersent(Object present) {
    return Intl.message(
      'Estimation based on $present% conversion rate.',
      name: 'estimatedBasedOnPersent',
      desc: '',
      args: [present],
    );
  }

  /// `Total Weight must not be less than {totalWeight}`
  String theWeightTransportMustBeLeast(Object totalWeight) {
    return Intl.message(
      'Total Weight must not be less than $totalWeight',
      name: 'theWeightTransportMustBeLeast',
      desc: '',
      args: [totalWeight],
    );
  }

  /// `Make an account here..`
  String get makeAnAccountHere {
    return Intl.message(
      'Make an account here..',
      name: 'makeAnAccountHere',
      desc: '',
      args: [],
    );
  }

  /// `Organization Details`
  String get organizationDetail {
    return Intl.message(
      'Organization Details',
      name: 'organizationDetail',
      desc: '',
      args: [],
    );
  }

  /// `Partner Type`
  String get partnerType {
    return Intl.message(
      'Partner Type',
      name: 'partnerType',
      desc: '',
      args: [],
    );
  }

  /// `Facility Name`
  String get facilityName {
    return Intl.message(
      'Facility Name',
      name: 'facilityName',
      desc: '',
      args: [],
    );
  }

  /// `Update your profile here.`
  String get updateYourProfileHere {
    return Intl.message(
      'Update your profile here.',
      name: 'updateYourProfileHere',
      desc: '',
      args: [],
    );
  }

  /// `Unable to access Location!`
  String get unableToAccessLocation {
    return Intl.message(
      'Unable to access Location!',
      name: 'unableToAccessLocation',
      desc: '',
      args: [],
    );
  }

  /// `This app needs Location access to get coordinate`
  String get noLocationPermissionDesctiption {
    return Intl.message(
      'This app needs Location access to get coordinate',
      name: 'noLocationPermissionDesctiption',
      desc: '',
      args: [],
    );
  }

  /// `Location access denied. Let open the app setting to enable it!`
  String get locationAccessDenied {
    return Intl.message(
      'Location access denied. Let open the app setting to enable it!',
      name: 'locationAccessDenied',
      desc: '',
      args: [],
    );
  }

  /// `Submit Further Information`
  String get submitFurtherInformation {
    return Intl.message(
      'Submit Further Information',
      name: 'submitFurtherInformation',
      desc: '',
      args: [],
    );
  }

  /// `No transactions.`
  String get noTransactionsMessage {
    return Intl.message(
      'No transactions.',
      name: 'noTransactionsMessage',
      desc: '',
      args: [],
    );
  }

  /// `File & attachment`
  String get fileAndAttachment {
    return Intl.message(
      'File & attachment',
      name: 'fileAndAttachment',
      desc: '',
      args: [],
    );
  }

  /// `Facility`
  String get facility {
    return Intl.message(
      'Facility',
      name: 'facility',
      desc: '',
      args: [],
    );
  }

  /// `Message must be shorter than or equal to 255 characters`
  String get notesMustShorterThan {
    return Intl.message(
      'Message must be shorter than or equal to 255 characters',
      name: 'notesMustShorterThan',
      desc: '',
      args: [],
    );
  }

  /// `No requests for information!`
  String get noRequestInformation {
    return Intl.message(
      'No requests for information!',
      name: 'noRequestInformation',
      desc: '',
      args: [],
    );
  }

  /// `New password must be different from current password`
  String get newPasswordMustBeDifferent {
    return Intl.message(
      'New password must be different from current password',
      name: 'newPasswordMustBeDifferent',
      desc: '',
      args: [],
    );
  }

  /// `Child partner has exits`
  String get childPartnerHadExits {
    return Intl.message(
      'Child partner has exits',
      name: 'childPartnerHadExits',
      desc: '',
      args: [],
    );
  }

  /// `Your profile has been successfully updated`
  String get profileSuccessfully {
    return Intl.message(
      'Your profile has been successfully updated',
      name: 'profileSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Partner has been removed!`
  String get partnerHasBeenRemoved {
    return Intl.message(
      'Partner has been removed!',
      name: 'partnerHasBeenRemoved',
      desc: '',
      args: [],
    );
  }

  /// `Add Another`
  String get addAnother {
    return Intl.message(
      'Add Another',
      name: 'addAnother',
      desc: '',
      args: [],
    );
  }

  /// `Use my current location`
  String get useMyCurrentLocation {
    return Intl.message(
      'Use my current location',
      name: 'useMyCurrentLocation',
      desc: '',
      args: [],
    );
  }

  /// `OS ID does not exist.`
  String get osIdDoesNotExist {
    return Intl.message(
      'OS ID does not exist.',
      name: 'osIdDoesNotExist',
      desc: '',
      args: [],
    );
  }

  /// `Upload Proof`
  String get uploadProof {
    return Intl.message(
      'Upload Proof',
      name: 'uploadProof',
      desc: '',
      args: [],
    );
  }

  /// `Unable to connect to server. Please try again later.`
  String get unableToConnectToServer {
    return Intl.message(
      'Unable to connect to server. Please try again later.',
      name: 'unableToConnectToServer',
      desc: '',
      args: [],
    );
  }

  /// `There was an error while detect location. Please try again later`
  String get detectLocationFail {
    return Intl.message(
      'There was an error while detect location. Please try again later',
      name: 'detectLocationFail',
      desc: '',
      args: [],
    );
  }

  /// `Location Services is off!!`
  String get locationIsOff {
    return Intl.message(
      'Location Services is off!!',
      name: 'locationIsOff',
      desc: '',
      args: [],
    );
  }

  /// `The location services had been turned off. Please, turn on the location services and try again!`
  String get turnOnLocation {
    return Intl.message(
      'The location services had been turned off. Please, turn on the location services and try again!',
      name: 'turnOnLocation',
      desc: '',
      args: [],
    );
  }

  /// `Percent must not be greater than 100`
  String get percentMustNotBe {
    return Intl.message(
      'Percent must not be greater than 100',
      name: 'percentMustNotBe',
      desc: '',
      args: [],
    );
  }

  /// `Percent must be greater than 0`
  String get percentMust {
    return Intl.message(
      'Percent must be greater than 0',
      name: 'percentMust',
      desc: '',
      args: [],
    );
  }

  /// `SAQ has been completed successfully`
  String get saqSuccessfullyCompleted {
    return Intl.message(
      'SAQ has been completed successfully',
      name: 'saqSuccessfullyCompleted',
      desc: '',
      args: [],
    );
  }

  /// `Business Information is invalid!`
  String get bussinessInformationInValid {
    return Intl.message(
      'Business Information is invalid!',
      name: 'bussinessInformationInValid',
      desc: '',
      args: [],
    );
  }

  /// `Cotton Certification (Optional)`
  String get cottonCertificationOptional {
    return Intl.message(
      'Cotton Certification (Optional)',
      name: 'cottonCertificationOptional',
      desc: '',
      args: [],
    );
  }

  /// `Grade (Optional)`
  String get gradeOptional {
    return Intl.message(
      'Grade (Optional)',
      name: 'gradeOptional',
      desc: '',
      args: [],
    );
  }

  /// `Total Price (Optional)`
  String get totalPriceOptional {
    return Intl.message(
      'Total Price (Optional)',
      name: 'totalPriceOptional',
      desc: '',
      args: [],
    );
  }

  /// `Price (Optional)`
  String get priceOptional {
    return Intl.message(
      'Price (Optional)',
      name: 'priceOptional',
      desc: '',
      args: [],
    );
  }

  /// `Your SAQ current progress has been saved`
  String get yourSAQCurrentProgressSaved {
    return Intl.message(
      'Your SAQ current progress has been saved',
      name: 'yourSAQCurrentProgressSaved',
      desc: '',
      args: [],
    );
  }

  /// `The following questions are incomplete`
  String get theFllowingQuestionIncomplete {
    return Intl.message(
      'The following questions are incomplete',
      name: 'theFllowingQuestionIncomplete',
      desc: '',
      args: [],
    );
  }

  /// `Question`
  String get question {
    return Intl.message(
      'Question',
      name: 'question',
      desc: '',
      args: [],
    );
  }

  /// `Okay`
  String get okay {
    return Intl.message(
      'Okay',
      name: 'okay',
      desc: '',
      args: [],
    );
  }

  /// `Continue Self Assessment Questionnaire`
  String get continueSAQ {
    return Intl.message(
      'Continue Self Assessment Questionnaire',
      name: 'continueSAQ',
      desc: '',
      args: [],
    );
  }

  /// `Start New Self Assessment Questionnaire`
  String get viewSAQ {
    return Intl.message(
      'Start New Self Assessment Questionnaire',
      name: 'viewSAQ',
      desc: '',
      args: [],
    );
  }

  /// `Numeric invalid`
  String get numericInvalid {
    return Intl.message(
      'Numeric invalid',
      name: 'numericInvalid',
      desc: '',
      args: [],
    );
  }

  /// `File already exists!`
  String get fileAlreadyExists {
    return Intl.message(
      'File already exists!',
      name: 'fileAlreadyExists',
      desc: '',
      args: [],
    );
  }

  /// `Business name`
  String get businessNameLower {
    return Intl.message(
      'Business name',
      name: 'businessNameLower',
      desc: '',
      args: [],
    );
  }

  /// `New facility has been registered with supplied details.`
  String get newFacilityHasRegitered {
    return Intl.message(
      'New facility has been registered with supplied details.',
      name: 'newFacilityHasRegitered',
      desc: '',
      args: [],
    );
  }

  /// `Your password should be at least 8 characters and include all of the following - one letter, one capital letter, one number, one special character`
  String get passwordToolTips {
    return Intl.message(
      'Your password should be at least 8 characters and include all of the following - one letter, one capital letter, one number, one special character',
      name: 'passwordToolTips',
      desc: '',
      args: [],
    );
  }

  /// `High`
  String get highSevrity {
    return Intl.message(
      'High',
      name: 'highSevrity',
      desc: '',
      args: [],
    );
  }

  /// `Medium`
  String get mediumSevrity {
    return Intl.message(
      'Medium',
      name: 'mediumSevrity',
      desc: '',
      args: [],
    );
  }

  /// `Low`
  String get lowSevrity {
    return Intl.message(
      'Low',
      name: 'lowSevrity',
      desc: '',
      args: [],
    );
  }

  /// `Status`
  String get status {
    return Intl.message(
      'Status',
      name: 'status',
      desc: '',
      args: [],
    );
  }

  /// `Report priority`
  String get priority {
    return Intl.message(
      'Report priority',
      name: 'priority',
      desc: '',
      args: [],
    );
  }

  /// `Sub-Indicator`
  String get subIndicators {
    return Intl.message(
      'Sub-Indicator',
      name: 'subIndicators',
      desc: '',
      args: [],
    );
  }

  /// `{num} indicators added`
  String numIndicatorAdded(Object num) {
    return Intl.message(
      '$num indicators added',
      name: 'numIndicatorAdded',
      desc: '',
      args: [num],
    );
  }

  /// `1 indicator added`
  String get oneIndicatorAdded {
    return Intl.message(
      '1 indicator added',
      name: 'oneIndicatorAdded',
      desc: '',
      args: [],
    );
  }

  /// `(Optional)`
  String get optional {
    return Intl.message(
      '(Optional)',
      name: 'optional',
      desc: '',
      args: [],
    );
  }

  /// `Phone (including country code) `
  String get showPhone {
    return Intl.message(
      'Phone (including country code) ',
      name: 'showPhone',
      desc: '',
      args: [],
    );
  }

  /// `ABRAPA`
  String get abrapa {
    return Intl.message(
      'ABRAPA',
      name: 'abrapa',
      desc: '',
      args: [],
    );
  }

  /// `BASF e3`
  String get basfE3 {
    return Intl.message(
      'BASF e3',
      name: 'basfE3',
      desc: '',
      args: [],
    );
  }

  /// `Better Cotton Initiative (BCI)`
  String get betterCotton {
    return Intl.message(
      'Better Cotton Initiative (BCI)',
      name: 'betterCotton',
      desc: '',
      args: [],
    );
  }

  /// `Cleaner Cotton`
  String get cleanerCotton {
    return Intl.message(
      'Cleaner Cotton',
      name: 'cleanerCotton',
      desc: '',
      args: [],
    );
  }

  /// `Cotton made in Africa (CmiA)`
  String get cottonMadeInAfrica {
    return Intl.message(
      'Cotton made in Africa (CmiA)',
      name: 'cottonMadeInAfrica',
      desc: '',
      args: [],
    );
  }

  /// `Fairtrade`
  String get fairtrade {
    return Intl.message(
      'Fairtrade',
      name: 'fairtrade',
      desc: '',
      args: [],
    );
  }

  /// `Fairtrade Organic`
  String get fairtradeOrganic {
    return Intl.message(
      'Fairtrade Organic',
      name: 'fairtradeOrganic',
      desc: '',
      args: [],
    );
  }

  /// `Field to Market`
  String get fieldToMarket {
    return Intl.message(
      'Field to Market',
      name: 'fieldToMarket',
      desc: '',
      args: [],
    );
  }

  /// `ISCC`
  String get iscc {
    return Intl.message(
      'ISCC',
      name: 'iscc',
      desc: '',
      args: [],
    );
  }

  /// `myBMP`
  String get myBMP {
    return Intl.message(
      'myBMP',
      name: 'myBMP',
      desc: '',
      args: [],
    );
  }

  /// `Organic Cotton`
  String get organicCotton {
    return Intl.message(
      'Organic Cotton',
      name: 'organicCotton',
      desc: '',
      args: [],
    );
  }

  /// `Recycled Cotton`
  String get recycledCotton {
    return Intl.message(
      'Recycled Cotton',
      name: 'recycledCotton',
      desc: '',
      args: [],
    );
  }

  /// `REEL Cotton`
  String get reelCotton {
    return Intl.message(
      'REEL Cotton',
      name: 'reelCotton',
      desc: '',
      args: [],
    );
  }

  /// `Regenerative Cotton`
  String get regenerativeCotton {
    return Intl.message(
      'Regenerative Cotton',
      name: 'regenerativeCotton',
      desc: '',
      args: [],
    );
  }

  /// `Transitional Cotton`
  String get transitionalCotton {
    return Intl.message(
      'Transitional Cotton',
      name: 'transitionalCotton',
      desc: '',
      args: [],
    );
  }

  /// `United States Cotton Trust Protocol`
  String get usCotton {
    return Intl.message(
      'United States Cotton Trust Protocol',
      name: 'usCotton',
      desc: '',
      args: [],
    );
  }

  /// `Conventional Cotton`
  String get conventionalCotton {
    return Intl.message(
      'Conventional Cotton',
      name: 'conventionalCotton',
      desc: '',
      args: [],
    );
  }

  /// `Seed Cotton Super`
  String get seedCottonSuper {
    return Intl.message(
      'Seed Cotton Super',
      name: 'seedCottonSuper',
      desc: '',
      args: [],
    );
  }

  /// `Seed Cotton Grade 1`
  String get seedCottonGrade1 {
    return Intl.message(
      'Seed Cotton Grade 1',
      name: 'seedCottonGrade1',
      desc: '',
      args: [],
    );
  }

  /// `Seed Cotton Grade 2`
  String get seedCottonGrade2 {
    return Intl.message(
      'Seed Cotton Grade 2',
      name: 'seedCottonGrade2',
      desc: '',
      args: [],
    );
  }

  /// `Seed Cotton Grade 3`
  String get seedCottonGrade3 {
    return Intl.message(
      'Seed Cotton Grade 3',
      name: 'seedCottonGrade3',
      desc: '',
      args: [],
    );
  }

  /// `Seed Cotton Grade 4`
  String get seedCottonGrade4 {
    return Intl.message(
      'Seed Cotton Grade 4',
      name: 'seedCottonGrade4',
      desc: '',
      args: [],
    );
  }

  /// `Seed Cotton Grade 5`
  String get seedCottonGrade5 {
    return Intl.message(
      'Seed Cotton Grade 5',
      name: 'seedCottonGrade5',
      desc: '',
      args: [],
    );
  }

  /// `Lint Cotton Super`
  String get lintCottonSuper {
    return Intl.message(
      'Lint Cotton Super',
      name: 'lintCottonSuper',
      desc: '',
      args: [],
    );
  }

  /// `Lint Cotton Grade 1`
  String get lintCottonGrade1 {
    return Intl.message(
      'Lint Cotton Grade 1',
      name: 'lintCottonGrade1',
      desc: '',
      args: [],
    );
  }

  /// `Lint Cotton Grade 2`
  String get lintCottonGrade2 {
    return Intl.message(
      'Lint Cotton Grade 2',
      name: 'lintCottonGrade2',
      desc: '',
      args: [],
    );
  }

  /// `Lint Cotton Grade 3`
  String get lintCottonGrade3 {
    return Intl.message(
      'Lint Cotton Grade 3',
      name: 'lintCottonGrade3',
      desc: '',
      args: [],
    );
  }

  /// `Lint Cotton Grade 4`
  String get lintCottonGrade4 {
    return Intl.message(
      'Lint Cotton Grade 4',
      name: 'lintCottonGrade4',
      desc: '',
      args: [],
    );
  }

  /// `Lint Cotton Grade 5`
  String get lintCottonGrade5 {
    return Intl.message(
      'Lint Cotton Grade 5',
      name: 'lintCottonGrade5',
      desc: '',
      args: [],
    );
  }

  /// `Other`
  String get other {
    return Intl.message(
      'Other',
      name: 'other',
      desc: '',
      args: [],
    );
  }

  /// `KG`
  String get kg {
    return Intl.message(
      'KG',
      name: 'kg',
      desc: '',
      args: [],
    );
  }

  /// `LBS`
  String get lbs {
    return Intl.message(
      'LBS',
      name: 'lbs',
      desc: '',
      args: [],
    );
  }

  /// `UNIT`
  String get unitUpcase {
    return Intl.message(
      'UNIT',
      name: 'unitUpcase',
      desc: '',
      args: [],
    );
  }

  /// `USD`
  String get usd {
    return Intl.message(
      'USD',
      name: 'usd',
      desc: '',
      args: [],
    );
  }

  /// `PKR`
  String get pkr {
    return Intl.message(
      'PKR',
      name: 'pkr',
      desc: '',
      args: [],
    );
  }

  /// `M`
  String get m {
    return Intl.message(
      'M',
      name: 'm',
      desc: '',
      args: [],
    );
  }

  /// `Mass Balance`
  String get massBalance {
    return Intl.message(
      'Mass Balance',
      name: 'massBalance',
      desc: '',
      args: [],
    );
  }

  /// `Product Segregation`
  String get productSegregation {
    return Intl.message(
      'Product Segregation',
      name: 'productSegregation',
      desc: '',
      args: [],
    );
  }

  /// `Register Broker`
  String get registerBroker {
    return Intl.message(
      'Register Broker',
      name: 'registerBroker',
      desc: '',
      args: [],
    );
  }

  /// `Register Transporter`
  String get registerTransporter {
    return Intl.message(
      'Register Transporter',
      name: 'registerTransporter',
      desc: '',
      args: [],
    );
  }

  /// `Business Partner Contact`
  String get businessPartnerContact {
    return Intl.message(
      'Business Partner Contact',
      name: 'businessPartnerContact',
      desc: '',
      args: [],
    );
  }

  /// `Business Partner Information`
  String get businessPartnerInformation {
    return Intl.message(
      'Business Partner Information',
      name: 'businessPartnerInformation',
      desc: '',
      args: [],
    );
  }

  /// `We found similar results to your details. \nPlease confirm which record to use:`
  String get weFoundSimilarResultsToDetails {
    return Intl.message(
      'We found similar results to your details. \nPlease confirm which record to use:',
      name: 'weFoundSimilarResultsToDetails',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get language {
    return Intl.message(
      'Language',
      name: 'language',
      desc: '',
      args: [],
    );
  }

  /// `GRS`
  String get cottonCertificationGRS {
    return Intl.message(
      'GRS',
      name: 'cottonCertificationGRS',
      desc: '',
      args: [],
    );
  }

  /// `BCI`
  String get cottonCertificationBCI {
    return Intl.message(
      'BCI',
      name: 'cottonCertificationBCI',
      desc: '',
      args: [],
    );
  }

  /// `GOTS`
  String get cottonCertificationGOTS {
    return Intl.message(
      'GOTS',
      name: 'cottonCertificationGOTS',
      desc: '',
      args: [],
    );
  }

  /// `Organic Cotton`
  String get cottonCertificationOrganic {
    return Intl.message(
      'Organic Cotton',
      name: 'cottonCertificationOrganic',
      desc: '',
      args: [],
    );
  }

  /// `Leather Working Group`
  String get cottonCertificationLeather {
    return Intl.message(
      'Leather Working Group',
      name: 'cottonCertificationLeather',
      desc: '',
      args: [],
    );
  }

  /// `OEKO Tex`
  String get cottonCertificationOEKO {
    return Intl.message(
      'OEKO Tex',
      name: 'cottonCertificationOEKO',
      desc: '',
      args: [],
    );
  }

  /// `Other`
  String get cottonCertificationOther {
    return Intl.message(
      'Other',
      name: 'cottonCertificationOther',
      desc: '',
      args: [],
    );
  }

  /// `Goods`
  String get goods {
    return Intl.message(
      'Goods',
      name: 'goods',
      desc: '',
      args: [],
    );
  }

  /// `Processing Facility`
  String get processingFacility {
    return Intl.message(
      'Processing Facility',
      name: 'processingFacility',
      desc: '',
      args: [],
    );
  }

  /// `Register Processing Facility`
  String get registerProcessingFacility {
    return Intl.message(
      'Register Processing Facility',
      name: 'registerProcessingFacility',
      desc: '',
      args: [],
    );
  }

  /// `Facility Name (Business Registration Number)`
  String get searchProcessingFacilityHint {
    return Intl.message(
      'Facility Name (Business Registration Number)',
      name: 'searchProcessingFacilityHint',
      desc: '',
      args: [],
    );
  }

  /// `Type`
  String get type {
    return Intl.message(
      'Type',
      name: 'type',
      desc: '',
      args: [],
    );
  }

  /// `Contact Name`
  String get contactName {
    return Intl.message(
      'Contact Name',
      name: 'contactName',
      desc: '',
      args: [],
    );
  }

  /// `Phone`
  String get phone {
    return Intl.message(
      'Phone',
      name: 'phone',
      desc: '',
      args: [],
    );
  }

  /// `Record by-product`
  String get recordByProduct {
    return Intl.message(
      'Record by-product',
      name: 'recordByProduct',
      desc: '',
      args: [],
    );
  }

  /// `Transformation`
  String get transformation {
    return Intl.message(
      'Transformation',
      name: 'transformation',
      desc: '',
      args: [],
    );
  }

  /// `View list of grievance requests assigned to you.`
  String get messageTutorialRequest {
    return Intl.message(
      'View list of grievance requests assigned to you.',
      name: 'messageTutorialRequest',
      desc: '',
      args: [],
    );
  }

  /// `Requests`
  String get requestHome {
    return Intl.message(
      'Requests',
      name: 'requestHome',
      desc: '',
      args: [],
    );
  }

  /// `Add Products`
  String get addProduct {
    return Intl.message(
      'Add Products',
      name: 'addProduct',
      desc: '',
      args: [],
    );
  }

  /// `Add Products Manually`
  String get addProductsManually {
    return Intl.message(
      'Add Products Manually',
      name: 'addProductsManually',
      desc: '',
      args: [],
    );
  }

  /// `Product ID`
  String get productId {
    return Intl.message(
      'Product ID',
      name: 'productId',
      desc: '',
      args: [],
    );
  }

  /// `Download`
  String get download {
    return Intl.message(
      'Download',
      name: 'download',
      desc: '',
      args: [],
    );
  }

  /// `File error. can't open`
  String get fileInvalid {
    return Intl.message(
      'File error. can\'t open',
      name: 'fileInvalid',
      desc: '',
      args: [],
    );
  }

  /// `Field invalid`
  String get fieldInvalid {
    return Intl.message(
      'Field invalid',
      name: 'fieldInvalid',
      desc: '',
      args: [],
    );
  }

  /// `Product`
  String get product {
    return Intl.message(
      'Product',
      name: 'product',
      desc: '',
      args: [],
    );
  }

  /// `Products`
  String get products {
    return Intl.message(
      'Products',
      name: 'products',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get laborName {
    return Intl.message(
      'Name',
      name: 'laborName',
      desc: '',
      args: [],
    );
  }

  /// `Product List`
  String get productList {
    return Intl.message(
      'Product List',
      name: 'productList',
      desc: '',
      args: [],
    );
  }

  /// `Product already purchased`
  String get productAlreadyPurchased {
    return Intl.message(
      'Product already purchased',
      name: 'productAlreadyPurchased',
      desc: '',
      args: [],
    );
  }

  /// `Product already transformed`
  String get productAlreadyTransformed {
    return Intl.message(
      'Product already transformed',
      name: 'productAlreadyTransformed',
      desc: '',
      args: [],
    );
  }

  /// `Product is invalid or sold`
  String get productAlreadySold {
    return Intl.message(
      'Product is invalid or sold',
      name: 'productAlreadySold',
      desc: '',
      args: [],
    );
  }

  /// `Product already transported`
  String get productAlreadyTransported {
    return Intl.message(
      'Product already transported',
      name: 'productAlreadyTransported',
      desc: '',
      args: [],
    );
  }

  /// `Unable to upload the file`
  String get unableToUploadTheFile {
    return Intl.message(
      'Unable to upload the file',
      name: 'unableToUploadTheFile',
      desc: '',
      args: [],
    );
  }

  /// `Add Input Product`
  String get addInputProduct {
    return Intl.message(
      'Add Input Product',
      name: 'addInputProduct',
      desc: '',
      args: [],
    );
  }

  /// `Add Output Product`
  String get addOutputProduct {
    return Intl.message(
      'Add Output Product',
      name: 'addOutputProduct',
      desc: '',
      args: [],
    );
  }

  /// `Overview`
  String get overview {
    return Intl.message(
      'Overview',
      name: 'overview',
      desc: '',
      args: [],
    );
  }

  /// `Product quantities cannot be automatically converted so <margin of error> cannot be calculated.`
  String get productQuantitiesCantCalculatedMarginError {
    return Intl.message(
      'Product quantities cannot be automatically converted so <margin of error> cannot be calculated.',
      name: 'productQuantitiesCantCalculatedMarginError',
      desc: '',
      args: [],
    );
  }

  /// `Product quantities cannot be automatically converted so <Mass Balance> cannot be calculated.`
  String get productQuantitiesCantCalculatedMassBalance {
    return Intl.message(
      'Product quantities cannot be automatically converted so <Mass Balance> cannot be calculated.',
      name: 'productQuantitiesCantCalculatedMassBalance',
      desc: '',
      args: [],
    );
  }

  /// `Margin of Error`
  String get marginOfError {
    return Intl.message(
      'Margin of Error',
      name: 'marginOfError',
      desc: '',
      args: [],
    );
  }

  /// `Total Inputs`
  String get totalInput {
    return Intl.message(
      'Total Inputs',
      name: 'totalInput',
      desc: '',
      args: [],
    );
  }

  /// `Total Outputs`
  String get totalOutput {
    return Intl.message(
      'Total Outputs',
      name: 'totalOutput',
      desc: '',
      args: [],
    );
  }

  /// `By-product`
  String get byProduct {
    return Intl.message(
      'By-product',
      name: 'byProduct',
      desc: '',
      args: [],
    );
  }

  /// `Duplicate product ID`
  String get duplicateProduct {
    return Intl.message(
      'Duplicate product ID',
      name: 'duplicateProduct',
      desc: '',
      args: [],
    );
  }

  /// `Sale`
  String get sale {
    return Intl.message(
      'Sale',
      name: 'sale',
      desc: '',
      args: [],
    );
  }

  /// `New`
  String get newStatus {
    return Intl.message(
      'New',
      name: 'newStatus',
      desc: '',
      args: [],
    );
  }

  /// `Viewed`
  String get viewed {
    return Intl.message(
      'Viewed',
      name: 'viewed',
      desc: '',
      args: [],
    );
  }

  /// `Response sent`
  String get responseSent {
    return Intl.message(
      'Response sent',
      name: 'responseSent',
      desc: '',
      args: [],
    );
  }

  /// `Indicator/Sub-indicator`
  String get indicatorSub {
    return Intl.message(
      'Indicator/Sub-indicator',
      name: 'indicatorSub',
      desc: '',
      args: [],
    );
  }

  /// `This total weight is required`
  String get totalWeightIsRequired {
    return Intl.message(
      'This total weight is required',
      name: 'totalWeightIsRequired',
      desc: '',
      args: [],
    );
  }

  /// `Upload Receipt or Purchase Record`
  String get uploadReceiptOrPurchaseRecord {
    return Intl.message(
      'Upload Receipt or Purchase Record',
      name: 'uploadReceiptOrPurchaseRecord',
      desc: '',
      args: [],
    );
  }

  /// `Report Number`
  String get reportNumber {
    return Intl.message(
      'Report Number',
      name: 'reportNumber',
      desc: '',
      args: [],
    );
  }

  /// `Failed by:`
  String get failedBy {
    return Intl.message(
      'Failed by:',
      name: 'failedBy',
      desc: '',
      args: [],
    );
  }

  /// `Non-participating {role}`
  String nonParticipatingRole(Object role) {
    return Intl.message(
      'Non-participating $role',
      name: 'nonParticipatingRole',
      desc: '',
      args: [role],
    );
  }

  /// `Non-participating`
  String get nonParticipating {
    return Intl.message(
      'Non-participating',
      name: 'nonParticipating',
      desc: '',
      args: [],
    );
  }

  /// `{field} Contact`
  String partnerContact(Object field) {
    return Intl.message(
      '$field Contact',
      name: 'partnerContact',
      desc: '',
      args: [field],
    );
  }

  /// `{field} Information`
  String partnerInformation(Object field) {
    return Intl.message(
      '$field Information',
      name: 'partnerInformation',
      desc: '',
      args: [field],
    );
  }

  /// `{value} months`
  String valueMonths(Object value) {
    return Intl.message(
      '$value months',
      name: 'valueMonths',
      desc: '',
      args: [value],
    );
  }

  /// `{value} month`
  String valueMonth(Object value) {
    return Intl.message(
      '$value month',
      name: 'valueMonth',
      desc: '',
      args: [value],
    );
  }

  /// `Select date`
  String get selectDate {
    return Intl.message(
      'Select date',
      name: 'selectDate',
      desc: '',
      args: [],
    );
  }

  /// `Danger zone`
  String get dangerZone {
    return Intl.message(
      'Danger zone',
      name: 'dangerZone',
      desc: '',
      args: [],
    );
  }

  /// `If you delete your account, you will lose your account.`
  String get deleteAccountWarning {
    return Intl.message(
      'If you delete your account, you will lose your account.',
      name: 'deleteAccountWarning',
      desc: '',
      args: [],
    );
  }

  /// `Delete my account`
  String get deleteAccount {
    return Intl.message(
      'Delete my account',
      name: 'deleteAccount',
      desc: '',
      args: [],
    );
  }

  /// `Yes, delete`
  String get yesDelete {
    return Intl.message(
      'Yes, delete',
      name: 'yesDelete',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to delete your account? Deleting your account will result in permanently losing access to the platform.`
  String get deleteAccountConfirm {
    return Intl.message(
      'Are you sure you want to delete your account? Deleting your account will result in permanently losing access to the platform.',
      name: 'deleteAccountConfirm',
      desc: '',
      args: [],
    );
  }

  /// `This action cannot be undone.`
  String get deleteAccountWarningDetails {
    return Intl.message(
      'This action cannot be undone.',
      name: 'deleteAccountWarningDetails',
      desc: '',
      args: [],
    );
  }

  /// `Note:`
  String get note {
    return Intl.message(
      'Note:',
      name: 'note',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ur'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
