import '../constants/string_const.dart';
import 'models/day_chip_model.dart';
import 'models/transaction_model.dart';

class AppData {
  static const userName = StringConst.userName;
  static const greeting = StringConst.greeting;
  static const balance = 392.09;
  static const selectedMonthIndex = 6;
  static const selectedDayChipIndex = 7;

  static const months = [
    StringConst.jan,
    StringConst.feb,
    StringConst.mar,
    StringConst.apr,
    StringConst.may,
    StringConst.jun,
    StringConst.jul,
    StringConst.aug,
    StringConst.sep,
    StringConst.oct,
    StringConst.nov,
    StringConst.dec,
  ];

  static const chartPoints = [
    120.0,
    180.0,
    150.0,
    220.0,
    190.0,
    280.0,
    240.0,
    320.0,
    290.0,
    360.0,
    310.0,
    392.09,
  ];

  static const transactions = [
    TransactionModel(
      title: 'Coffee',
      dateLabel: 'Wednesday, 2 July 2025',
      amount: 5.00,
      emoji: '☕',
    ),
    TransactionModel(
      title: 'Burger',
      dateLabel: 'Wednesday, 2 July 2025',
      amount: 7.99,
      emoji: '🍔',
    ),
    TransactionModel(
      title: 'Commute',
      dateLabel: 'Wednesday, 2 July 2025',
      amount: 25.00,
      emoji: '🚕',
    ),
    TransactionModel(
      title: 'Salary',
      dateLabel: 'Tuesday, 1 July 2025',
      amount: 900.00,
      emoji: '🤑',
      isIncome: true,
    ),
    TransactionModel(
      title: 'Pet Care',
      dateLabel: 'Tuesday, 1 July 2025',
      amount: 65.00,
      emoji: '🐶',
    ),
    TransactionModel(
      title: 'Commute',
      dateLabel: 'Tuesday, 1 July 2025',
      amount: 25.00,
      emoji: '🚕',
    ),
    TransactionModel(
      title: 'Coffee',
      dateLabel: 'Tuesday, 1 July 2025',
      amount: 5.00,
      emoji: '☕',
    ),
    TransactionModel(
      title: 'Burger',
      dateLabel: 'Tuesday, 1 July 2025',
      amount: 7.99,
      emoji: '🍔',
    ),
  ];

  static const dayChips = [
    DayChipModel(weekdayLetter: 'W', dayNumber: '25'),
    DayChipModel(weekdayLetter: 'T', dayNumber: '26'),
    DayChipModel(weekdayLetter: 'F', dayNumber: '27'),
    DayChipModel(weekdayLetter: 'S', dayNumber: '28'),
    DayChipModel(weekdayLetter: 'S', dayNumber: '29'),
    DayChipModel(weekdayLetter: 'M', dayNumber: '30'),
    DayChipModel(weekdayLetter: 'T', dayNumber: '01'),
    DayChipModel(weekdayLetter: 'W', dayNumber: '02'),
  ];
}
