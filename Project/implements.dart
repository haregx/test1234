import 'classes.dart';

abstract class DatabaseRespository {

  /**
   * CRUD Operations
   */

  /** Questions will never stand for its own
   * they will always be assigned to a promo code
   * so we need to pass the promo code rowGuid as well
   * to identify the correct list of questions
   */

  /** create */
  void addQuestion(QuizQuestion question, String promoCodeRowGuid);
  /** read */
  QuizQuestion? getQuestion(String rowGuid, String promoCodeRowGuid);
  /** delete */
  bool removeQuestion(String rowGuid, String promoCodeRowGuid);
  /** update */
  bool updateQuestion(String rowGuid, QuizQuestion newQuestion, String promoCodeRowGuid);
  /** list all */
  List<QuizQuestion> getAllQuestions(String promoCodeRowGuid);
}


