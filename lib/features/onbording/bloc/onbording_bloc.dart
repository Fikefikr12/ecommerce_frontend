import 'package:bloc/bloc.dart';
import 'package:ecommerce_frontend/features/onbording/bloc/onbording_event.dart';
import 'package:ecommerce_frontend/features/onbording/bloc/onbording_state.dart';

class OnbordingBloc extends Bloc<OnboardingEvent,OnboardingState>{

  OnbordingBloc() :super(OnboardingState(currentIndex: 0)){
    on<PageChangedEvent>(pageChangedEvent);
     on<NextPageEvent>(nextPageEvent);
     on<SkipEvent>(skipEvent);
  }

   Future<void> pageChangedEvent(PageChangedEvent event,
    Emitter<OnboardingState>emit)async{
     
    emit(OnboardingState(currentIndex: event.index));
    }
     Future<void> nextPageEvent(NextPageEvent event,
    Emitter<OnboardingState>emit)async{
      if(state.currentIndex < 2){
    emit(OnboardingState(currentIndex: state.currentIndex + 1));
      }else{
        emit( OnboardingState(currentIndex: 2,isCompleted: true));
      }
    }
  Future<void> skipEvent(SkipEvent event,
    Emitter<OnboardingState>emit)async{
     
    emit(OnboardingState(currentIndex: 2,isCompleted: true));
    }
}