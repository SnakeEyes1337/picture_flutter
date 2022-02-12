
abstract class NavigatorPageEvent{}

class PageLoadEvent extends NavigatorPageEvent{
  final int currentIndex;

  PageLoadEvent(this.currentIndex);

}
