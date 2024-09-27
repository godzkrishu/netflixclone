import 'package:flutter/material.dart';
import 'package:netflixclone/controllers/controller.dart';
import 'package:netflixclone/models/moviemodel.dart';
import 'package:netflixclone/views/widgets/customAppBar.dart';
import 'package:netflixclone/views/widgets/categoryblock.dart';
import 'package:go_router/go_router.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen ({super.key});


  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
   List<Moviemodel> movieList=[];
   List<Moviemodel> categoryList=[];
  bool isMovieLoading=true;
  bool isCatLoading=true;
  ApiOperations controller=ApiOperations();
 Future<void> GetCategoryMovies() async
 {
   try{
     categoryList = await controller.fetchAllMovies(context);
   setState(() {
     isCatLoading = false;
   });
 }
    catch (e) {
  print("Error fetching movies: $e");
  }
  }
   Future<void> GetTrendingMovies() async {
     print("GetTrendingMovies function called");
     try {
       movieList = await controller.fetchAllMovies(context);
       print(movieList);
       setState(() {
         isMovieLoading = false;
       });
     } catch (e) {
       print("Error fetching movies: $e");
     }
   }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    GetTrendingMovies();
    GetCategoryMovies();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar
        (
        centerTitle:true,
        elevation: 0.0,
        backgroundColor: Colors.white,
      // title: Text("HomeScreen"),
       title:CustomAppBar(word1: "Ultra",word2: "Flix",),
      ),
      body: SingleChildScrollView(
        child: Column(

          children: [
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.all(5),
              height: 40,
               width: MediaQuery.of(context).size.width,
              child: Text("Trending Movies",
              style: TextStyle(
                    fontWeight: FontWeight.w600,
                   fontSize: 30,
              ) ,
              ),
            ),
   ///category slider
            isCatLoading
                ? const Center(child: CircularProgressIndicator()) :Container(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: SizedBox(
                  height: 300,
                  width:MediaQuery.of(context).size.width,
                  child:
                  SizedBox(
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: movieList.length,
                      itemBuilder: ((context,index)=>Categoryblock(
                       movie: categoryList[index],
                      )),),
                  )
              ),
            ),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.all(5),
              height: 40,
              width: MediaQuery.of(context).size.width,
              child: Text("All Movies",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 30,
                ) ,
              ),
            ),

          //gridview list
            isMovieLoading
                ? const Center(child: CircularProgressIndicator()) :
            Container(
              margin: const EdgeInsets.symmetric(horizontal:10),

              height:MediaQuery.of(context).size.height*0.9,
              child: GridView.builder(
                physics: const BouncingScrollPhysics(),
                gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisExtent: 300,//height of the box of grid
                  crossAxisCount: 2,
                  crossAxisSpacing: 13,
                  mainAxisSpacing: 10,
                ) ,
                itemCount: movieList.length,
                itemBuilder: (context,index)
                {

                  return InkWell(
                    onTap: ()
                    {
                      context.push('/detail', extra:movieList[index]); // Passing the Moviemodel as extra
                    },
                    child: Container(
                      height: 400,
                      width: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.amberAccent,
                      ),
                      child:
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.network(
                            height: 400,
                            width: 50,
                            fit: BoxFit.cover,
                            movieList[index].image ??
                                "https://static.tvmaze.com/uploads/images/medium_portrait/425/1064746.jpg"),
                      ),
                    ),
                  );
                },
              ),
            ),

          ],
        ),
      ),

    );
  }
}
