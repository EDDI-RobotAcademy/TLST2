class RegisterQuestionInfo {
  final String title;
  // final String writer;
  final String content;
  final int memberId;
  final String categoryType;
  final bool privateCheck;

  static bool registerQuestionResult = false;

  RegisterQuestionInfo(
      this.title,
      // this.writer,
      this.content,
      this.memberId,
      this.categoryType,
      this.privateCheck
      );

}