import 'package:flutter/material.dart';
import 'package:netflixclone/controllers/controller.dart';
import 'package:netflixclone/models/moviemodel.dart';
import 'package:netflixclone/views/widgets/customAppBar.dart';

class SearchScreen extends StatefulWidget {
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  ApiOperations controller = ApiOperations();
  late List<Moviemodel> searchedMovies=[];
  bool isLoading = true;
  Search({required String name}) async {
    searchedMovies = await controller.SearchMovie(context, name);
    setState(() {
      isLoading = false;
    });

  }

  @override
  void initState() {
    // TODO: implement initSta
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
      final TextEditingController _searchController = TextEditingController(); //it is use to fetch data from TextField
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.white,
        title:Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // RichText to display word1 and word2
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: "Ultra",
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                  children: [
                    TextSpan(
                      text: "Flix",
                      style: const TextStyle(
                        color: Colors.orangeAccent,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),

            ],
          ),
        ),
      ),
      body:  SingleChildScrollView(
              child: Column(
                children: [
                  Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(//decorate the container box
          color: const Color.fromARGB(66, 192, 192, 192),
          border: Border.all(color: const Color.fromARGB(33, 13, 5, 5)),
          borderRadius: BorderRadius.circular(25)
        ),
       child: Row(
          children: [
            Expanded(// allow to enter unlimited length charater beyond the screen7
              child: TextField(
                controller: _searchController,
                decoration: const InputDecoration(
                  hintText: "Search Wallpapers",
                  errorBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  focusedErrorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  border: InputBorder.none,
                ),
              ),
            ),
            InkWell(
              onTap: (){
                Search(name:_searchController.text);
              },
              child: const Icon(Icons.search),
            ),
          ],
        )

      ),

                  const SizedBox(
                    height: 15,
                  ),
                  //gridview
                  isLoading? Text("Enter the Movie Name", style:
                    TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    )
                    ,):
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    height: MediaQuery.of(context).size.height,
                    child: GridView.builder(
                      physics: const BouncingScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        mainAxisExtent: 300, //height of the box of grid
                        crossAxisCount: 2,
                        crossAxisSpacing: 13,
                        mainAxisSpacing: 10,
                      ),
                      itemCount: searchedMovies.length,
                      itemBuilder: (context, index) {
                        return Container(
                          height: 400,
                          width: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.amberAccent,
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.network(
                                height: 400,
                                width: 50,
                                fit: BoxFit.cover,
                                searchedMovies[index].image ??
                                    "https://img.freepik.com/premium-psd/state-art-smartphone-design-mock-up_23-2149543586.jpg?w=740"),
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
    );
  }
}
