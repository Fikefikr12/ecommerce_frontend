import 'package:equatable/equatable.dart';

class OnboardingState extends Equatable {
  final int currentIndex;
  final bool isCompleted;
  const OnboardingState({required this.currentIndex,this.isCompleted= false});

  @override
  List<Object?> get props => [currentIndex,isCompleted];
}