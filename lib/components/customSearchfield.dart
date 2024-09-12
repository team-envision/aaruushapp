import 'package:flutter/material.dart';

class CustomSearchField extends StatelessWidget {
  final String hintText;
  final IconData prefixIcon;
  final Function(String)? onChanged;
  final VoidCallback? onPressed; // Add this parameter for handling onPressed
  final TextEditingController? controller;

  const CustomSearchField({
    Key? key,
    required this.hintText,
    required this.prefixIcon,
    this.onChanged,
    this.onPressed, // Include this parameter
    this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25, right: 25),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        decoration: InputDecoration(
          filled: true,
          fillColor: Color.fromRGBO(29, 29, 29, 1),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.circular(18),
          ),
          disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.circular(18),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
            borderRadius: BorderRadius.circular(18),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.circular(18),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: BorderSide.none,
          ),
          hintText: hintText,
          hintStyle: TextStyle(
              fontSize: 18, fontStyle: FontStyle.italic, fontWeight: FontWeight.w300),
          prefixIcon: IconButton(
            icon: Icon(prefixIcon), // Use the provided prefixIcon
            color: Colors.grey,
            onPressed: (){
              showSearch(context: context, delegate: CustomSearchDelegate());
            }, // Trigger the onPressed callback when pressed
          ),
        ),
      ),
    );
  }
}

class CustomSearchDelegate extends SearchDelegate{
  final List<String> catList = [
    "workshops",
    "hackathons",
    "initiatives",
    "panel-discussions",
    "domain-events",
    "events",
  ];
  @override
  List<Widget>? buildActions(BuildContext context) {

    return[ IconButton(


        onPressed: (){
          query:'';
        }, icon:const Icon(Icons.clear) )];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(onPressed: (){
      close (context,null);
    }, icon:const Icon(Icons.arrow_back)  );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<String>matchQuery=[];
    for(var events in catList ){
      if (events.toLowerCase().contains (query.toLowerCase())) {
        matchQuery.add(events);
      }
      return ListView.builder(itemBuilder:(context,index){
        var result =matchQuery[index];
        return ListTile(
          title: Text(result),

        );
      },itemCount: matchQuery.length,);
    }
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String>matchQuery = [];
    for (var events in catList) {
      if (events.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(events);
      }
    }
    return ListView.builder(itemBuilder: (context, index) {
      var result = matchQuery[index];
      return ListTile(
        title: Text(result),

      );
    }, itemCount: matchQuery.length,);
  }}