
import 'package:flutter/cupertino.dart';

class ProviderData with ChangeNotifier{
    List  _data = [];
    List get datalist => _data ;

    void SetDatachanged(List NewData){
      _data = NewData ;
      notifyListeners();
    }

}