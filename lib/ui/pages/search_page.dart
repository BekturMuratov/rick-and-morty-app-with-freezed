import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_freezed_example/bloc/character_bloc.dart';
import 'package:rick_and_morty_freezed_example/data/models/character.dart';
import 'package:rick_and_morty_freezed_example/ui/widgets/custom_list_tile.dart';


class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late Character _currentCharacter;
  List<Results> _currentResults = [];
  int _currentPage = 1;
  String _currentSearchStr = '';

  @override
  void initState() {
    if(_currentResults.isEmpty){
      context
          .read<CharacterBloc>()
          .add(
          const CharacterEvent.fetch(
              page:1 ,
              name:'')
      );
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<CharacterBloc>().state;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top:15.0, bottom: 15.0,left: 16.0, right: 16.0),
          child: TextField(
            style: const TextStyle(color: Colors.white),
            cursorColor: Colors.white,
            decoration: InputDecoration(
              filled: true,
              fillColor: const Color.fromRGBO(86, 86, 86, 0.8),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide.none,
              ),
              prefixIcon: const Icon(Icons.search,color: Colors.white,),
              hintText: 'Search Name',
              hintStyle: const TextStyle(color: Colors.white),
            ),
            onChanged: (value){
              _currentPage = 1;
              _currentResults = [];
              _currentSearchStr = value;
              context.read<CharacterBloc>().add(CharacterEventFetch(page:_currentPage, name: value));
            },
          ),
        ),
        Expanded(
          child: state.when(
              loading:(){
                return Center(child:
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const[
                    CircularProgressIndicator(strokeWidth: 2),
                    SizedBox(width: 10,),
                    Text('Loading...'),
                  ],
                )
                );
              },
            loaded:(characterLoaded) {
                _currentCharacter = characterLoaded;
                _currentResults = _currentCharacter.results;
                return _currentResults.isNotEmpty ? _customListView(_currentResults) : const SizedBox();
            },
            error:() => Text('Nothing found...'),
          ),
        ),
      ],
    );
  }

  Widget _customListView(List<Results> currentResults){
    return ListView.separated(
        itemCount: currentResults.length,
        separatorBuilder: (_,index) => const SizedBox(height: 5),
        shrinkWrap:true,
        itemBuilder: (context,index){
          final result = _currentResults[index];
          return Padding(
            padding: const EdgeInsets.only(right: 16.0, left: 16.0, top: 3.0, bottom: 3.0),
            child: CustomListTile(result: result,),
          );
    },
    );
  }
}
