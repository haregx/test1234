import 'classes.dart';
import 'implements.dart';

class QuestionRepository implements DatabaseRespository {
  final List<QuizQuestion> _questions = [];
  final Map<String, List<QuizQuestion>> _promoCodes = {};

  /** Questions will never stand for its own
   * they will always be assigned to a promo code
   * so we need to pass the promo code rowGuid as well
   * to identify the correct list of questions
   */

  @override
  void addQuestion(QuizQuestion question, String promoCodeRowGuid) {
    _questions.add(question);
    _promoCodes.putIfAbsent(promoCodeRowGuid, () => []).add(question);
  }

  @override
  QuizQuestion? getQuestion(String rowGuid, String promoCodeRowGuid) {
    return _promoCodes[promoCodeRowGuid]?.firstWhere((q) => q.rowGuid == rowGuid) ?? null;
  }

  @override
  bool removeQuestion(String rowGuid, String promoCodeRowGuid) {
    final index = _promoCodes[promoCodeRowGuid]?.indexWhere((q) => q.rowGuid == rowGuid);
    if (index != -1) {
      _promoCodes[promoCodeRowGuid]?.removeAt(index!);
      return true;
    }
    return false;
  }

  @override
  bool updateQuestion(String rowGuid, QuizQuestion newQuestion, String promoCodeRowGuid) {
   final index = _promoCodes[promoCodeRowGuid]?.indexWhere((q) => q.rowGuid == rowGuid);
    if (index != -1) {
      _promoCodes[promoCodeRowGuid]?[index!] = newQuestion;
      return true;
    }
    return false;
  }

  @override
  List<QuizQuestion> getAllQuestions(String promoCodeRowGuid) {
    return _promoCodes[promoCodeRowGuid] ?? [];
  }
}